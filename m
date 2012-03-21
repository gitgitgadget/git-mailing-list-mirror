From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Annoying absolute path for "core.worktree" to submodule
Date: Wed, 21 Mar 2012 20:41:43 +0100
Message-ID: <4F6A2EF7.5090007@web.de>
References: <20120320105243.2e8a489b@christian-hammerl.de> <4F6886A6.3010805@gmail.com> <A5E8E180685CEF45AB9E737A010799802D9872@cdnz-ex1.corp.cubic.cub>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Christian Hammerl <info@christian-hammerl.de>,
	Antony Male <antony.male@gmail.com>
To: "Holding, Lawrence" <Lawrence.Holding@cubic.com>
X-From: git-owner@vger.kernel.org Wed Mar 21 20:42:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SARQ7-0004wO-8C
	for gcvg-git-2@plane.gmane.org; Wed, 21 Mar 2012 20:42:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756542Ab2CUTmA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Mar 2012 15:42:00 -0400
Received: from fmmailgate04.web.de ([217.72.192.242]:41120 "EHLO
	fmmailgate04.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756479Ab2CUTl7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Mar 2012 15:41:59 -0400
Received: from moweb002.kundenserver.de (moweb002.kundenserver.de [172.19.20.108])
	by fmmailgate04.web.de (Postfix) with ESMTP id DB5E07421F9B
	for <git@vger.kernel.org>; Wed, 21 Mar 2012 20:41:57 +0100 (CET)
Received: from [192.168.178.48] ([91.3.178.149]) by smtp.web.de (mrweb001)
 with ESMTPA (Nemesis) id 0LgpYk-1Sfu670D6E-00o6GL; Wed, 21 Mar 2012 20:41:57
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:11.0) Gecko/20120312 Thunderbird/11.0
In-Reply-To: <A5E8E180685CEF45AB9E737A010799802D9872@cdnz-ex1.corp.cubic.cub>
X-Provags-ID: V02:K0:W3N20EKM5XbPeoTdQ/5jlc5SpHxrKkGbYaRMvlADdeW
 762FcUfoKszzBcICwP36gZ/YDWTSHkr5KaeAut6MEdM9FrOL9J
 fjsgoNJiPMJVa5J26/0PmGQiuTU2HYCMbsH4yDzeptIw0rfgvF
 o2RvBogolcFtAthKCiwTDrhulyuHpnbrt5hyoGifs641xzZTUl
 il4PYgSevJIN9AA33Fbjg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193607>

Am 20.03.2012 22:39, schrieb Holding, Lawrence:
> Slightly off topic, but related, what is the recommended way for finding
> the git folder from the top level project or any of the submodules?

Run "git rev-parse --git-dir" inside the repo whose git folder you want to
know.

> And of finding the working tree from inside a hook script?

I would expect hooks to be run in the work tree's top level directory,
but I haven't checked that.
