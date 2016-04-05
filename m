From: Jacek Wielemborek <d33tah@gmail.com>
Subject: Feature request: config option for default git commit -v
Date: Tue, 5 Apr 2016 16:38:24 +0200
Message-ID: <5703CDE0.7010007@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="1hQ5WDrCqbVeUBa9uEe24Pfdj4nphCvCe"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 05 16:38:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anS7p-00022A-VY
	for gcvg-git-2@plane.gmane.org; Tue, 05 Apr 2016 16:38:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758392AbcDEOid (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Apr 2016 10:38:33 -0400
Received: from mail-lf0-f43.google.com ([209.85.215.43]:35731 "EHLO
	mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752492AbcDEOic (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Apr 2016 10:38:32 -0400
Received: by mail-lf0-f43.google.com with SMTP id c126so12157461lfb.2
        for <git@vger.kernel.org>; Tue, 05 Apr 2016 07:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=to:from:subject:message-id:date:mime-version;
        bh=sPpfLkQLOgr1npv0+ajCiq4M3gI6dyNrmgJeuyNaVQ8=;
        b=xDJlycKNY1c9GJdAfMzejwy8/JdN7ELBCl+2mZS0BExvKCNWTS9vT9HsHQRxduvEPL
         8HIOIWP5LHVROOcDIZ1Zb1+SoxxnvXuNpu3WuMJcmU90Np8P8FBAxwGH9xqmxGlATgx5
         y7lQwdA31zRiL9qjL6WWLqQkwXE8HjIposorbPSqQs5hVlvZLPbyxivxX4R4v/VH7IGi
         MMMemG/FgibeCfQNukVPa/0iQPIENN+EkNlTOISdu7JKt1gu2MQZuDl8cf2F6FI28Juc
         RHDUM5xL8GDWBpsPGyHsWeoI/66lZbLn7DR7/OohUJtn/evgoN6PmoBlqIlJ41V+m+ok
         GIIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:to:from:subject:message-id:date:mime-version;
        bh=sPpfLkQLOgr1npv0+ajCiq4M3gI6dyNrmgJeuyNaVQ8=;
        b=c+P6mx5VENDs1cOvMyHqO/+RQhytHHp4SXShrQ4okF0wmr+t2Rl2b3hbpUeT+WgOiT
         vauGDrV7VBuGi1JJh0jeSXCx7fW63JN5/3QVL/rBRs2x/h/ZCvimQAugmTnx/UxHHFfA
         EmjnPsfkvfzs5jAp6s76HYUd/bOOHB+7NTGRQlpePGTcxhJ/Wnu37vSu3kbY1u0vRxfT
         VpkTFzCVfDq/k6UQSIrgrNk9Ik2MLfbsfx6c4EklRONZ8HtNnI5XVpnlVqLdBkMOnwgg
         cjGjHoQL19dPMV2hhkMwkb0Qrub/Gl+c9Cn8r/ZhZFT4bJCni4HL28eX1K87OvnOq0+V
         ry1g==
X-Gm-Message-State: AD7BkJKZvCmjYjncPdTsNOS1dePoE0kDb313NzOJsL4TlG4U4zUuPH0r2bgXufQc4eqJsg==
X-Received: by 10.25.162.7 with SMTP id l7mr11723555lfe.129.1459867110741;
        Tue, 05 Apr 2016 07:38:30 -0700 (PDT)
Received: from [192.168.0.139] (94-229-220-66.static.espol.com.pl. [94.229.220.66])
        by smtp.googlemail.com with ESMTPSA id g199sm3935032lfe.30.2016.04.05.07.38.29
        for <git@vger.kernel.org>
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 05 Apr 2016 07:38:29 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290783>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1hQ5WDrCqbVeUBa9uEe24Pfdj4nphCvCe
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello,

I'm asking for this one because there's quite a lot of interest
(including me) in this feature and there is no convenient walkaround:

https://stackoverflow.com/questions/5875275/git-commit-v-by-default

Cheers,
d33tah


--1hQ5WDrCqbVeUBa9uEe24Pfdj4nphCvCe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXA83gAAoJEGlViymZXJRvrsAP/1fRUERhAcqhx71R08BU+jBL
eg7BCfZdZEv7wRhL5U++aiwVAETw+LNq9rhYytb6qEuLXp+nD8LEgLGuPooU69iU
iC1tXq2eh6BQ0MdR77cRKGqLSA+VH1f0qj27YNnIZdu+WBIAXHq8KxpAZctw6gb1
ilEhHKAgCAV5aeyYnH+fL7lQSuvOJ8qBW1H5LYd45eNrHkqfpE9X3nVHmvyWKgr+
xLiofx6XtVgzQ44/bgqu0TxCGrWtToPArHM3p+9xM6woluNIISKu9HbOlPGvEtcB
MMu/PRaGBnrYGfPi5wMTi0rEGfbzQqq5X1xyEWIXox7qhjKgyi1LJIAj4WfQ3b9u
Pjhh8rpsLORT8CyextyREXqeZEkZ36n7PD07XSdwh4qR2PZozqBUfbO4LixWF9v8
WtxWickXFcqbOiDNWNTJS3rmjemCGFwEgwBtB71fOQXo68SEZBOkXV5gnSitcxrQ
5U/OVKKUuUfs30V4nmyBSya48klpSGbrbENkevPtCGe5hqsZW6d/Z6KhCZduKjWy
bEZiArw5FrWhoIJz/EoKblL7QGmjtPobk1HMs1XGsiTmNKCY8kqpxRjJtc6PYu8q
CO4oFpCfUTW5yAs9uR7rJkruyZUJ4mJcScy7W2XogTtqrZDSlfdqDEDNpOPFR5Ha
iOsYVW+N8tk9HC8f3uih
=9eO/
-----END PGP SIGNATURE-----

--1hQ5WDrCqbVeUBa9uEe24Pfdj4nphCvCe--
