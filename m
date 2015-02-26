From: Stefan Beller <sbeller@google.com>
Subject: compiling master fails
Date: Thu, 26 Feb 2015 12:48:34 -0800
Message-ID: <CAGZ79kaRJg1QzFSyj0iAtUn2nUFxzZRy7BsrYC2++kaN0RD1Aw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 26 21:48:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YR5MN-00012f-V5
	for gcvg-git-2@plane.gmane.org; Thu, 26 Feb 2015 21:48:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753689AbbBZUsg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2015 15:48:36 -0500
Received: from mail-ie0-f171.google.com ([209.85.223.171]:45707 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752483AbbBZUsf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2015 15:48:35 -0500
Received: by iecat20 with SMTP id at20so20913517iec.12
        for <git@vger.kernel.org>; Thu, 26 Feb 2015 12:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=UXFzJEZ4fZuUj2XxNOeVrJRDsDXsMjUJtPyfcBk4Gz4=;
        b=GgnXc7XZPIqYHGk5gIeBlPA9GXdGxVYmq0SENEeVu+TpNo02oMWCsIjpgFacR9JOz+
         4VmiBwjGGz0HTtAPFEQN2DwQiVSm2st6ShFF9KPz1TEjyZ7BxPdB8AUobwCwcRGOAxzh
         3BtYoElAy41pToJIhoL+Vml9EL/NxwzfqvmP9PHFTsKieU3H99hFz5Tfg8iAGtDNr9ut
         9kn3027XtMp4KV3zptojRH/QT7rkF+iTnV2ogaLTEVIbosfKRvsdv0V17Rmbw7U+4T/q
         72hcON6ze1GB7m8Qm5JH1gSXMNW1uO9n9c8dbtmtIzzHqkYl9MFfxvx6cKv9CD0wpHA7
         gqzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=UXFzJEZ4fZuUj2XxNOeVrJRDsDXsMjUJtPyfcBk4Gz4=;
        b=M4Tf65WMBWvBZQ7eAruq0PojVooPovpF7Zk8qx2Xldlh2mL+N/a6+8jcFqEtpfFCbn
         HOd5Eua8mKauowTTukOc1RYpas9Q26C3heDH1GleWg4LKggOPck5DHGAGuFr6oPJxFs1
         m5cyL4FS3e9w6wEiLHLN66XB6G/8BHnllIcBrMg0iQz6DyANYI7CYdeW73ZxCvWUFWw1
         lTS99KWYTzu2tZPQHUCh2tqInos84cz/WDcY11hwxv3hMQ7+3Rp+2q++22ge6s8DmhmD
         ZBewLSCQ4w+jidFBT0wRTFRISw1zTZa6FJzbEFNg80e9isvtAV6fxbo3+Obfe+WxO15o
         iItw==
X-Gm-Message-State: ALoCoQmPKe0k2plSZ0D6trCqngrvByKDQB4UE3Rntzbp7my/eaK9RPnAnIT4tZVGA+kR5aZnz0jn
X-Received: by 10.50.111.202 with SMTP id ik10mr4579166igb.37.1424983714431;
 Thu, 26 Feb 2015 12:48:34 -0800 (PST)
Received: by 10.107.46.31 with HTTP; Thu, 26 Feb 2015 12:48:34 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264457>

On Post 2.3 cyle (batch #5) (v2.3.1-167-g7f4ba4b)

    CC http.o
http.c: In function 'get_preferred_languages':
http.c:1021:2: warning: implicit declaration of function 'setlocale'
[-Wimplicit-function-declaration]
  retval = setlocale(LC_MESSAGES, NULL);
  ^
http.c:1021:21: error: 'LC_MESSAGES' undeclared (first use in this function)
  retval = setlocale(LC_MESSAGES, NULL);
                     ^
http.c:1021:21: note: each undeclared identifier is reported only once
for each function it appears in
make: *** [http.o] Error 1
