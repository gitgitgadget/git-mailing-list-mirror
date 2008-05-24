From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rev-parse --symbolic-full-name: don't print '^' if SHA1
 is not a ref
Date: Fri, 23 May 2008 17:02:00 -0700
Message-ID: <7v3ao8r2mf.fsf@gitster.siamese.dyndns.org>
References: <4836D0F1.4090007@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Sat May 24 02:03:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzhEL-0001MO-Gw
	for gcvg-git-2@gmane.org; Sat, 24 May 2008 02:03:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751180AbYEXACP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2008 20:02:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751234AbYEXACP
	(ORCPT <rfc822;git-outgoing>); Fri, 23 May 2008 20:02:15 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:56341 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750994AbYEXACN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2008 20:02:13 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 94BC23692;
	Fri, 23 May 2008 20:02:11 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 0CA89368E; Fri, 23 May 2008 20:02:07 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A8A567A0-2924-11DD-8B17-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82781>

Johannes Sixt <j.sixt@viscovery.net> writes:

> From: Johannes Sixt <johannes.sixt@telecom.at>
>
> The intention of --symbolic-full-name is to not print anything if a
> revision is not an exact ref. But this command:
>
>     $ git-rev-parse --symbolic-full-name --not master~1
>
> still emitted a sole '^' to stdout (provided that there's no other ref at
> master~1).

Well spotted.  Thanks.
