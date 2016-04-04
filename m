From: Alexander Rinass <alex@fournova.com>
Subject: Re: git diff does not precompose unicode file paths (OS X)
Date: Mon, 4 Apr 2016 22:43:32 +0200
Message-ID: <9490B637-D3DD-45CC-B2D7-B471AD6B5956@fournova.com>
References: <0008C25D-C3F0-4A1F-8B50-4EF1E84CA04F@fournova.com> <56D97C8C.1060205@web.de> <D9E0FEEC-1987-4045-AD0F-4C7C76DC067B@fournova.com> <56D9D8C6.2060104@ramsayjones.plus.com> <8C785DB2-CEDB-435B-945B-00E4D98DBF99@fournova.com> <56DD41D5.60100@web.de> <5C6A30EF-ED0A-4D64-B971-CF873C64B46E@fournova.com> <56DEC5DD.2070407@web.de> <A81BB0E5-4879-4A86-9019-BB76734BA9EF@fournova.com> <56E7A191.7070302@web.de>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>, git@vger.kernel.org
To: =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Apr 04 22:43:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anBLd-0007xs-D8
	for gcvg-git-2@plane.gmane.org; Mon, 04 Apr 2016 22:43:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756642AbcDDUnh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Apr 2016 16:43:37 -0400
Received: from mail-lf0-f44.google.com ([209.85.215.44]:34349 "EHLO
	mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756142AbcDDUnf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Apr 2016 16:43:35 -0400
Received: by mail-lf0-f44.google.com with SMTP id c62so189051878lfc.1
        for <git@vger.kernel.org>; Mon, 04 Apr 2016 13:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fournova-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=QiltDkhNJ/Sot2VVpkrLXLS9ixUUCUArlRxumvJNevQ=;
        b=elvqy1+W9VF54i02q1WXDAQ0vlyYL5kIvGmma5JpJe1CtoHnC+N3EZQVq8uvuqabdj
         Kz5fVSh+gSzdPN7IVJvhOA4Rl+MqF0UASoB2N82c0lcFl2/g4lo3Q6VEsQhnoKIFp3NU
         0KAgNMNuRCLvi1onC3c0OZzBWCfiVt+izmnJLOgZe5W4BlpI8UJnuIAp0O57prhQNRMs
         xnq8KOLYzYpQn+H4XzEa2h6z7dV+Ak/RAvcKwC69YgX55KSMV8E435X/82A9mHZBSjyH
         iuy8ux0AFBeNdkAsIn/kkjBVmvPptOtYmL2AxUnj9GWoWQQFDmpOfeCuaTwTyearD5Rr
         MWjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=QiltDkhNJ/Sot2VVpkrLXLS9ixUUCUArlRxumvJNevQ=;
        b=MAOEWa3Va8Iy+nR6PLKXo6w3h+JyJe+SSXYME+qRli3xiCjCVv7RdO+w+xv1QFOFnG
         q34ngvgINZPvFYf0s4mD005IZah2BqCMpqZb+0lZ5P3n4bxa4VKJvT0D240648rY7OYN
         CcF6OpW6cncpR54PPPYYwDYixL9gmtmpIu6QejGPk4eanv2prdhBx0pWXC6qqIA6Or+v
         b3yQ5uulkYPFKbw9l8gtuBg03lXOKdC6x0+0TfcyR6qD7K3cGkBufU4PsdF/zOUkVyQp
         DDHfPcfth+n1XplXNm2mnQnB6A/nS0EzGmb9rFqOcwcTlCVUzu3zaqnPoOGkVVlKmdfe
         GUAA==
X-Gm-Message-State: AD7BkJK2374uPsIxzut+7lhhKU+e0a6F74e3UygX/FA4ZknbhwL/+7b/kTnIMaujQ0K/Zg==
X-Received: by 10.194.57.100 with SMTP id h4mr20656786wjq.18.1459802614018;
        Mon, 04 Apr 2016 13:43:34 -0700 (PDT)
Received: from ?IPv6:2a02:908:df42:8b00:f1ae:85b4:7cc0:5166? ([2a02:908:df42:8b00:f1ae:85b4:7cc0:5166])
        by smtp.gmail.com with ESMTPSA id q139sm15832093wmd.2.2016.04.04.13.43.33
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Apr 2016 13:43:33 -0700 (PDT)
In-Reply-To: <56E7A191.7070302@web.de>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290726>


> On 15 Mar 2016, at 06:45, Torsten B=C3=B6gershausen <tboegi@web.de> w=
rote:
>=20
> >I created a test case but git diff exits with 0 if it does not recog=
nize the file >path so the test case always succeeds. Can you give me a=
 hint or one >example test case?
>=20
> The most clean (?) is to compare "git diff" NFC and git diff NFD, the=
y should give the same result:
> for "git diff" something like this would do:
> +
> +# This will test git diff
> +test_expect_success "git diff f.Adiar" '
> +       echo "Modified" >f.$Adiarnfd &&
> +       git diff f.$Adiarnfd >expect &&
> +       git diff f.$Adiarnfc >actual &&
> +       git checkout f.$Adiarnfd &&
> +       test_cmp expect actual
> +=E2=80=99

Thank you!

I had to tweak it a little but it now reproduces the issue and confirms=
 the fix
for diff, diff-index, diff-files and diff-tree.

I have just sent in the full patch.
