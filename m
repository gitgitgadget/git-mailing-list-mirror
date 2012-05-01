From: Hilco Wijbenga <hilco.wijbenga@gmail.com>
Subject: Re: Is there any way to make hooks part of the repository?
Date: Tue, 1 May 2012 14:07:21 -0700
Message-ID: <CAE1pOi1Dpjow8mkwtPo2o1Zo9rkk6=hhpLqErG1XwTcn=un17A@mail.gmail.com>
References: <CAE1pOi2hr7ewjo5WVDoW0ipYxDVTckr5M_sHNoOQ323=_k754Q@mail.gmail.com>
	<7vipgf8wve.fsf@alter.siamese.dyndns.org>
	<86r4v3mxf7.fsf@red.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git Users <git@vger.kernel.org>
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
X-From: git-owner@vger.kernel.org Tue May 01 23:07:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPKIB-0007P7-UK
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 23:07:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756263Ab2EAVHX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 May 2012 17:07:23 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:61794 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756109Ab2EAVHW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 May 2012 17:07:22 -0400
Received: by qcro28 with SMTP id o28so2147374qcr.19
        for <git@vger.kernel.org>; Tue, 01 May 2012 14:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=D6I8UpodFNB68E2+HgYOKW+JXkhQulcrMW4l6OO9BvI=;
        b=Ix510lbOQ/NAREw7oyEPIuHZQKKxPQ3RPGkGgfuriyQE13IQzHLpTzUc5jZTRIcyNR
         +wokCvjEeUEae0V4KeOdmx90ThnTnk8K2JdpfATFolWUC9epHht78MFkK8TvGs/mu5zD
         LZ37Ue6E8EiT84df6ZfnggWFw4SD1IccGdtJWqWUuaG1cjuUpc7Spyq2YtoctyfOTsZG
         aNPLBKV531Y1Yaa9k68eELmOU7XURSQIEkkU9i2N7eQnsbUrRxs28cAkhFHV6hsvCFPT
         u8Z7Bj1bS9UlSTgzhQTSFSOIlZjdSo9U0drGKHRw7nbWhfrDEePf8KhzJ2dmL6H9902E
         Pmfw==
Received: by 10.224.184.70 with SMTP id cj6mr10634483qab.77.1335906441960;
 Tue, 01 May 2012 14:07:21 -0700 (PDT)
Received: by 10.229.228.20 with HTTP; Tue, 1 May 2012 14:07:21 -0700 (PDT)
In-Reply-To: <86r4v3mxf7.fsf@red.stonehenge.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196751>

On 1 May 2012 13:57, Randal L. Schwartz <merlyn@stonehenge.com> wrote:
>>>>>> "Junio" =3D=3D Junio C Hamano <gitster@pobox.com> writes:
>
> Junio> By design. =C2=A0Do you want me to include "rm -fr ~hilco" in =
some hook of
> Junio> git.git repository?
>
> This just came up yesterday at $PRIMARY_CLIENT. =C2=A0One idea we kic=
ked
> around was having a convention for storing the hooks-to-be-populated =
in
> ".githooks" in the repository tree, and then having clone notice that
> and offer to install them directly if from a trusted source, or at le=
ast
> move them into a disabled state in .git/hooks otherwise.

I guess it would have to be more than just clone. You are quite likely
to update/add hooks later on.
