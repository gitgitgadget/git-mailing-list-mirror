From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: defined behaviour for multiple urls for a remote
Date: Mon, 17 Oct 2011 09:11:42 +0530
Message-ID: <CAMK1S_jzMKqA2SQR_q+5xjG_-CFM86cL0QaGvx-TA_sBC=Vh+g@mail.gmail.com>
References: <CAMK1S_jZJuqC6_-eVT7LJFh+DEphbsypS6f4nRb6Qc4-xBa_wQ@mail.gmail.com>
	<loom.20111014T113208-660@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Kirill Likhodedov <Kirill.Likhodedov@jetbrains.com>
X-From: git-owner@vger.kernel.org Mon Oct 17 05:41:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFe5N-0002Bc-Sq
	for gcvg-git-2@lo.gmane.org; Mon, 17 Oct 2011 05:41:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754616Ab1JQDln convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 16 Oct 2011 23:41:43 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:42508 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754487Ab1JQDlm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Oct 2011 23:41:42 -0400
Received: by ywf7 with SMTP id 7so216596ywf.19
        for <git@vger.kernel.org>; Sun, 16 Oct 2011 20:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=8+/CCugMFZ5scIY70i47xRexiEsk1WP+DCuczlEm3dI=;
        b=kIqwCLtc4vpbtJUk3irmMFuj5nWnyGtC0X+rbwYbJdz+eDpEmsDDFjoXYuvAuGNGEa
         YzclfVYjHfY8aMUpDXaqzw+ygknEIuSVqMGCd/nBbEuX8Quzu3wyzgYHPlvCglFLLQ9o
         LBPTGgg6SL4V5mr6fZQWsaJhIMsArdj8Mt5vs=
Received: by 10.182.124.9 with SMTP id me9mr8833683obb.1.1318822902059; Sun,
 16 Oct 2011 20:41:42 -0700 (PDT)
Received: by 10.182.53.73 with HTTP; Sun, 16 Oct 2011 20:41:42 -0700 (PDT)
In-Reply-To: <loom.20111014T113208-660@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183762>

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

well in theory yes, but now that you mention it, 'git remote -v' is suf=
ficient.
