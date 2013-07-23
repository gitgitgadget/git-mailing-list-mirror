From: Stefan Beller <stefanbeller@googlemail.com>
Subject: getting git from kernel.org is failing
Date: Tue, 23 Jul 2013 21:41:44 +0200
Message-ID: <51EEDC78.4000507@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigFDF8439E90EA124D8C4896CC"
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 23 21:41:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1iT2-0001pB-2Z
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jul 2013 21:41:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934057Ab3GWTls (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jul 2013 15:41:48 -0400
Received: from mail-we0-f171.google.com ([74.125.82.171]:58648 "EHLO
	mail-we0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933618Ab3GWTlr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jul 2013 15:41:47 -0400
Received: by mail-we0-f171.google.com with SMTP id q55so3525277wes.2
        for <git@vger.kernel.org>; Tue, 23 Jul 2013 12:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :x-enigmail-version:content-type;
        bh=UtB7/z9IrCThhL3H8NfBcAMkTTald+f/Rxdz3UdG5Jw=;
        b=huUXVdtVgAOsNsLxWB5vdcsUokvhlJPtN1S2YXtXDtyF828zDN4meWnJSalBA7RQLm
         Xs0LEoNsXl8hFr1nmVduOPExglTq7xsPi5Yxu/FaO8Ihc77wwLS+1gjExwAteSW3ckUs
         WAflQIIs4XMD1HwMV4+34Y2Enp4d87kpjDX8KsJfg7muAj3+wAlrpRFTAB3lNPb/vSV8
         6rhJrlZ52v6ZtB/+fUSjDWin/ntJl0xMZ2FzNoXfvgFzxxAhgYjN7QtFtLTA/O4lMitn
         l72fnRk/FpjA42zNqzR+MPYC94eWuGSR+Xbt6+E6A0bCBTXeXYnCYDJeTtMEjJvFEZQ6
         S1Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :x-enigmail-version:content-type;
        bh=UtB7/z9IrCThhL3H8NfBcAMkTTald+f/Rxdz3UdG5Jw=;
        b=ljVGNhJcl07+MxsUYf8NRaHX5Xn850wr4+J9bsV/0a/7QMcXYBHogttUEJqmMH9imF
         NsscNsJZdf4s8kZNlcqV+6V8ADQec5W8t/jX05h00LQjzeprfhzQL/Fjr7gxiLAKSn/u
         tCfzQWZA0lSDOcSU3wDsgrqLqj6fCym8XlqJ1rQpeA381oInBlzFWlocomf0vVfOU3wD
         GmklZt40fwW/gyN4/neGEsxilkiEd9AvTao63CpEn0ch+htTKdQLhFTQGBfPadeK7nIp
         iMWVybyrQl7VJxK9Zu8+sBXqz3hRCVRrsRUn0BOZTVPh0YkNZBY3+pffejCpGNEcFpQm
         b0IQ==
X-Received: by 10.180.77.74 with SMTP id q10mr172367wiw.28.1374608505827;
        Tue, 23 Jul 2013 12:41:45 -0700 (PDT)
Received: from [192.168.1.3] (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id j20sm476310wie.7.2013.07.23.12.41.44
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 23 Jul 2013 12:41:45 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130623 Thunderbird/17.0.7
X-Enigmail-Version: 1.4.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231053>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigFDF8439E90EA124D8C4896CC
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

git clone https://git.kernel.org/cgit/git/git.git
Cloning into 'git'...
error: Unable to get pack index https://git.kernel.org/cgit/git/git.git/o=
bjects/pack/pack-1e2bca8b5127039cff42b1cd3d47767fb577cd4f.idx
error: Unable to get pack file https://git.kernel.org/cgit/git/git.git/ob=
jects/pack/pack-6bfd3af75af71d7bf66a80d6374ac09245ad3ce5.pack
The requested URL returned error: 404 Not found
error: Unable to find bce6db96a333c2d47b07580c5a9207cf10935378 under http=
s://git.kernel.org/cgit/git/git.git
Cannot obtain needed blob bce6db96a333c2d47b07580c5a9207cf10935378
while processing commit 5addd1c7531cc644787cd562a3c22a3b714c7d77.
error: Fetch failed.

as reported by ivegy on freenode/#git-devel

Stefan


--------------enigFDF8439E90EA124D8C4896CC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJR7tx4AAoJEJQCPTzLflhqM8oP/RbeXr7k5p4NhJ8cDsAAbiBA
SWGVO27b6JDLBbeFVCVecza1xAps/fEKHoJn8r3iSHFr8hpI6Y/AxNrWcN5oPA+z
3a0CYhDMX7ABUXy9wnmFlWLZUuIZzHkxaQd1yFY+HE3tzF+Vg4KYQCX/w9eGouqV
MXryCzVq9VVU3//RbDAZzWayl7J71MtQVhPTzKW9G0zfo/mVvs1BEVjEPKXZm/Sy
4cX4Wyk8zEuCyCQh2ARGgB+ug0C/fUQvR1iVKtr8uICVAM/yGPfr5HEIo19M306g
lL634GEm5Fp9Y9bXMiLuJDClNBdOubCoxJdiAFDfWH7aLrq/Okx7pZJR/F4ZnhG/
Fw6gPFCSczIp4reKxzZAf/uC6Lw2I9NBsBOdZyqVIrpVVu7bmEsr2mokAQ/ja+Ta
CE9DZTolBRnkEV6RTwZKvIlwryi32NuCMlD994OQFl+cPkBZ3enWwzmoQdGWHXkR
5W+c5emjsmAvn7/iRBRIYzrVWWMaMq7fJSBIRpi7sTIJ8gyq7zfrgeSrk6XxZKMq
7/H0yCK23OqVkEfHKimiievuyiDJ+ac47KsVWNe89hsa1HiDCuKY1nZMAZz1QT6B
ZUy62x6uAmgoC3cbVUVqSQoKo8wY4HTLx7zmt+phva7cDtObeFiILKzcOfM4cjNT
WzQt+rwFT0xKfIhJFqou
=31pQ
-----END PGP SIGNATURE-----

--------------enigFDF8439E90EA124D8C4896CC--
