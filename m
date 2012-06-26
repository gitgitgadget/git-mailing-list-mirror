From: Hilco Wijbenga <hilco.wijbenga@gmail.com>
Subject: Re: Master and origin/master diverged
Date: Mon, 25 Jun 2012 19:58:09 -0700
Message-ID: <CAE1pOi1JU1QvYOJeV2qC3EN=b==HE1nn+DvXBGNro0mROctsvQ@mail.gmail.com>
References: <CAE1pOi1Ot0Fyv=2_XYKyUcsKp-m+CkT-miF=jC=wt9Rbz_dXqQ@mail.gmail.com>
 <4FE4C0F7.2080309@gmail.com> <CAE1pOi2MN_c76UBeRzdRbU8s+0LzYVoVcJ13V0di=HQobj+aDg@mail.gmail.com>
 <7v1ul6nbju.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Neal Kreitzinger <nkreitzinger@gmail.com>,
	Git Users <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 26 04:59:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjLzx-0001Pq-K8
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jun 2012 04:59:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755891Ab2FZC6a convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Jun 2012 22:58:30 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:43234 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755420Ab2FZC63 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Jun 2012 22:58:29 -0400
Received: by yenl2 with SMTP id l2so3428810yen.19
        for <git@vger.kernel.org>; Mon, 25 Jun 2012 19:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=HA7zcWPNZ5FxHkG9juY6iipRh38WgF3ND3j1RHGvKVg=;
        b=l/LL2ctvZBBm2F6gnq/N8nsFPZGDgs1qH9z5oVZWFGj0CkYI4FX9chTscUOU0d9e/g
         3SeHVwv9uXV+IalMNveGUJaMsO9wdPSqb6KNfXOBxun20Wvt4And+EagqQF7lkxQ9H3X
         kV0xac03Z+OVdzi0Yz6/A7hmMwLPzHQm91FYLwqHaBITC02Obk6sW7h5VTucZiBeOOvu
         IlpEKYELaKOcLBa91At8XAtuIke59RAgtYDH50L7TkLN0z3QZISCty2yhrfTgcs/NUlw
         GJRcVprw1ENeIHIWvlq1W19QgWJSu0vNOOolW5lOldG7TlCVvEtDAr1ElylIceWTq2HQ
         bgPA==
Received: by 10.236.175.226 with SMTP id z62mr11017484yhl.39.1340679509170;
 Mon, 25 Jun 2012 19:58:29 -0700 (PDT)
Received: by 10.236.29.230 with HTTP; Mon, 25 Jun 2012 19:58:09 -0700 (PDT)
In-Reply-To: <7v1ul6nbju.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200622>

On 22 June 2012 16:59, Junio C Hamano <gitster@pobox.com> wrote:
> Hilco Wijbenga <hilco.wijbenga@gmail.com> writes:
>
>>> Some ways you can prevent it from happening again:
>>> (1) setting your canonical repo config to deny non-ff, and deny del=
etes:
>>> [receive]
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0denyDeletes =3D true
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0denyNonFastforwards =3D true
>>
>> I would *really* like to do that but I need access to the server for
>> that, right? Unfortunately, we use Unfuddle and that means no such
>> access. So no server config changes and no Git hooks.
>
> receive.denyNonFastforwards is a reasonable thing to ask for
> projects with a shared repository workflow, so I suspect hosting
> service providers may want to race adding support for it to win
> customers. =C2=A0Have you asked them?

I agree and I was thinking of doing exactly that. So after your
friendly nudge I sent them an email.

The first (very prompt) reply said they didn't support "custom hooks".
When I explained that I was not asking for a custom hook but that I
simply wanted a Git setting changed, I was informed (again, very
promptly)  that that was quite impossible. :-(

In my opinion, it should be fairly simple for them to create a web UI
to set Git config settings (I can understand they do not want to do it
manually) but they do not seem very interested. A bit surprising and
certainly very disappointing.
