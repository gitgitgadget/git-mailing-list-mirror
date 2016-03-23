From: larsxschneider@gmail.com
Subject: [PATCH v3 0/2] git-p4: fix AsciiDoc formatting
Date: Wed, 23 Mar 2016 11:59:00 +0100
Message-ID: <1458730742-88607-1-git-send-email-larsxschneider@gmail.com>
Cc: gitster@pobox.com, luke@diamand.org,
	Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 23 11:59:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aigVM-0000MX-Pn
	for gcvg-git-2@plane.gmane.org; Wed, 23 Mar 2016 11:59:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754085AbcCWK7J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2016 06:59:09 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:35493 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751741AbcCWK7H (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2016 06:59:07 -0400
Received: by mail-wm0-f52.google.com with SMTP id l68so190076678wml.0
        for <git@vger.kernel.org>; Wed, 23 Mar 2016 03:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=vSe1W05XrJ6FIvZVMNLYuEUylN2UQCDgqPqOhKEieNA=;
        b=HZAU9FDjcQ9C9Wmeiin//fbaqMu0IqMgRpTterX/ymnuctAIxIKA+zA3Ks0Y6Z8aoK
         m8iajqpX2mamTw3zHN+3Ye1ve/R3Y8uTK+oaz7DG3BgJVACnB9rJy30AjtQPMOuH795M
         21NdOKBDuOMFwdX6foWMzTJMhydy6nf+VxlB5Sz87E2SomRHKCQ+7XBonskCL0IA2ndB
         Z7tSbUesyo5pDZT5AVyH1EqI54mW62a2IOk3ns+q/M4ktuWsmVzCtGjqZCfKJ/9KTwyC
         FWSKDXeZPmfQfRoC4Tk+VDd0kcp/YNVXnBoMoELzIQTf3z1KmxnbqERIxF1ycxNMVDt/
         4XRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vSe1W05XrJ6FIvZVMNLYuEUylN2UQCDgqPqOhKEieNA=;
        b=H7A8pC66PUTCPp3PGeUaf5ozFN/KwFi/IyQtZDE/8JsOPGXc3j6/oV55yy9TEDClqX
         PcRta8WUbC/YmEIYgQ1N+1Ql/UFz3Trhg7A5zskn6Cf+2MUs3m8EjrSdmBKIB/hpknbv
         xrW+SwOUWGnvotuxqdeX/lKg3AQGPuy/qh2DMD8vDCZP1yN6BsjKI+cgrvnP2TvGf7Ex
         b6blIYuvYqct6U77U0Txw3uZfUVIe7N8z59jpNB4IfIPOydTY/H0jCckMSHX8euV39am
         /78mfx6JqRO73ta3bZ5SOht9rcZFCsuBx9yzKhwx9qUoBSU2yN8Zj+r/7hvMvGJCg+fF
         Tdig==
X-Gm-Message-State: AD7BkJIlV9sBHytHkXsp2i7qbGx+EXQJc/utkfE98SPf+gQQAOuMGTa5Oi5Sq0DWtYvXcw==
X-Received: by 10.194.5.36 with SMTP id p4mr2658279wjp.167.1458730745583;
        Wed, 23 Mar 2016 03:59:05 -0700 (PDT)
Received: from slxBook3.fritz.box (p508BA3D3.dip0.t-ipconnect.de. [80.139.163.211])
        by smtp.gmail.com with ESMTPSA id j18sm21764781wmd.2.2016.03.23.03.59.04
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 23 Mar 2016 03:59:04 -0700 (PDT)
X-Mailer: git-send-email 2.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289645>

From: Lars Schneider <larsxschneider@gmail.com>

diff to v2:
* mimick git-commit instead of git-bisect-lk2009 for references

Thanks,
Lars

Lars Schneider (2):
  Documentation: fix git-p4 AsciiDoc formatting
  Documentation: use ASCII quotation marks in git-p4

 Documentation/git-p4.txt | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

--
2.5.1
