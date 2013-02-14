From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] git.txt: update description of the configuration mechanism
Date: Thu, 14 Feb 2013 17:23:33 +0100
Message-ID: <vpqzjz6ampm.fsf@grenoble-inp.fr>
References: <1360856214-934-1-git-send-email-Matthieu.Moy@imag.fr>
	<511D0D88.6010302@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, gitster@pobox.com
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Feb 14 17:24:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U61bS-00058N-0O
	for gcvg-git-2@plane.gmane.org; Thu, 14 Feb 2013 17:24:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934673Ab3BNQXn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Feb 2013 11:23:43 -0500
Received: from mx1.imag.fr ([129.88.30.5]:48878 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758097Ab3BNQXm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Feb 2013 11:23:42 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r1EGNWwC019913
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 14 Feb 2013 17:23:32 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1U61av-0000Yp-Mi; Thu, 14 Feb 2013 17:23:33 +0100
In-Reply-To: <511D0D88.6010302@drmicha.warpmail.net> (Michael J. Gruber's
	message of "Thu, 14 Feb 2013 17:15:04 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 14 Feb 2013 17:23:32 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r1EGNWwC019913
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1361463813.39367@K8Z4siz8nAmlhXEuoWhIcA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216318>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Matthieu Moy venit, vidit, dixit 14.02.2013 16:36:
>> The old Git version where it appeared is not useful only to historians,
>> not to normal users. Also, the text was mentioning only the per-repo
>
> I do not think you meant to not remove so many nots ;)

The first was meant to be "now", indeed.

> Besides, if history is uninteresting, then so is sociology: "familiar to
> some people" can go, too.

It can, but I'm fine with keeping it too. It may help some users to
realize "ah, OK, the same ini file I'm used to". And it doesn't really
harm.

>> config file, so add a mention of ~/.gitconfig. Describing in details the
>> system-wide, XDG and all would be counter-productive here, so reword the
>
> Hmpf, I think this gives a way too prominent role to "~/.gitconfig". The
> config files most people will have to deal with are:
>
> - the repo config file
> - the one set by "config --global"
>
> And really, it would often be best if the latter was the XDG thing.

That's a different question. For now, ~/.gitconfig is the default
destination of "config --global" and we should wait for XDG-aware Gits
to be widely deployed before reconsidering that.

If the XDG config file ever become the default, then sure, it will have
to be promoted instead of ~/.gitconfig in git.txt (and I'll be all for
it when it's time, even though I can foresee a few flamewars ;-) ), but
I don't think we should do that now.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
