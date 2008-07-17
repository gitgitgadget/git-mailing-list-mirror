From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Considering teaching plumbing to users harmful
Date: Thu, 17 Jul 2008 11:29:13 -0700
Message-ID: <7vtzeofjpi.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0807161804400.8950@racer>
 <7vmykhpn6z.fsf@gitster.siamese.dyndns.org>
 <20080717155538.GE11759@fieldses.org>
 <alpine.DEB.1.00.0807171915420.8986@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "J. Bruce Fields" <bfields@fieldses.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jul 17 20:30:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJYFF-0000ub-Jy
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 20:30:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757837AbYGQS3W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 14:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757745AbYGQS3W
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 14:29:22 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:36234 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754916AbYGQS3V (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 14:29:21 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 9D9D430BB5;
	Thu, 17 Jul 2008 14:29:20 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id C8AC530BB0; Thu, 17 Jul 2008 14:29:15 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0807171915420.8986@racer> (Johannes
 Schindelin's message of "Thu, 17 Jul 2008 19:16:37 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 45BEC94E-542E-11DD-869F-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88899>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Is there a way to commit the contents of a tarball without using
>> plumbing?  I occasionally want to track an upstream that I know only as
>> a series of tarballs, so I do something like:
>> 
>> 	cd repo/
>> 	git checkout upstream
>> 	rm -rf *
>> 	tar -xzvf ../new-version.tar.gz
>
> How about "git add -u" and "git add ."?

It would work only if new version never removes files.
