From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH/RFC] submodule: add ability to shallowly clone any branch
 in a submodule
Date: Sat, 13 Sep 2014 13:21:54 +0200
Message-ID: <541428D2.1080001@web.de>
References: <1410455473-2367-1-git-send-email-cole.minnaar@gmail.com> <5411F620.4000408@web.de> <1410467134-sup-6791@Sasori.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Cole <cole.minnaar@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 13 13:22:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XSlOz-0002eV-LL
	for gcvg-git-2@plane.gmane.org; Sat, 13 Sep 2014 13:22:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751759AbaIMLV5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Sep 2014 07:21:57 -0400
Received: from mout.web.de ([212.227.17.11]:61855 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750750AbaIMLV5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Sep 2014 07:21:57 -0400
Received: from [192.168.178.41] ([79.193.66.205]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0LopeB-1Y0jdY19Mh-00gp0A; Sat, 13 Sep 2014 13:21:55
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.1.1
In-Reply-To: <1410467134-sup-6791@Sasori.local>
X-Provags-ID: V03:K0:pnPIFbEavJGyww+tH1UAPwOXA4BOWm8W2DUZahgxEHoiuYPyUwB
 Rx3FKsnMBy5WgUGYMKH+XO7ZOWfGu8aPF+Yx68FGz0Q2L3Hj1iHCYwhDbdPFRsm8Qe97PQv
 sxuA4+jr7q7dPHiCco5PtqJk50PqYKtnLIhXuFDtKUsLQ05ZhbikO+7r6uhUMAlnAKtO77X
 U05ZY6kTcGMdouNzwm2yQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256964>

Am 11.09.2014 um 22:33 schrieb Cole:
> Thanks for the feedback, really appreciate it, and will try to reformat
> the patches as you have asked.

Thanks!

> When you say you would like the patches split, do you mean into two
> separate threads, or just different patches part of the same thread?

I think you are solving a single problem here (submodule update does
not work with branch and depth), so I'd propose a single thread for
that topic.

> As for --no-single-branch on 'git submodule update', I didn't want to
> break existing functionality, but if you would prefer that to be the
> default I can make it so.

We should discuss if --no-single-branch should be implied when used
with a branch. I believe that if one option needs another one to work,
we should think about implying the latter. But might be wrong on that
with regards to --no-single-branch because I missed something obvious
... ;-)

> Also if there is anything else you are currently looking at regarding
> submodules or thinking about, I would be glad to hear about it or to try
> look at it while I am working on these changes. Or if there is anything
> you can think of for me to check with regards to these changes that
> would also be appreciated.

Sure, I keep a Todo list on the Wiki of my GitHub-repo:

   https://github.com/jlehmann/git-submod-enhancements/wiki#issues-still-to-be-tackled

If you want to work on some of those - or other - topic(s), I'll be
happy to help.

> I am still quite new to some of the git terms and functionality,
> so please excuse me if I do get anything wrong or do not fully understand.

No worries, we're all still learning ;-)
