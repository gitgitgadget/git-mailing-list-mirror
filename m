From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Force git submodule update --remote for some branches
Date: Sun, 30 Nov 2014 15:52:32 +0100
Message-ID: <547B2F30.8090003@web.de>
References: <5478B6F1.6070200@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: "Timothy M. Redaelli" <timothy.redaelli@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 30 15:52:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xv5rd-0001HR-5M
	for gcvg-git-2@plane.gmane.org; Sun, 30 Nov 2014 15:52:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751812AbaK3Owg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Nov 2014 09:52:36 -0500
Received: from mout.web.de ([212.227.17.11]:54060 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751679AbaK3Owf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Nov 2014 09:52:35 -0500
Received: from [192.168.178.41] ([79.211.100.170]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0Md4xS-1Xd0mR0vxK-00IDkZ; Sun, 30 Nov 2014 15:52:33
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <5478B6F1.6070200@gmail.com>
X-Provags-ID: V03:K0:C54v4Dk1NCoKkgHrbi0eaZBu7npMMvtqub+GIdH/I5xB3eACfhV
 SrjJeOcsBcHdNgSrPk9TBqiIZsvAvM5lYeDwrgjDqCG0Q1fC3eeDBi0+dBTd0rxO8UD3RBz
 /5YjNkynaljwpCG7lCn7dZYCvMVScqHidiNB9Wyjb+gk/bPzWOtQztOG0VGolMMb+OsoVXq
 jxNeBM1ecOrO+smrj8D2A==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260451>

Am 28.11.2014 um 18:54 schrieb Timothy M. Redaelli:
> I have a repository with a submodule and I'd like to force git to
> checkout the LAST version of the submodule and not the stored one (like
> git submodule update --remote), but only on some branches and without
> the need to remember to add --remote every time you are on this branch.
>
> Is there any way to do it? Maybe using .gitmodules?

Not yet.

But yes, .gitmodules would be the right place to put such a
configuration as then it would be per submodule and also per
(superproject-)branch.

By the way, what do you think the output of git status and
git diff should look like when you updated a submodule to
its branch tip which differs from the commit recorded in
the superproject? Should these changes be displayed or not?
And only if the new tip is a fast-forward of the old or
always?
