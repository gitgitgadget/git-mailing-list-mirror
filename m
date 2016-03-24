From: Motroni Igor <motroniii@gmail.com>
Subject: [PATCH 0/2] GSoC student
Date: Thu, 24 Mar 2016 22:41:07 +0300
Message-ID: <1458848469-12663-1-git-send-email-motroniii@gmail.com>
Cc: Motroni Igor <motroniii@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 24 20:41:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajB8E-0005OT-2W
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 20:41:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751399AbcCXTlR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2016 15:41:17 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:33575 "EHLO
	mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751136AbcCXTlQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2016 15:41:16 -0400
Received: by mail-lf0-f66.google.com with SMTP id w7so4633025lfd.0
        for <git@vger.kernel.org>; Thu, 24 Mar 2016 12:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=v7u+19FeNiAJap28SLRLQOdu7MfRdyeeVvlX7GcvF14=;
        b=k9VY4R837bo74y/dNSvZJuamkOF7fHsjwP/eIMy63rHWXh5FjMX10RYpdIL0DadJTH
         sq1Vn1SU9ppICjx3Q7CBbjH+GYbwFs+EtuaxYpn6jO///DGmHEf694joQMY+/oSOnXtz
         3fbSB1uEw25K3ioVHC5o62GzcXAiQTj6PHHmlZqvzOJUIWpIs6w0oh5xrZ/+mAyHQlwR
         KoTiadzrpU3GP1mW+1T+EfrwvbqvVFXwQpSXUbQYtaWU0KTSabYS4XsK1+OnrCcaSP3Q
         PAXFAYmrZfORwZAv2VqPiFW6yzrwjMUM2TfupBNv/CA+0X1pvO1/OBt+6JMzM59+62q7
         N+Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=v7u+19FeNiAJap28SLRLQOdu7MfRdyeeVvlX7GcvF14=;
        b=GfJ5ttcH4T092Xi+enfOc0/mslLeFW7hHn9NBy6z8LgNsCT5EokEXnNn6v63+DVm+b
         RD7OK78RQocWEA5Nq+sbNKgEw4NTDyLlY9M3muy8r3Asp0nYdv5wpBZlCHcQbQCjkiTl
         VWbxaLbDe3p3+bAWzvn3dxMXhYAAoABb8ijxdgszAf8mAfg72cZGPkdg03ElopYjgBvU
         sf0cy0lwC28zy7Edq9MqWbLO0WN4dVM6KHs+AslAC3sK1pEiE1EMDALfU6I/4fnQn4Rz
         rqsDF0QCxllS91ykqKD+Oa1Ym/mXIjPIS0O6h5nsg47oTBk97H7nY/CbTKtmnHkSRSe2
         M+YQ==
X-Gm-Message-State: AD7BkJJQVuJpWpGq+JE3Eg9bBtNRZzJqq4pzWmyLtrGgvYCHHfMuEaOTLv0xYeBYR8/ACA==
X-Received: by 10.25.16.90 with SMTP id f87mr3669091lfi.18.1458848474419;
        Thu, 24 Mar 2016 12:41:14 -0700 (PDT)
Received: from localhost.localdomain (ppp91-76-147-218.pppoe.mtu-net.ru. [91.76.147.218])
        by smtp.gmail.com with ESMTPSA id i8sm1390220lbj.30.2016.03.24.12.41.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 24 Mar 2016 12:41:13 -0700 (PDT)
X-Mailer: git-send-email 2.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289787>

 Hi! My name is Motroni Igor and I'm a Russian student who wants to apply for the GSoC developing some cool stuff for Git. As a microproject, I've made two little changes in my Git fork.

  Modified flag field type in rev_list_info struct in bisect.h. There is
    no need for flag field to be signed, as it is not supposed to be
    used as decimal.
  Just a minor commit to trigger Travis Ci build

 bisect.h | 2 +-
 notes.c  | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.5.0
