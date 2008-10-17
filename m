From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH try 2] t1301-shared-repo.sh: don't let a default ACL 
 interfere with the test
Date: Thu, 16 Oct 2008 21:30:04 -0700
Message-ID: <7viqrrq1wz.fsf@gitster.siamese.dyndns.org>
References: <1224022020.2699.4.camel@mattlaptop2.local>
 <1224022216.2699.5.camel@mattlaptop2.local>
 <7vzll66c5u.fsf@gitster.siamese.dyndns.org> <48F589EC.6050307@viscovery.net>
 <7vmyh64bgy.fsf@gitster.siamese.dyndns.org> <48F59928.5040502@viscovery.net>
 <7v7i8a47f6.fsf@gitster.siamese.dyndns.org> <48F5A590.3050905@viscovery.net>
 <7vzll5jepj.fsf@gitster.siamese.dyndns.org>
 <1224210520.2952.39.camel@mattlaptop2.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Matt McCutchen <matt@mattmccutchen.net>
X-From: git-owner@vger.kernel.org Fri Oct 17 06:31:58 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kqgzz-00017w-3V
	for gcvg-git-2@gmane.org; Fri, 17 Oct 2008 06:31:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750912AbYJQEa1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Oct 2008 00:30:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750889AbYJQEa1
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Oct 2008 00:30:27 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:34557 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750838AbYJQEa0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Oct 2008 00:30:26 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 63258703F6;
	Fri, 17 Oct 2008 00:30:24 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 20ED8703EC; Fri, 17 Oct 2008 00:30:16 -0400 (EDT)
In-Reply-To: <1224210520.2952.39.camel@mattlaptop2.local> (Matt McCutchen's
 message of "Fri, 17 Oct 2008 02:28:40 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 51030770-9C04-11DD-99D3-1E1F86D30F62-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98446>

Matt McCutchen <matt@mattmccutchen.net> writes:

> As I said in my other message, default ACLs do not break git, they only
> break the way git is being tested in t1301-shared-repo.sh .  There is no
> cause for concern.

Is it also true if the default is too tight?  Wouldn't that interfere with
the attempt to loosen the permission bits by core.sharedrepository?

Just being curious.
