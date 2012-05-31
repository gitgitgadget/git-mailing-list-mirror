From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 3/6] merge-recursive: remove i18n legos in conflict messages
Date: Thu, 31 May 2012 20:56:00 +0700
Message-ID: <CACsJy8Dnk6Nnkh94OMx4L-=8CUZK22yG8_BA6EUtW1o+=qyGxg@mail.gmail.com>
References: <1338463242-10618-1-git-send-email-worldhello.net@gmail.com>
 <1338469482-30936-1-git-send-email-pclouds@gmail.com> <1338469482-30936-4-git-send-email-pclouds@gmail.com>
 <20120531135222.GB10523@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 31 15:57:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sa5rj-0005U2-0u
	for gcvg-git-2@plane.gmane.org; Thu, 31 May 2012 15:56:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932383Ab2EaN4d convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 May 2012 09:56:33 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:57698 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932378Ab2EaN4c convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 May 2012 09:56:32 -0400
Received: by wibhj8 with SMTP id hj8so4997395wib.1
        for <git@vger.kernel.org>; Thu, 31 May 2012 06:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=QDGhl1wDVvACsGDGU0nh5xnG58t/XRJAB7VPM2x3fNg=;
        b=kxEOFn5XDzC+g7yMnm5mTdGJwMvBZ/DW7G5W4nmge30/HrY2w0vnwNcCvd3/jzyKvT
         JHeHUNXu1uA1HVG3QCGOMcWrrvW9rnQMKctWJzf0Evr9EW0VNcOZETUv+oegQZ7FLeUf
         KiDhaZuc9IR3G+HbdAhwrRAh/2l8R+9XA3okHBQyY8YPnrPEjVTxQ2vB0D769OpcKSaI
         LGrj2oI+GFHF4fzB2lPhL0Z0wUjASk2O9SW7jTGhzXIogXQh1eTnTxyuR1dU29mQ04T6
         UHhZpIp/nRVfUzRtaboXIn7n8YA2b0h+C0ZRFXpSiplH2CzkMLStScmMhyLFK9bqmMM8
         h4RA==
Received: by 10.216.216.95 with SMTP id f73mr13217428wep.149.1338472591001;
 Thu, 31 May 2012 06:56:31 -0700 (PDT)
Received: by 10.223.64.208 with HTTP; Thu, 31 May 2012 06:56:00 -0700 (PDT)
In-Reply-To: <20120531135222.GB10523@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198901>

On Thu, May 31, 2012 at 8:52 PM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>
>> + =C2=A0 =C2=A0 const char *msg[] =3D {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "CONFLICT (rename/delete=
): %s deleted in %s and renamed in %s. Version %s of %s left in tree.",
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "CONFLICT (modify/delete=
): %s deleted in %s and modified in %s. Version %s of %s left in tree."=
,
>> + =C2=A0 =C2=A0 };
>> + =C2=A0 =C2=A0 const char *renamed_msg[] =3D {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "CONFLICT (rename/delete=
): %s deleted in %s and renamed in %s. Version %s of %s left in tree at=
 %s.",
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "CONFLICT (modify/delete=
): %s deleted in %s and modified in %s. Version %s of %s left in tree a=
t %s.",
>> + =C2=A0 =C2=A0 };
>
> Is lego by sentence ok? =C2=A0i.e., having 4 translated messages:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0CONFLICT (rename/delete): %s deleted in %s=
 and renamed in %s.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0CONFLICT (modify/delete): %s deleted in %s=
 and modified in %s.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Version %s of %s left in tree.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Version %s of %s left in tree at %s.

Yeah, should have separated these sentences, less work for translators.
--=20
Duy
