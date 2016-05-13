From: Lars Schneider <larsxschneider@gmail.com>
Subject: [BUG] t9801 and t9803 broken on next
Date: Fri, 13 May 2016 12:02:48 +0200
Message-ID: <3A110437-F778-42E2-A987-86B4EAB3D963@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: normalperson@yhbt.net, Luke Diamand <luke@diamand.org>
To: Git Users <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 13 12:03:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b19w8-0004BG-Cb
	for gcvg-git-2@plane.gmane.org; Fri, 13 May 2016 12:03:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751763AbcEMKCx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2016 06:02:53 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:35721 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751576AbcEMKCw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 May 2016 06:02:52 -0400
Received: by mail-wm0-f45.google.com with SMTP id e201so15932603wme.0
        for <git@vger.kernel.org>; Fri, 13 May 2016 03:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:content-transfer-encoding:subject:date:message-id:cc:to
         :mime-version;
        bh=AEnwCTqroFVpo4ZxiMMDbGrXVf28Kj9xwHg4op6M2gQ=;
        b=h4DXq5v9DOLW7sC1mQSqz/4/cBhy+2veZKFAvBlWqRvbvjoTOYwWT1XuwykFjEoXPu
         VcNSLEDV5Z7gp8YOe/fbRAWqZI7lptkE7ffmQC0Dk4grcHLbz2iWEL062JA0JY5eIsws
         JIZZ0tecLXMf7v+R7+LQCvZTZ8D5G1wCCCNYe+FPiyk1vaWxf1HtA6NtsfMJbQ8lO9ot
         n03KMfRiF9MX0ZGRXa+FlsLd8GjAVdcIgHns0jwMPNgGfu1xmABFSZE9uBolUq8S/vcK
         0pIr39DLbJwi7Zo/JD4l2G0jwFV9Qe4g1R3foQg3x1VTc7GbWEBwExvuMDrYICmZhjKP
         eV+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:content-transfer-encoding:subject:date
         :message-id:cc:to:mime-version;
        bh=AEnwCTqroFVpo4ZxiMMDbGrXVf28Kj9xwHg4op6M2gQ=;
        b=Za1XlNlFUth6wRLkYphJgODTF5So+TPSfEO1+zVbUm0fL9VQ4BXzejPZOENEVz5w0b
         ay5BO3kXwXhkJdUlxWO4gxFgH8ctalnlLbzlhbHHRQ/OJqB9yitOyWstZzZcznt+yfEj
         3Krjv7mZkLAxnXJlTkJiZ1dEVTz/A4+wWFUoNSReH1p4CFWmnCp5LpTIcCo1PqC80uS7
         cQUNwF8J1JwWy0ivE+zNCtzl0VSE276LFti9iSAz4RjSfyvKxVNneL8BU+kpEyC7FMrG
         kbYdyNXP11hK/sj9mXlxXfDck3NMzj7VC44f24hcNM89VXMqS2lPht9G0L3l2hrhi6Vp
         KZKA==
X-Gm-Message-State: AOPr4FWzYzWO55KiYiyFxvbqTUVKOIsPy8JycWxam2Vw/uSbpy0Bu1mZNcumAssw6+PMFw==
X-Received: by 10.28.129.22 with SMTP id c22mr2816963wmd.89.1463133770564;
        Fri, 13 May 2016 03:02:50 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([217.71.219.2])
        by smtp.gmail.com with ESMTPSA id wb10sm17812237wjc.8.2016.05.13.03.02.49
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 13 May 2016 03:02:49 -0700 (PDT)
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294519>

Hi,

t9801 and t9803 seem to be broken on next. A quick bisect indicates that d9545c7 
"fast-import: implement unpack limit" might be the reason. (@gmane/292562).

Did anyone look into that already?

Thanks,
Lars
