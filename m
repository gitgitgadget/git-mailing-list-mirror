From: fREW Schmidt <frioux@gmail.com>
Subject: Re: broken bash completion
Date: Sat, 5 May 2012 08:57:46 -0500
Message-ID: <CADVrmKRjw6VFQAnQruBmc1OhOaswpOtzb+E8G_KooYiz6SuStA@mail.gmail.com>
References: <4FA14016.8050503@rolf.leggewie.biz> <20120504233213.GF2164@goldbirke>
 <4FA4AB86.8020108@rolf.leggewie.biz> <20120505121319.GG2164@goldbirke> <CAMP44s0q_zeVwzhgeda1=9+Psjr5PaO1QtHT1QC0RwyCpfd=rg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>,
	Rolf Leggewie <foss@rolf.leggewie.biz>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 05 15:58:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQfVX-0007RP-6V
	for gcvg-git-2@plane.gmane.org; Sat, 05 May 2012 15:58:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754518Ab2EEN6I convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 May 2012 09:58:08 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:53492 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754297Ab2EEN6H convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 May 2012 09:58:07 -0400
Received: by vbbff1 with SMTP id ff1so40861vbb.19
        for <git@vger.kernel.org>; Sat, 05 May 2012 06:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=JYnKKBpPPjebU3E7aGdf9ayjx+sLFoj7S6sMQ/7nnN8=;
        b=ynBUfDUiYBrWMA1qfgQ7hlOI/K3k0gN1f7EQwR3L9ewR88uD/LXy75/bZTr8s+s/zN
         N9yb/bblFHUpFhRm0Q46BAON1RB1Sf7gUMY20g+7XepFNAJ5SAXEAOU07gXOJtlIq+7N
         ALwT5pFMZBmZPZF1dSoBBo3PGTgdYDjYD4AML5FBnXBLvfWhluzZypcpk39KmGfdEW7B
         PCv7L7KwVqfosxEZey2Ogre8g0GQsAitjzL9kbLK7LT/PcC/xJlihmUkw8p7r55+f+dM
         T4do7hLA8dDsNleDhspJPNtSP3RgeJ3ZXMtfdY877QUvr2Gec7MTbD7/qkmNMHC8Wfhv
         tL1Q==
Received: by 10.52.77.5 with SMTP id o5mr4454422vdw.47.1336226286338; Sat, 05
 May 2012 06:58:06 -0700 (PDT)
Received: by 10.220.71.196 with HTTP; Sat, 5 May 2012 06:57:46 -0700 (PDT)
In-Reply-To: <CAMP44s0q_zeVwzhgeda1=9+Psjr5PaO1QtHT1QC0RwyCpfd=rg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197113>

On Sat, May 5, 2012 at 8:11 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>
> On Sat, May 5, 2012 at 2:13 PM, SZEDER G=E1bor <szeder@ira.uka.de> wr=
ote:
>
> The reason I started to use the bash completion in zsh is that the zs=
h
> completion goes for 100% correctness, that means 'git checkout <TAB>'
> took literally *minutes* in my machine on the Linux kernel repo. The
> zsh developers said that was OK, and my patch to solve the problem wa=
s
> not, because it would make the result less than 100% correct.

Could you elaborate on how you did that?  I'm suffering from the same
thing and don't see an obvious way to use bash-completion in zsh.

--
fREW Schmidt
http://blog.afoolishmanifesto.com
