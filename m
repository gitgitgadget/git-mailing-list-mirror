From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] git-submodule add: Record branch name in .gitmodules
Date: Wed, 24 Oct 2012 21:10:41 +0200
Message-ID: <50883D31.6080705@web.de>
References: <61a31f6bc61d4df322a097e32ba472390c583a81.1350923683.git.wking@tremily.us> <5086ED06.5020406@gmail.com> <5086FFDC.2050700@web.de> <508713DE.7040801@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, wking@tremily.us
To: Nahor <nahor.j+gmane@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 24 21:11:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TR6Lx-0003mS-O3
	for gcvg-git-2@plane.gmane.org; Wed, 24 Oct 2012 21:10:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161101Ab2JXTKq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Oct 2012 15:10:46 -0400
Received: from mout.web.de ([212.227.17.11]:52547 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161085Ab2JXTKp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Oct 2012 15:10:45 -0400
Received: from [192.168.178.41] ([91.3.185.6]) by smtp.web.de (mrweb003) with
 ESMTPA (Nemesis) id 0MYevq-1TwT820OP4-00VMKF; Wed, 24 Oct 2012 21:10:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:16.0) Gecko/20121010 Thunderbird/16.0.1
In-Reply-To: <508713DE.7040801@gmail.com>
X-Provags-ID: V02:K0:++/4obetlGWbOjUne2T10ML89TvnfAV60tFYCrFo7YT
 juUpwEFr1vKK+skuu0gCPEIlhm6R/HOYsoF7Ygsjhu1A4wul+K
 ZXV2A4KsjMs9uWiCsH64Q1rzi3krs0ZPYb/Eqi1PjLGhHvFNQB
 7vth0aWuaBZJX+o0K3rDUcwsgSR/WtGSY60BofXh0LqnVLb/E8
 xaeQPAiDkM570oRgaXGYQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208318>

Am 24.10.2012 00:02, schrieb Nahor:
> On 2012-10-23 13:36, Jens Lehmann wrote:
>> Am 23.10.2012 21:16, schrieb Nahor:
>>> Last issue, the branch that exists in your local repository may not
>>> exist in someone else's repository, either because the branch is
>>> purely local, or because it has a different name on the remote repo.
>>
>> You'll always face this kind of problems with commits too when using
>> submodules, so I don't see that as a problem here.
> 
> Commits can't change or disappear during "normal" git operation (i.e. without using "git push -f" or "git branch -D").
> A commit also has the same id in all the clones repository so there is no issue of a different name between the local and the remote repositories.

But if you forget to push a submodule commit it won't exist in someone
else's repository and so he won't be able to update the submodule after
checking out a commit in the superproject that records that unpushed
submodule commit.
