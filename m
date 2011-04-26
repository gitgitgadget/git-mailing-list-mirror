From: Victor Engmark <victor.engmark@gmail.com>
Subject: Re: RFC: Folder Git
Date: Tue, 26 Apr 2011 08:47:46 +0200
Message-ID: <BANLkTikkFgCQP9DA5VwMCMzDCiTnEENvOg@mail.gmail.com>
References: <BANLkTim=xKxN9JovToVuOg=SQ2Mba1LvxQ@mail.gmail.com>
	<BANLkTimnyv_+NCc3yOSswJeqHo_zsGwCDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 26 08:48:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEc46-00038K-VW
	for gcvg-git-2@lo.gmane.org; Tue, 26 Apr 2011 08:48:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756906Ab1DZGrt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Apr 2011 02:47:49 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:42939 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756886Ab1DZGrs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Apr 2011 02:47:48 -0400
Received: by bwz15 with SMTP id 15so263320bwz.19
        for <git@vger.kernel.org>; Mon, 25 Apr 2011 23:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=qM+VpOcQg2xOjUu/mh6mVgIKmu6xRQonas1YchJb/7k=;
        b=tg8wqxgaHxceKKas6CvNZm2i76yI3HLRh6zgjmoayoKMddofGQhoSpeQdQspiSUR32
         H44rZ/58JWhYh9ol5xJfigKL75Z/p8c/i6Lf50+gCTeYMZhIyJsIFy6sfJSfaxm0oxNw
         6f+y34UdrlUwlYLgVkRoWl/7aghxwoX/QSliY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=IyMfPftLiq4Zww1T//mzJJmbDaYPw/y4bQa+GngIeJ9hVZjd858DnWz51Fnc8rFOoz
         8yj0alW8db5dVQT7C5fB+UGjm39ndxrMOk8q9tgdDaKKOQVjiz8MeOqHrrS5UsuznR1d
         71TmbLEZoeJNU0uLO2kuA1QbdUXlLxOMMtUL8=
Received: by 10.204.181.7 with SMTP id bw7mr338429bkb.16.1303800466895; Mon,
 25 Apr 2011 23:47:46 -0700 (PDT)
Received: by 10.204.48.143 with HTTP; Mon, 25 Apr 2011 23:47:46 -0700 (PDT)
In-Reply-To: <BANLkTimnyv_+NCc3yOSswJeqHo_zsGwCDA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172068>

On Mon, Apr 25, 2011 at 10:52 AM, Jon Seymour <jon.seymour@gmail.com> w=
rote:
> On Mon, Apr 25, 2011 at 6:32 PM, Victor Engmark
> <victor.engmark@gmail.com> wrote:
> continue to other repositories.
>>
>> Issues:
>> * Don't know if anyone else has used it. Probably not, so there's
>> bound to be issues (especially since it's been changed quite a bit t=
he
>> last couple days for this RFC).
>>
>
> Victor,
>
> Certainly seems like a common need. I had a similar solution which I
> used for a while.
>
> In the end, however, I found that creating a super-module in the top
> directory that contains
> the other git directories as git submodules allowed me to use a
> standard feature of git to achieve the same effect.
>
> So:
>
> =C2=A0 =C2=A0git submodule foreach git gc --aggressive
>
> I know this won't suit every use case, but it does work in an
> environment where the set of repos you are operating on have a degree
> of coherence and it makes sense to set up a submodule for them. =C2=A0=
In
> this particular case this is the only reason why I use submodules - I
> don't use them for configuration management, for example, simply as a
> handy way to exploit git submodule foreach.
>
> Have you considered using git submodules in this way?

I didn't know you could use them this way, and it's a nicely "Gitonic"
way of doing it. I don't think this would fit my case, since the repos
are not much related and it's a more verbose solution which takes
longer to set up than copying a single script. A compromise could be
to set up a Git alias `sgit=3D"git submodule foreach git"`, if that'll
work as expected.

--=20
Victor Engmark
