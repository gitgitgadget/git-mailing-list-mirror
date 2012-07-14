From: "Zeeshan Ali (Khattak)" <zeeshanak@gnome.org>
Subject: Support of '^' as alias for 'HEAD^'
Date: Sat, 14 Jul 2012 03:39:12 +0300
Message-ID: <CAAa3hFMgy66W0dVEGv164Zowfa6Q-5DqgkkLz_1paymU_1SHUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 14 02:39:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SpqOn-00067B-J9
	for gcvg-git-2@plane.gmane.org; Sat, 14 Jul 2012 02:39:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757055Ab2GNAjO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jul 2012 20:39:14 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:42990 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756940Ab2GNAjN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jul 2012 20:39:13 -0400
Received: by yhmm54 with SMTP id m54so4441930yhm.19
        for <git@vger.kernel.org>; Fri, 13 Jul 2012 17:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type;
        bh=WORrVeqIoyt4wDbkUjd2lZYz039dTLm38BZMgp8w8xU=;
        b=s7cYMZ4QQ6EiuSGB3yxwQTGo6j5DJnrjGWe5uorSEFTIQrqz8tAF/0u+2mG2XLx0H3
         jr5Cf8QRrUIw5jsypCGCTFEg/AekCDUSVxxKaIP/iEuNfIZwV7skRKYL9Bru5UUn2eah
         8ZQvyVq4olaVr2yqzhU4dnhGw3nvrrl734w3CvdqFGjJY8iLGJkaqBSIKZJgF9ECrC58
         wcpX3c8Bh6uWBGgC3b8kNU+6Ah/xlop0WXJbjWrw+Wm0b7PIi0vhGHaMW2+s+zSBA2G3
         LiG4OlCMeq+UVXZuBVetkTGytx8bBPSYXOZhy10/y3p0Ilp9NSSgjcb56zbEE2tDgz2C
         UHtw==
Received: by 10.43.92.67 with SMTP id bp3mr2000885icc.16.1342226352722; Fri,
 13 Jul 2012 17:39:12 -0700 (PDT)
Received: by 10.50.196.233 with HTTP; Fri, 13 Jul 2012 17:39:12 -0700 (PDT)
X-Google-Sender-Auth: qUGgC_qE7HAFmHNFaAYwswBMOfQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201431>

Hi,
  Many times I want to refer to 'HEAD^', 'HEAD^^' and sometimes even
further up the tree. It would be really nice if I didn't have to type
'HEAD^' but could only type '^'. Bash completion make things easier
but it automatically inserts a space immediately after HEAD so you
have to hit backspace. I think this change would be good in general
anyway.

-- 
Regards,

Zeeshan Ali (Khattak)
FSF member#5124
