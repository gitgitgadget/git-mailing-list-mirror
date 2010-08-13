From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: git rebase -i exec merger broke t3404-rebase-interactive.sh
Date: Fri, 13 Aug 2010 13:20:02 -0400
Message-ID: <D1A252AE-5D4C-4E51-9359-F4A443BB8A2E@silverinsanity.com>
References: <AANLkTinzBuR+9=+PwejJVwSkUiGODaP-RC7=agyLOgMt@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 13 19:26:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ojy1c-00064d-CJ
	for gcvg-git-2@lo.gmane.org; Fri, 13 Aug 2010 19:26:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761902Ab0HMR0b convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Aug 2010 13:26:31 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:49548 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761896Ab0HMR0b convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Aug 2010 13:26:31 -0400
X-Greylist: delayed 378 seconds by postgrey-1.27 at vger.kernel.org; Fri, 13 Aug 2010 13:26:30 EDT
Received: by silverinsanity.com (Postfix, from userid 5001)
	id AB6801FFC135; Fri, 13 Aug 2010 17:20:07 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [10.10.10.10] (cpe-74-67-185-155.rochester.res.rr.com [74.67.185.155])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id 38E521FFC0D5;
	Fri, 13 Aug 2010 17:20:00 +0000 (UTC)
In-Reply-To: <AANLkTinzBuR+9=+PwejJVwSkUiGODaP-RC7=agyLOgMt@mail.gmail.com>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153479>

On Aug 13, 2010, at 12:37 PM, =C6var Arnfj=F6r=F0 Bjarmason wrote:

> 39e388728 (merging git rebase -i exec support) broke the funny names
> test in t3404-rebase-interactive.sh:

Just noticed this myself when your e-mail hit the list.

> This one breaks under bash too, does it work for you Matthieu? If so
> what sort of environment are you executing it in?

Also broken here: OS X 10.6.4 using bash 3.2.48 and dash 0.5.6-20-ga922=
55d

~~ Brian