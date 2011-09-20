From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] Prevent users from adding the file that has all-zero SHA-1
Date: Tue, 20 Sep 2011 20:13:05 +1000
Message-ID: <CACsJy8BU=WnhcHquO0520NR2T6y-OS9RDzCSaE_KyQVCp_uh4A@mail.gmail.com>
References: <1316259574-1291-1-git-send-email-pclouds@gmail.com> <CALkWK0n9kJtUPrpxTmtfH7kVd7CksULjt7bo3cFhOrS_NBVbMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 20 12:13:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5xKf-00081e-FZ
	for gcvg-git-2@lo.gmane.org; Tue, 20 Sep 2011 12:13:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753255Ab1ITKNh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Sep 2011 06:13:37 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:59506 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752140Ab1ITKNg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Sep 2011 06:13:36 -0400
Received: by bkbzt4 with SMTP id zt4so312300bkb.19
        for <git@vger.kernel.org>; Tue, 20 Sep 2011 03:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=5Lb3dCnoQmXxktSSAFfAyQck4dDvoHRDnS+AhWtO14s=;
        b=dpGVNTHDR46tVgHLBwXuVBl6Q7fu/cf5ymU6pSlYks6B5BuvBHZI1JHoe+lyMpC5F4
         7AChsE9cNvLS2g13Lk54CREhBpdtPFncClYOdvqkgsu5kyh85+e8feMlyzg+vQK0/YIo
         lQ1/uadZA3cZWMIJ5douj/fnvDScoUT268qXU=
Received: by 10.204.141.147 with SMTP id m19mr399018bku.339.1316513615115;
 Tue, 20 Sep 2011 03:13:35 -0700 (PDT)
Received: by 10.204.7.1 with HTTP; Tue, 20 Sep 2011 03:13:05 -0700 (PDT)
In-Reply-To: <CALkWK0n9kJtUPrpxTmtfH7kVd7CksULjt7bo3cFhOrS_NBVbMw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181748>

2011/9/20 Ramkumar Ramachandra <artagnon@gmail.com>:
> Hi Nguy=E1=BB=85n,
>
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy writes:
>> This particular SHA-1 has special meaning to git, very much like NUL=
L
>> in C. If a user adds a file that has this SHA-1, unexpected things c=
an
>> happen.
>> [...]
>
> Interesting patch. =C2=A0Is it possible to write some sort of testcas=
e?

Naah. I tested it by explicitly clear the result hash, just before it
gets to my changes, then do "git add <blah>".
--=20
Duy
