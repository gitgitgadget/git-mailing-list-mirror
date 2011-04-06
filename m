From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: blobs (once more)
Date: Wed, 06 Apr 2011 13:06:21 +0200
Message-ID: <vpqmxk3prki.fsf@bauges.imag.fr>
References: <BANLkTim3kg1ycGkgWsqaZiqMY9LTKV6DBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Pau Garcia i Quiles <pgquiles@elpauer.org>
X-From: git-owner@vger.kernel.org Wed Apr 06 13:06:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7QZZ-00065x-Jj
	for gcvg-git-2@lo.gmane.org; Wed, 06 Apr 2011 13:06:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754965Ab1DFLGi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2011 07:06:38 -0400
Received: from mx1.imag.fr ([129.88.30.5]:33043 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754808Ab1DFLGh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2011 07:06:37 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id p36B6LPT026032
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 6 Apr 2011 13:06:21 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Q7QZ4-0001GO-6W; Wed, 06 Apr 2011 13:06:22 +0200
In-Reply-To: <BANLkTim3kg1ycGkgWsqaZiqMY9LTKV6DBw@mail.gmail.com> (Pau Garcia
	i. Quiles's message of "Wed, 6 Apr 2011 10:09:18 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 06 Apr 2011 13:06:21 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p36B6LPT026032
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1302692784.09773@F9y/181wJCoXYr4HXerxgw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170964>

Pau Garcia i Quiles <pgquiles@elpauer.org> writes:

> I have read about:
> - submodules + using different repositories once one "blob repository"
> grows too much. This will be probably rejected because it is quite
> contrived.
> - git-annex (does not get the files in when cloning, pulling, checking
> out; you need to do it manually)
> - git-media (same as git-annex)
> - boar (no, we do not want to use a VCS for binaries in addition to git)
> - and a few more
>
> So far the only good solution seems to be git-bigfiles but it's still
> in development.

This seems to be the hot topic of the moment in Git ;-). Loot at the
mailing-list's archive, like

http://thread.gmane.org/gmane.comp.version-control.git/170649
https://git.wiki.kernel.org/index.php/SoC2011Ideas#Better_big-file_support

there may be a GSoC on the topic. I don't think there's a really good
solution for you right now (but I didn't really look closely), but the
situation is improving.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
