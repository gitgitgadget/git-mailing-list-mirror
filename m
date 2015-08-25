From: Gabor Bernat <bernat@primeranks.net>
Subject: [FEATURE REQUEST] Filter-branch extend progress with a simple
 estimated time remaning
Date: Tue, 25 Aug 2015 17:01:01 +0200
Message-ID: <CANy2qHdngVjH_tPE6=Aao-A2JWrVb_wt2wdu4EzZDQwM6-t_=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 25 17:01:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUFj5-0000hY-FP
	for gcvg-git-2@plane.gmane.org; Tue, 25 Aug 2015 17:01:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752059AbbHYPBX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Aug 2015 11:01:23 -0400
Received: from mail-wi0-f176.google.com ([209.85.212.176]:35511 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751220AbbHYPBW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Aug 2015 11:01:22 -0400
Received: by wicne3 with SMTP id ne3so18004114wic.0
        for <git@vger.kernel.org>; Tue, 25 Aug 2015 08:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        bh=J1wIGz+X3/F6NVAwgRj3IpN56DiJeC8dakcx7HheNdQ=;
        b=pK6UewPXA4ixDnB9dwSGORSEt0l6o64PRMQVB8fJ1x0MTIxZQKcNTdZxmBpHoqeHEK
         d5sH10W/AJWiqw12uisEH8ykW+b5Rukczk209jNn45dChhpE9HsNM8/QOhwCQyxSI7lM
         36/GLHsnRo3Pe/CYAZFsW1tn20ZNerBOccy1fMwRwxII/mfEDP/RryeuylP5Eun66GO6
         wuTTTXgoB7pKKArvNDxiLa3S9FqzUW8aTsaFjUjzXt2ESCgar9i398cjSfGuxmoKASza
         ysuJwaPLbw0zJVcNMHJuA5OF5/6rUhbR+QARzbo9q85kHN5s+dk1av57DFiMz/e0LGBR
         7NyA==
X-Received: by 10.180.73.244 with SMTP id o20mr5573666wiv.31.1440514880666;
 Tue, 25 Aug 2015 08:01:20 -0700 (PDT)
Received: by 10.28.170.70 with HTTP; Tue, 25 Aug 2015 08:01:01 -0700 (PDT)
X-Google-Sender-Auth: Jf5S7ksHXI-l1FDanqfqyN3Dxus
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276531>

Hello,

So it would be great if the filter-branch beside the Rewrite
f8f0b351ae35ff7ac4bd58078cbba1aa34243779 (523/22625), would also
append a basic ETA signaling the end of the operation.

It could be as simple as the the average number of milliseconds per
step up to this point multiplied with the remaining number of steps,
then convert this into a day:hour:minutes:seconds format. It sound
simple enough, but really handy for long running filter branch
operations. I could also contribute if one could direct me towards the
appropriate files this should go to.

Thanks,

Bern=C3=A1t G=C3=81BOR
