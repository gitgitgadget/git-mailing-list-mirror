From: Zenaan Harkness <zen@freedbms.net>
Subject: contrib/git-normal-to-bare.sh
Date: Mon, 27 May 2013 14:00:46 +1000
Message-ID: <CAOsGNSSFx7VEOmz4qTt9nz=SXzQCZH7PdZ+gnYVqLhmRmRcT-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=047d7bd6b0f6842fcc04ddab319c
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 27 06:01:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UgocJ-0007VT-Kj
	for gcvg-git-2@plane.gmane.org; Mon, 27 May 2013 06:01:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750821Ab3E0EAs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 May 2013 00:00:48 -0400
Received: from mail-qe0-f42.google.com ([209.85.128.42]:60421 "EHLO
	mail-qe0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750745Ab3E0EAr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 May 2013 00:00:47 -0400
Received: by mail-qe0-f42.google.com with SMTP id cz11so3561815qeb.15
        for <git@vger.kernel.org>; Sun, 26 May 2013 21:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type;
        bh=xAx0wwBv0BGmLOcpNi+KIqUwpnn37R7CVRku+lObWrw=;
        b=BNdPJ04c+qS36pYX8Nd6WmmjYsUsMV+oR3V3ocPto/TOA5x1jSc2y/q47CwyFGTcwi
         CyT+CzttQn8ULmMDWbLKUU2wbx//MjOpfeUWXKm4Ss1SInmI/2sBF2Ri/oVNSFkghlAK
         s1ILXWQNHU5cZUsvdcfI7Dea309pQyrYHQglQ1butlLBtYnyFZ60pawfJgNKonBSPJxS
         YSUdKqzBGbTWYMCVb1UZqzE14qJ9RGZ84BUSxo0dBT4zDFNOM+6AHlm4qkIcPleOABGV
         o+4HfFhuG3fhZxXTpZWQR1VrNnvwK2i+FHS8geTZJN/ySotbjdoml7zOEpADpGuKy67y
         OgDA==
X-Received: by 10.49.51.166 with SMTP id l6mr30377068qeo.4.1369627246725; Sun,
 26 May 2013 21:00:46 -0700 (PDT)
Received: by 10.49.103.201 with HTTP; Sun, 26 May 2013 21:00:46 -0700 (PDT)
X-Google-Sender-Auth: lOm3nsylXV6S-5Be0kllO-liKT4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225574>

--047d7bd6b0f6842fcc04ddab319c
Content-Type: text/plain; charset=ISO-8859-1

This question comes up every now and then - how to convert from normal
to bare, or vice versa.

This is just a start to a basic script to go one way. Needs more tests
etc, but it's enough to get newbies (like me) off to a reasonable
start.

PLEASE CC me, as I am not subscribed.

Thanks,
Zenaan

--047d7bd6b0f6842fcc04ddab319c
Content-Type: application/x-sh; name="git-normal-to-bare.sh"
Content-Disposition: attachment; filename="git-normal-to-bare.sh"
Content-Transfer-Encoding: base64
X-Attachment-Id: file0

IyEvYmluL2Jhc2gKCiMgQ2hhbmdlIG9uZSBvciBtb3JlIG5vcm1hbCByZXBvcyB0byBiYXJlIHJl
cG9zOgojIGh0dHBzOi8vZ2l0Lndpa2kua2VybmVsLm9yZy9pbmRleC5waHAvR2l0RmFxI0hvd19k
b19JX21ha2VfZXhpc3Rpbmdfbm9uLWJhcmVfcmVwb3NpdG9yeV9iYXJlLjNGCgpmb3IgaSBpbiAi
JEAiOyBkbwogICBlY2hvOyBlY2hvICItLS0tLS0tLS0tLS0tLS0tLS0tLS0tIgogICBlY2hvIFBy
b2Nlc3NpbmcgJGkKCiAgIHJlcG89IiRpIgogICByZXBvPSJgYmFzZW5hbWUgJGlgIgogICB0bXBf
cmVwbz0iJHtyZXBvfS5naXQiCgogICAjIEluc2VydCBoZXJlOiBtYXkgYmUgZXhpdCBpZiBhbnkg
c3BhY2VzIGluIHJlcG8gZnFuCiAgICMgSW5zZXJ0IGhlcmU6IGNoZWNrIGZvciBub24tZXhpc3Rl
bnQgcmVwby8uZ2l0IGRpcgogICAjIEluc2VydCBoZXJlOiBjaGVjayB0aGF0IHdlIGFyZSBub3Qg
aW5zaWRlIHRoZSByZXBvCiAgICMgSW5zZXJ0IGhlcmU6IGFkZCBleGl0L2RvLW5vdGhpbmcgaWYg
ZmFpbCB0byBtdiBkaXJzIGV0YwoKICAgbXYgJHJlcG8vLmdpdCAkdG1wX3JlcG8KICAgZ2l0IC0t
Z2l0LWRpcj0kdG1wX3JlcG8gY29uZmlnIGNvcmUuYmFyZSB0cnVlCiAgIHJtIC1yZiAkcmVwbwog
ICBtdiAkdG1wX3JlcG8gJHJlcG8KZG9uZQoK
--047d7bd6b0f6842fcc04ddab319c--
