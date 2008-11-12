From: Bruce Stephens <bruce.stephens@isode.com>
Subject: Re: Change in "git checkout" behaviour between 1.6.0.2 and 1.6.0.3
Date: Wed, 12 Nov 2008 17:44:45 +0000
Message-ID: <80r65gon3m.fsf@tiny.isode.net>
References: <80wsf9ovsp.fsf@tiny.isode.net>
            <491B131D.2050501@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Nov 12 18:46:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0Jn6-0004SZ-QJ
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 18:46:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752000AbYKLRot (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2008 12:44:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751565AbYKLRot
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 12:44:49 -0500
Received: from rufus.isode.com ([62.3.217.251]:47693 "EHLO rufus.isode.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751438AbYKLRot (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2008 12:44:49 -0500
Received: from tiny.isode.net (shiny.isode.com [62.3.217.250]) 
          by rufus.isode.com (smtp internal) via TCP with SMTP 
          id <SRsWDgAJxRaf@rufus.isode.com>; Wed, 12 Nov 2008 17:44:46 +0000
Received: by tiny.isode.net (sSMTP sendmail emulation);
          Wed, 12 Nov 2008 17:44:46 +0000
X-Hashcash: 1:20:081112:git@drmicha.warpmail.net::nrqV2yQAJTVIok5i:00000000000000000000000000000000000000Yh9
X-Hashcash: 1:20:081112:git@vger.kernel.org::D3VuB7Uoe3OIl7PX:0000000000000000000000000000000000000000002PEF
X-Hashcash: 1:20:081112:gitster@pobox.com::d7Mq1xpqiosqClW1:000000000000000000000000000000000000000000000MEc
In-Reply-To: <491B131D.2050501@drmicha.warpmail.net> (Michael J. Gruber's message of "Wed\, 12 Nov 2008 18\:32\:13 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100782>

Michael J Gruber <git@drmicha.warpmail.net> writes:

[...]

> Bisecting gives:
>
>
> 5521883490e85f4d973141972cf16f89a79f1979 is first bad commit
> commit 5521883490e85f4d973141972cf16f89a79f1979
> Author: Junio C Hamano <gitster@pobox.com>
> Date:   Sun Sep 7 19:49:25 2008 -0700
>
>     checkout: do not lose staged removal

I got the same, which is reassuring.

Looks like a deliberate change with (what seems to me to be) an
unfortunate interaction with "git clone -n"
