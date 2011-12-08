From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 3/6] t1006 (cat-file): use test_cmp
Date: Thu, 8 Dec 2011 19:03:19 +0530
Message-ID: <CALkWK0=NFxAqmOkObqjVmBQ-TQ=hZhWi=ZScMEGibvS2Pu+XqQ@mail.gmail.com>
References: <1323349817-15737-1-git-send-email-artagnon@gmail.com>
 <1323349817-15737-6-git-send-email-artagnon@gmail.com> <vpqiplrchvi.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Dec 08 14:33:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYe6b-00048R-Id
	for gcvg-git-2@lo.gmane.org; Thu, 08 Dec 2011 14:33:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751069Ab1LHNdl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Dec 2011 08:33:41 -0500
Received: from mail-qw0-f53.google.com ([209.85.216.53]:53689 "EHLO
	mail-qw0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750834Ab1LHNdk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Dec 2011 08:33:40 -0500
Received: by qadb15 with SMTP id b15so1671715qad.19
        for <git@vger.kernel.org>; Thu, 08 Dec 2011 05:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=mnpJJjzv/p6RjvHgKVQPYZrYD/WLCCp49Vj3U/+O2n0=;
        b=OM82ivH4dZscVoIKBbStgdT3jX9y1p25BZTV34I9ByPZYzqmNL63P9+FVpNOuUdnkC
         PXovrDh4+vK+qjViN94w+UPL8B3cJ9dRryQhh3Ke7v2nu9nqI527eFKYEj+sgkzHjKj0
         IQ1YzkaukJZ7pU04rqmLi+sF5oLWeC/P+hVQ4=
Received: by 10.224.198.10 with SMTP id em10mr2794482qab.44.1323351220188;
 Thu, 08 Dec 2011 05:33:40 -0800 (PST)
Received: by 10.229.165.194 with HTTP; Thu, 8 Dec 2011 05:33:19 -0800 (PST)
In-Reply-To: <vpqiplrchvi.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186562>

Hi Matthieu,

Matthieu Moy wrote:
> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>
>> =C2=A0test_expect_success "--batch-check with multiple sha1s gives c=
orrect format" '
>> - =C2=A0 =C2=A0test "$batch_check_output" =3D \
>> - =C2=A0 =C2=A0"$(echo_without_newline "$batch_check_input" | git ca=
t-file --batch-check)"
>> + =C2=A0 =C2=A0echo "$batch_check_output" >expect &&
>> + =C2=A0 =C2=A0echo_without_newline "$batch_check_input" | git cat-f=
ile
>> + --batch-check >actual &&
>> + =C2=A0 =C2=A0test_cmp expect actual
>> =C2=A0'
>
> Whitespace damage?

Odd.  Email client issue?  Seems to be fine in the original message [1]=
=2E

[1]: http://article.gmane.org/gmane.comp.version-control.git/186558

-- Ram
