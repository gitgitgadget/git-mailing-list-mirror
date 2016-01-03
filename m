From: Andrey Utkin <andrey.utkin@corp.bluecherry.net>
Subject: "git send-email" thru Gmail incurs few minutes delay
Date: Sun, 3 Jan 2016 15:52:12 +0200
Message-ID: <CAM_ZknWuOSbQcGvXaCDUKAJX7hR5FxJO3a8axPYS4ekyRiczCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Andrey Utkin <andrey.od.utkin@gmail.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Sun Jan 03 14:52:27 2016
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1aFj56-0001O5-3E
	for glk-linux-kernel-3@plane.gmane.org; Sun, 03 Jan 2016 14:52:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752043AbcACNwP (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Sun, 3 Jan 2016 08:52:15 -0500
Received: from mail-io0-f179.google.com ([209.85.223.179]:34062 "EHLO
	mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751521AbcACNwN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Jan 2016 08:52:13 -0500
Received: by mail-io0-f179.google.com with SMTP id 1so89242749ion.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Jan 2016 05:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=corp-bluecherry-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=NJZnsH1gRXAS1Bsci/FRcOp91cKkXr2RB4DG3oeJLVg=;
        b=XokGZXFEnYVPvQIOdmWQNKYTIw6xQ6lqkWkbrQ2bSJYMhf6/jPHfUGNqmxC1AhNIcT
         uKMutp8jhCHLdjqXLhfcLxYqPHkeDdHbhDZyCGv1IBwRgmuoVy8Jb2Sx+ga/pic15hQZ
         3mu4G9+7BHlf2C+8IvtsD7nex2LBMaDVpPY4WiBtdPnuDqRSf6kyDh2Wzv/MEylzsoC+
         bSEJhUPQbrjqxDreW2mQdmTYTKu1xDfQumYIcyy0S5CfF2PyDAEvtsuo7qdCUlFN88w2
         mN91qrI7bFhVPiFORumiDAY2yl+BWo30Met9uox/GRoNHjmoMZO0hoG+4xC/6p28hcpB
         xL2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc
         :content-type;
        bh=NJZnsH1gRXAS1Bsci/FRcOp91cKkXr2RB4DG3oeJLVg=;
        b=lfy5K2499r660XIVzvMl2TtSnmUvyXQx/sVCLKmPTD8zVlEu2hzwaHw88ktYXDNQZG
         zL3WmtIBAtimJMEOkBFUVkhoMFPiVVW5p4j1IExjd1ZqXFysDOWKBMFTAhvQmIIIWvND
         BjQUwXD0JclkR6vxfea4x1SAt+/GeAmtab/sdSPUU6LQdAUiD4sK4lVRZ5Y6MafTxnyu
         o0rODU9fwFa7Pro8zSyIUepftWW9QaAV55fyKaUonHZTd8GbVOo4ELzV4mqXbk1DlREQ
         y/tsHnyQicTkIGEiLYXU4kOppJg19ArMTqJ6kOpbPcdvCtAdQNSxXYwhwY56SZ36KLsW
         xjCQ==
X-Gm-Message-State: ALoCoQnA/jj7VAThouc7yw+xKU3A5vp3lnvM9+mnEQaMCGsqDN01dqHBKz6GvQ0o0RlvNEH1cf4UHZ8IE5oHkdAsxZ5qpLO+KY7QC813a21mfwbS47/DDeE=
X-Received: by 10.107.47.20 with SMTP id j20mr30203398ioo.168.1451829132219;
 Sun, 03 Jan 2016 05:52:12 -0800 (PST)
Received: by 10.107.201.13 with HTTP; Sun, 3 Jan 2016 05:52:12 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283273>

After "Send this email? ([y]es|[n]o|[q]uit|[a]ll): y" prompt and
before "Password for 'smtp://XXX@gmail.com@smtp.gmail.com:587':"
prompt I always have a delay of 2-3 minutes. It is weird! "Unsafe
clients" are allowed in Gmail settings.
I experience this both with @gmail.com mailbox and with gmail-based
company domain mail.
I noticed this happening the first time several months ago.
Has anybody else experienced this? Any solution?
My git version is 2.6.4.

-- 
Bluecherry developer.
