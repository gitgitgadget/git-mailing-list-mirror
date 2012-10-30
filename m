From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Can't understand the behaviour of git-diff --submodule
Date: Tue, 30 Oct 2012 22:17:14 +0100
Message-ID: <509043DA.6040606@web.de>
References: <CAC9WiBgzbsury2f9FyAu=Pgn31f2uCtq7AvsVWGWEwoV6KbyjA@mail.gmail.com> <508ADFAE.1050800@web.de> <CAC9WiBjiHLJggUzmmx4sPpXNNq=Kz0TOZAzmRShc1AZcPjGvig@mail.gmail.com> <508AED26.3090805@web.de> <CAC9WiBhZWJihPToMawPCxEVkTKL0e-GzUw3qneJMUx-WqSNbjw@mail.gmail.com> <508C6823.5060800@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Francis Moreau <francis.moro@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 30 22:17:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTJBq-0000sh-Ia
	for gcvg-git-2@plane.gmane.org; Tue, 30 Oct 2012 22:17:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934643Ab2J3VRW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2012 17:17:22 -0400
Received: from mout.web.de ([212.227.17.11]:64120 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934532Ab2J3VRT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2012 17:17:19 -0400
Received: from [192.168.178.41] ([91.3.154.28]) by smtp.web.de (mrweb002) with
 ESMTPA (Nemesis) id 0MHYHE-1TWcZF2DnA-003xYZ; Tue, 30 Oct 2012 22:17:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:16.0) Gecko/20121026 Thunderbird/16.0.2
In-Reply-To: <508C6823.5060800@web.de>
X-Enigmail-Version: 1.4.5
X-Provags-ID: V02:K0:MjtSwLWdC7zGBKdF+iqLhV08839nDmkgQpYXUzg/zgx
 3eORtgdoJcoZBB4bk+G5J6nLrDY0nZzrEejW9XJB2bNwjI1/C4
 3ZCKMDs/SWsfwMiF9+dG6lo3DQQRhVXKtKZ3TCPt0Oo9HJvm2z
 SRnXwHqB429x7ZmGcjIJdF7O29S2boeDC4vBN3dW2joIw6F3Ux
 gbeRwFYHfSCxxabrAl8hQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208737>

Am 28.10.2012 01:02, schrieb Jens Lehmann:
> Am 26.10.2012 22:43, schrieb Francis Moreau:
>> On Fri, Oct 26, 2012 at 10:05 PM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
>> [...]
>>>
>>> That is weird, "git diff --submodule" should show that too. Is there
>>> anything unusual about your setup? (The only explanation I can come
>>> up with after checking the code is that your submodule has neither a
>>> .git directory nor a gitfile or the objects directory in there doesn't
>>> contain these commits)
>>
>> Oh now you're asking, I think the submodule has been added by using
>> the --reference option of git-submodule-add.
>>
>>   $ cd configs
>>   $ cat .git
>>   gitdir: ../.git/modules/configs
> 
> Thanks, I suspect the --reference option makes the difference here,
> I'll check that as soon as I find some time.

Since 1.7.11 and 1.7.10.3 git does handle submodules with alternates
(which is what --reference uses) correctly. What version are you
seeing this problem with?
