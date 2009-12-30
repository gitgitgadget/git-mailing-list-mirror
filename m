From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2] Let core.excludesfile default to ~/.gitexcludes.
Date: Wed, 30 Dec 2009 15:31:44 +0100
Message-ID: <vpqhbr8ttwv.fsf@bauges.imag.fr>
References: <4B06A7EE.2090801@atlas-elektronik.com>
	<1258840832-22130-1-git-send-email-Matthieu.Moy@imag.fr>
	<20091230224135.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Wed Dec 30 15:32:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPzal-0000iK-Qt
	for gcvg-git-2@lo.gmane.org; Wed, 30 Dec 2009 15:32:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752776AbZL3Ob7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Dec 2009 09:31:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752749AbZL3Ob7
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Dec 2009 09:31:59 -0500
Received: from mx1.imag.fr ([129.88.30.5]:42068 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752670AbZL3Ob6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Dec 2009 09:31:58 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id nBUEUiV3021803
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 30 Dec 2009 15:30:44 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1NPzaS-0005jG-VN; Wed, 30 Dec 2009 15:31:45 +0100
In-Reply-To: <20091230224135.6117@nanako3.lavabit.com> (Nanako Shiraishi's message of "Wed\, 30 Dec 2009 22\:41\:35 +0900")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 30 Dec 2009 15:30:47 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: nBUEUiV3021803
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1262788248.49542@7RxEi0U5WnHjbqKeuTJQsw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135901>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> Junio, could you tell us what happened to this thread?

I'm not Junio, but I can try ...

Setting a default for core.excludesfile implies that changing it later
is hard. In particular, _if_ we chose one day to move from multiple
$HOME/.gitsomething files to $HOME/something-else/multiple-files
($XDG_CONFIG_HOME and $HOME/.gitglobal/{config,excludes,...} have been
suggested, as well as a $GIT_HOME variable), then the transition is
made harder by having a default.

So, while I think having a default is good, chosing the default
shouldn't be taken lightly.

I personally like the idea of a user config _directory_ with multiple
files in it, but I'm not clear on exactly what it should be, how the
transition plan would be, ...

So, I dropped the patch until we get closer to a consensus on what the
default value should be.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
