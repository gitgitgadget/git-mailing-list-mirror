From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH] Update l10n guide
Date: Fri, 2 Mar 2012 20:18:36 +0800
Message-ID: <CANYiYbG-Gp0cELF7_CxT1veRod+ookBaucfjCpWZjK1kTC0sAQ@mail.gmail.com>
References: <CANYiYbGS_cFTHT1Pkafi9dmzedqezTq8k1tPkYur0b2St_c43Q@mail.gmail.com>
	<7v1upew6d0.fsf@alter.siamese.dyndns.org>
	<7vfwduujxw.fsf_-_@alter.siamese.dyndns.org>
	<CANYiYbE5rcnD_VGJyL2CjS-R5E0pyNSd5TetvH849W6wC5JiAA@mail.gmail.com>
	<7vk434q4eg.fsf@alter.siamese.dyndns.org>
	<CANYiYbE7bxz5=h9gaKf6+N6k5cn6mEKnuf_7KPFAnDrC31UL_w@mail.gmail.com>
	<4F50A55E.8040705@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Mar 02 13:18:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3RRa-0005cq-IZ
	for gcvg-git-2@plane.gmane.org; Fri, 02 Mar 2012 13:18:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756888Ab2CBMSi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Mar 2012 07:18:38 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:46325 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754697Ab2CBMSh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Mar 2012 07:18:37 -0500
Received: by yenl12 with SMTP id l12so717746yen.19
        for <git@vger.kernel.org>; Fri, 02 Mar 2012 04:18:36 -0800 (PST)
Received-SPF: pass (google.com: domain of worldhello.net@gmail.com designates 10.236.181.193 as permitted sender) client-ip=10.236.181.193;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of worldhello.net@gmail.com designates 10.236.181.193 as permitted sender) smtp.mail=worldhello.net@gmail.com; dkim=pass header.i=worldhello.net@gmail.com
Received: from mr.google.com ([10.236.181.193])
        by 10.236.181.193 with SMTP id l41mr12982210yhm.38.1330690716875 (num_hops = 1);
        Fri, 02 Mar 2012 04:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=AwjjiCOeFKFIDc3K34fFpk8X8THXioGXdaFSPgEVw3s=;
        b=PtvW4RW/UW+jLtXgOCa5FhvtU7LtFzOmjbCreiix43NZzKY2DX9GgegPLFFsNZ24ye
         HctACPdAsbZGNMPZseHqUmRj2l2UsiCU/DXTX5Cye1MdX2eNB+z38+0mrg+AlXdVJiP+
         D9aqz/eEPA4qv+akIiUv08YOJrlqYScfU/s2rMZKFoywflzsVuMFsAx0fcHUkkXDfCYC
         EVapRp4+rahXTIqiZP7GIohmEqDkJNwEMbKwQgPFahAYG0gn7ZSOLspoILaByv2WPyVt
         bNYYf6BhmvHOkSLRUAcfbijSV4OvXPYYHCp5nmOSb2OgsgseXSsRexcU0fAlcp402LjT
         n56g==
Received: by 10.236.181.193 with SMTP id l41mr10277304yhm.38.1330690716737;
 Fri, 02 Mar 2012 04:18:36 -0800 (PST)
Received: by 10.236.182.5 with HTTP; Fri, 2 Mar 2012 04:18:36 -0800 (PST)
In-Reply-To: <4F50A55E.8040705@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192031>

2012/3/2 Johannes Sixt <j.sixt@viscovery.net>:
> It does not convert, but it records which encoding the text has. If y=
ou
> don't specify anything, UTF-8 is assumed, and if your text is actuall=
y not
> UTF-8, the result is necessarily garbage.
>
> Then you haven't set i18n.commitEncoding. Try this:
>
> =A0 git config i18n.commitEncoding CP936

I know there are two config variables. i18n.commitEncoding will insert
a "encoding XX" line to the commit object, while i18n.logOutputEncoding
will set the default output encoding. But this implementation seems lik=
e
a workaround.

* Tree objects do not have such implementation, so multibyte characters
   can not be used as filenames.

* Commit object without "encoding" instruction will be used as it is. S=
o
  people under the same non-utf8 locale may not notice that they
  have not set the proper i18n.commitEncoding, until one day they
  need accross platform development.

* As raw commit log alway used as fallback, sometimes it is hard to fin=
d
  commit objects with wrong encoding instructions.

I think save commit object, tree object, packed-refs in UTF-8 is
a better implementation.

--=20
Jiang Xin
