From: Phillip Susi <psusi@ubuntu.com>
Subject: Re: Why can't I stash submodule changes?
Date: Mon, 06 Apr 2015 11:14:52 -0400
Message-ID: <5522A2EC.9050100@ubuntu.com>
References: <CAAKwDd8SVA=ynzH_U1M3bb+mLZMnF79-imBLrU+x9qcbXfWO3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Shane da Silva <shane@dasilva.io>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 06 17:16:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yf8lA-0000eW-Em
	for gcvg-git-2@plane.gmane.org; Mon, 06 Apr 2015 17:16:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752807AbbDFPQN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Apr 2015 11:16:13 -0400
Received: from mail-qk0-f177.google.com ([209.85.220.177]:33302 "EHLO
	mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751264AbbDFPQN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2015 11:16:13 -0400
Received: by qkx62 with SMTP id 62so26302694qkx.0
        for <git@vger.kernel.org>; Mon, 06 Apr 2015 08:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:message-id:date:from:user-agent:mime-version:to:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=JTvKdgcf+RSxtDNpKrOIrBiPGRjLH3YD6yO7YTOV3TA=;
        b=qTbGSbCSvWylrG0LYTC6Q/47bRq2ArZRYk2JaHFjy+sHut4KWUrs9NrVzxXnQ4Oyr4
         Nqm1JcU1M3mhzz6EAD8VakwLULxl8pqRl6DvAl4t75o/GBYx7FFE1gqCCQdyETwlEeE3
         ykgPklBCYHBRDTgUKnv2WqHE/LNRsH5wc9ubh8iI1yqL8kWlRLeqhgD/TqA5bq1olivm
         H8RmeGmL1iiJmpHKj1CP1IuXP0fV/nkEGjeqntIr77s8BnVureIM0Vnk0ZM+yj4cMW71
         w5P0pNL/bfbJyQ6t626BWNOg7XXFOdMDyjT00YIK77xOnnYgjSVOqBH5gjJPwt+uWKYb
         qVSg==
X-Received: by 10.55.40.10 with SMTP id o10mr28538503qkh.55.1428333372340;
        Mon, 06 Apr 2015 08:16:12 -0700 (PDT)
Received: from [10.1.1.228] (fl-67-77-88-12.sta.embarqhsd.net. [67.77.88.12])
        by mx.google.com with ESMTPSA id l49sm3390604qgd.21.2015.04.06.08.16.10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Apr 2015 08:16:11 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <CAAKwDd8SVA=ynzH_U1M3bb+mLZMnF79-imBLrU+x9qcbXfWO3g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266874>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 4/5/2015 10:15 PM, Shane da Silva wrote:
> I=E2=80=99m trying to wrap my head around why this is the current beh=
avior,
> as I suspect this is intentional but it seems unexpected. If anyone
> can shed any light on this, I would really appreciate it!

Why would you expect anything else?  You have no local changes ( since
you committed them already ).  In other words, git status shows no
uncommitted changes, so there is nothing to stash.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)

iQEcBAEBAgAGBQJVIqLsAAoJENRVrw2cjl5RFGsIAIC38/iZTQsYWfeS8mOt3DVY
jrRCrbfHcjQyKWsEk2seupEV1K1OO0lPhocRE4+3T+vAz3n9Wdc+ATuXNv41vmkY
r2R3VaTXimLw6NfaSxMfqEb4xL/9M0UhUS7SdEALVEApS4AySxYKWKL+RoqF0LWD
JgP6DHCzOLBy8cttaQppZdfRHa34FUmeH1k7m6r/14tarwcc+a3glVqW7i3gue7z
s3zhEkd+dqgab79TNj1gh86UE016UmG7yjbBTWKnNrYdTCW5IBCDqsp0We2PH1Jy
2QPckedCisroZjq0I4uAbuUCm94obiEJKclbY+Wl4sVdYb9rralBOJnPkKwRsiw=3D
=3D4ekO
-----END PGP SIGNATURE-----
