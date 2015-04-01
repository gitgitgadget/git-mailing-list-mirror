From: Phillip Susi <psusi@ubuntu.com>
Subject: Re: Clone from shallow bundle bug
Date: Wed, 01 Apr 2015 09:30:14 -0400
Message-ID: <551BF2E6.6050000@ubuntu.com>
References: <551B0D37.5070407@ubuntu.com> <CACsJy8C0wMFiPw1thSWN-dPVW+9N=JXDsy_HFCj=Oyu2rf40eg@mail.gmail.com> <551BEA4A.9050708@ubuntu.com> <CACsJy8C4G01LOhg13=rhkCTMGTq-NTHgG-k-kaoT9jALnd7CZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 01 15:31:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YdIje-0006nD-Cv
	for gcvg-git-2@plane.gmane.org; Wed, 01 Apr 2015 15:31:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753185AbbDANbG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Apr 2015 09:31:06 -0400
Received: from mail-qc0-f170.google.com ([209.85.216.170]:35418 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751738AbbDANbE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Apr 2015 09:31:04 -0400
Received: by qcbii10 with SMTP id ii10so17885269qcb.2
        for <git@vger.kernel.org>; Wed, 01 Apr 2015 06:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=wuZBE7XZiG+0DYN46LHPTMlF1n+x9EDSdIwmGezPwqw=;
        b=fMwUOYzFqUOY/jOCj1nWkUYafzOquW4Laek9sjnazF2Av04hYkB/r91154RvPVwuSA
         CCpdQKdBBC6wgaHtc7guY43DdKL2FU5fn7LmzumoYXipcI1/c9Cz2IlWovVReCucQ71o
         a+D3O4ObZdwYhC7OFxjO1/CoJaNWChAu/F1Ldwg90fgyvVAtypPaurdzeK4yV5/P7djT
         syq6//DgV+xE5VZ5En3dIkQekbFKYdHvrO8b7wKO4AaTpmpg97pGWLRoENnwEljA2FVk
         7mKWJSXJ2BfJfbAN6OoAI32kD8ofjosfkyqoOlkh9fIMSxYLWS9dSsxe8dP9N9X4Y2v+
         GxLQ==
X-Received: by 10.140.89.149 with SMTP id v21mr22494563qgd.50.1427895063792;
        Wed, 01 Apr 2015 06:31:03 -0700 (PDT)
Received: from [10.1.1.228] (fl-67-77-88-12.sta.embarqhsd.net. [67.77.88.12])
        by mx.google.com with ESMTPSA id i16sm1258827qkh.5.2015.04.01.06.31.02
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Apr 2015 06:31:03 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <CACsJy8C4G01LOhg13=rhkCTMGTq-NTHgG-k-kaoT9jALnd7CZw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266607>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 4/1/2015 9:09 AM, Duy Nguyen wrote:
>> Strange; it works fine for me using git 1.9.4.msysgit.1, and then
>> I just get the complaints from gitk.  I created the bundle with
>> no prereq argument, i.e. "git bundle create shallow.bundle".  Did
>> you use a prereq argument?
> 
> No, just your command plus a branch name. I tried v1.9.4.msysgit.1 
> (but on linux, not windows), clone rejected too.

Even stranger... when I use a branch name, the clone fails, but not
when I use a detached HEAD.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)

iQEcBAEBAgAGBQJVG/LlAAoJENRVrw2cjl5RKtQH/2TTJ31PtG+3MQjlKjyMhhNZ
Xl/A7QSvruDEUF8V7kdyCYlN4I3EQIelMHeG0tZPWw/qnOPMMvpMvxI2xu3na0xf
L4AopC3XPFCe2kRG4EV17Nf0QAR8zx+ARGhCzf+PzLgGlFdmMsN3TZ/8Oe3yJHSZ
/eu+CPvmvE0N5PeC1EnPoYJwoTcBHFFI5he736OHI5PA8WtekJPQ2SZ17pZttN0p
jmZSeqoUZAe4Jeu+xfE0hYuuoVKtlkat/2GmOKrYcglyuw1+RaU31op+mKkhtGyw
x8yq0LmJ+zMAtj3Ab5fqv0rRrjbNPYeO5uTT+lgHSU62QRPVclv8lkugRyotcMk=
=owOK
-----END PGP SIGNATURE-----
