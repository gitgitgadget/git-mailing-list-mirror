From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: submodules
Date: Fri, 03 May 2013 21:51:52 +0200
Message-ID: <51841558.4080004@web.de>
References: <CAH_OBieziOGOJrr=wFS-DbMOH=qzmECDziT9hQNX5GxKvNhGyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: shawn wilson <ag4ve.us@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 03 21:52:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UYM1R-0006gT-M5
	for gcvg-git-2@plane.gmane.org; Fri, 03 May 2013 21:52:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934151Ab3ECTv5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 May 2013 15:51:57 -0400
Received: from mout.web.de ([212.227.15.4]:49894 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934031Ab3ECTv5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 May 2013 15:51:57 -0400
Received: from [192.168.178.41] ([91.3.169.194]) by smtp.web.de (mrweb103)
 with ESMTPA (Nemesis) id 0Lheqz-1UCmiY0xW5-00mc58; Fri, 03 May 2013 21:51:55
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <CAH_OBieziOGOJrr=wFS-DbMOH=qzmECDziT9hQNX5GxKvNhGyw@mail.gmail.com>
X-Enigmail-Version: 1.5.1
X-Provags-ID: V02:K0:GqtG8qPW99z1V4ygExMWJ/cOR+nud3m3z1A5F6R0T6x
 BuLBPST3S20DzimAKzHgktboq9IvkX3Y5mwPDEumTYWzhVSGMa
 XyRx49RuMBtWOMJh3BM5mjjoEGQ/USZfDDwahvd+AyROeLeOSO
 6phR1Mg5vtcvMUjXOMxU5opoilkBdAoNu1vzIxjvFZbMRE8v5n
 hmTqzHzlwG3PKoIDZgWZQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223319>

Am 03.05.2013 15:45, schrieb shawn wilson:
> So, I actually have another question I wasn't able to get to in this
> example (which has color - sorry - less -F displays it decently)
> 
> What is shown here is that trying to add submodules in this repo
> doesn't add the .gitmodules file - I can do it manually, but why isn't
> it adding the file? There's a .git/modules directory populated with
> the right stuff, but no .gitmodules file.
> 
> The initial question I was trying to demonstrate was that I've got a
> repo with submodules. When I push branches to most of the modules, a:
> git branch -r shows them for everyone. However, in one repo/module (I
> think it's a repo created with git --bare --shared) no one else can
> see (or pull) the remote branches and if I make a new clone of that
> repo as myself, I can't see them either. However, those branches are
> there and if I check that repo out on its own (not as a submodule of
> the main repo) I and everyone else can see those remote branches.
> 
> This is git 1.8.2.1 btw.

Thanks for your report. Unfortunately I'm not able to see much in
your attachment, could you please try to reproduce your problem with
a few shell commands and send these inline?
