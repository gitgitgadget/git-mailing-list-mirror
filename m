From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Can't understand the behaviour of git-diff --submodule
Date: Sun, 28 Oct 2012 01:02:59 +0200
Message-ID: <508C6823.5060800@web.de>
References: <CAC9WiBgzbsury2f9FyAu=Pgn31f2uCtq7AvsVWGWEwoV6KbyjA@mail.gmail.com> <508ADFAE.1050800@web.de> <CAC9WiBjiHLJggUzmmx4sPpXNNq=Kz0TOZAzmRShc1AZcPjGvig@mail.gmail.com> <508AED26.3090805@web.de> <CAC9WiBhZWJihPToMawPCxEVkTKL0e-GzUw3qneJMUx-WqSNbjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Francis Moreau <francis.moro@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 28 01:03:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSFPP-0002zA-Ax
	for gcvg-git-2@plane.gmane.org; Sun, 28 Oct 2012 01:03:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752026Ab2J0XDD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Oct 2012 19:03:03 -0400
Received: from mout.web.de ([212.227.15.4]:59986 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751885Ab2J0XDB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Oct 2012 19:03:01 -0400
Received: from [192.168.178.41] ([91.3.186.112]) by smtp.web.de (mrweb101)
 with ESMTPA (Nemesis) id 0Lrs70-1TGjOM0HqI-012xRx; Sun, 28 Oct 2012 01:03:00
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:16.0) Gecko/20121010 Thunderbird/16.0.1
In-Reply-To: <CAC9WiBhZWJihPToMawPCxEVkTKL0e-GzUw3qneJMUx-WqSNbjw@mail.gmail.com>
X-Provags-ID: V02:K0:kSGDwT9MV1XfPPba9KgmJ1Rf7sQE1cfCuCabZWk0mPw
 rAdCdZ0L3FigSTzfcAdzc40TL8VvDXy7qwtAgUE3m9aQp0JCeX
 9BqMcKbHOtJUYic6+IhS7TR8wtWwFtZvyaNax0zQOUsGBwzDTW
 al3UrbjOIKE/OIjPqntYP+yUPeGXuh9xTSE+D9+iRcRkpVTF19
 T35nV8xnG1KSVjtAGLe6g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208516>

Am 26.10.2012 22:43, schrieb Francis Moreau:
> On Fri, Oct 26, 2012 at 10:05 PM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
> [...]
>>
>> That is weird, "git diff --submodule" should show that too. Is there
>> anything unusual about your setup? (The only explanation I can come
>> up with after checking the code is that your submodule has neither a
>> .git directory nor a gitfile or the objects directory in there doesn't
>> contain these commits)
> 
> Oh now you're asking, I think the submodule has been added by using
> the --reference option of git-submodule-add.
> 
>   $ cd configs
>   $ cat .git
>   gitdir: ../.git/modules/configs

Thanks, I suspect the --reference option makes the difference here,
I'll check that as soon as I find some time.
