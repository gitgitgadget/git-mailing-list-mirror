From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: defined behaviour for multiple urls for a remote
Date: Fri, 14 Oct 2011 19:31:43 +0530
Message-ID: <CAMK1S_jW5Fgv7j2w=xu8MMe_gaFFZNe+W4+Bvf1OrMR2rXQhCQ@mail.gmail.com>
References: <CAMK1S_jZJuqC6_-eVT7LJFh+DEphbsypS6f4nRb6Qc4-xBa_wQ@mail.gmail.com>
	<loom.20111014T113208-660@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Kirill Likhodedov <Kirill.Likhodedov@jetbrains.com>
X-From: git-owner@vger.kernel.org Fri Oct 14 16:01:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REiKb-0005kA-Kq
	for gcvg-git-2@lo.gmane.org; Fri, 14 Oct 2011 16:01:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756814Ab1JNOBp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Oct 2011 10:01:45 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:59200 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755039Ab1JNOBo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Oct 2011 10:01:44 -0400
Received: by qadb15 with SMTP id b15so866652qad.19
        for <git@vger.kernel.org>; Fri, 14 Oct 2011 07:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=pI4Z2OKuNuqlJ2LN2b1IMmTs/GSWuVQP4S5YH+QRDk4=;
        b=FTSmHCg86BMck3Jbt43gdr1UHTcONzj0WPRxX3015BC6IADrmJxpnz6XEMYNhh8ZMZ
         hzUgodJ47L0RtQGgxazXNNSQN6exytks3k7I7l3lABL1ADokXL4s7Bh6Dp5tE9lK4Ssk
         aYkvXbIGd9Yto9N1Y/C5K3Czg8LFa/TIcqwLo=
Received: by 10.224.31.8 with SMTP id w8mr2089633qac.43.1318600903833; Fri, 14
 Oct 2011 07:01:43 -0700 (PDT)
Received: by 10.224.20.67 with HTTP; Fri, 14 Oct 2011 07:01:43 -0700 (PDT)
In-Reply-To: <loom.20111014T113208-660@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183576>

On Fri, Oct 14, 2011 at 3:06 PM, Kirill Likhodedov
<Kirill.Likhodedov@jetbrains.com> wrote:
> Sitaram Chamarty <sitaramc <at> gmail.com> writes:
>
>> What's the defined behaviour if I do this:
>>
>> [remote "both"]
>> =C2=A0 =C2=A0 =C2=A0 url =3D https://code.google.com/p/gitolite/
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 url =3D git <at> github.com:sitaramc/git=
olite.git
>>
>> I know what I'm seeing (a fetch only goes to the first URL, and does=
 a
>> HEAD->FETCH_HEAD because I didn't provide a refspec line, while a pu=
sh
>> seems to push all to both), but I was curious what the official
>> position is, because I couldn't find it in the docs.
>
> Please see the message from Linus about that: http://marc.info/?l=3Dg=
it&m=3D116231242118202&w=3D2

cool; thanks!

> You also may check how Git understands your remotes by running
> =C2=A0git remote -v

Aah that's very clear!

> It will show, where it is going to fetch from and push to.
>
> I agree though, that documentation should be updated.

well if it never came up once in the 5 years since Linus wrote that ema=
il... :-)
