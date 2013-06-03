From: Devin Rhode <drhode@amobee.com>
Subject: info/exclude not working
Date: Mon, 3 Jun 2013 13:04:39 -0700
Message-ID: <CALy29pLQ-LWg0knzbzLoQfwSt+df_b3tNdWk7OeSN-CjkJhfsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 03 22:05:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ujb07-0006Ue-9Z
	for gcvg-git-2@plane.gmane.org; Mon, 03 Jun 2013 22:05:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758376Ab3FCUFD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Jun 2013 16:05:03 -0400
Received: from mail-la0-f52.google.com ([209.85.215.52]:42664 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758158Ab3FCUFB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jun 2013 16:05:01 -0400
Received: by mail-la0-f52.google.com with SMTP id fo13so3867607lab.39
        for <git@vger.kernel.org>; Mon, 03 Jun 2013 13:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=adjitsu.com; s=google;
        h=mime-version:sender:x-originating-ip:from:date:x-google-sender-auth
         :message-id:subject:to:content-type;
        bh=Fsk5TR0LCDUNDnPzslm/8A3IhSsppgdrMpRIFIbJ1pA=;
        b=BnDwbog5WfbfOLC5xPb6yOm6ZftZqqkAq30X4Q1c+WwVQb47ctuutJq/gsv7DWok9Z
         ceUybAjqhhhJ7VtaVtb/JWBRH/d9Fz2Yhbnt+tOj/9ghKa/NNEzqN1svkABTBz3iVILC
         vkZZwe9PjKYU7eUuAiU1uA6zRR3Wrfmktjiog=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:x-originating-ip:from:date:x-google-sender-auth
         :message-id:subject:to:content-type:x-gm-message-state;
        bh=Fsk5TR0LCDUNDnPzslm/8A3IhSsppgdrMpRIFIbJ1pA=;
        b=YT+OHk+CGnmWaYYMqvNAzNw+0BLxfoqHTIBvijO+CpwOi1VfeN1SgfS6VVuazygvM7
         3wU9wLm+1ca98fXI9ScNRH/e7bwcF2/wCuQO8Rg4mBawKWD2UrDDMDGpa5lse11YRpa7
         9Zk3u3b3mIpUFIo0vr0YUNDgsx1jiJ+S3u7TvM87UITbFk5NUjmE6sPmrS2GLrsKACLL
         nhmu5NcBlUomfFGQSvOKxGpXmqZsOoOJSIXGf2ugWTA3Ebl7A2CC1kr8lYrT8J7JOYxU
         9Zwpq4XSA20c6n2vhapCRwCA17pPs5vN1oofX0iE5yCNibKFQxkvNc13RxzGUdA5j3Ak
         LWKQ==
X-Received: by 10.112.171.165 with SMTP id av5mr4431538lbc.48.1370289899895;
 Mon, 03 Jun 2013 13:04:59 -0700 (PDT)
Received: by 10.112.167.228 with HTTP; Mon, 3 Jun 2013 13:04:39 -0700 (PDT)
X-Originating-IP: [50.76.62.185]
X-Google-Sender-Auth: 7bgTiLkpLK6cV70bote07eicAqE
X-Gm-Message-State: ALoCoQllXBQVTV1TwOQSdQREmvNB2xFcvY1eLzNWDlXZVBZm3LusXoTyhIMF7lfuxs/IAvfoC2u6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226275>

For some reason info/exclude hasn't been working for me. I have a
pretty plain macbook pro, with a slow standard hard drive, running the
latest mac os 10.7 lion

MBP:dish devin$ pwd
/Users/devin/Dropbox/ads-G2/dish

MBP:dish devin$ cat ../.git/info/exclude
# git ls-files --others --exclude-from=.git/info/exclude
# Lines that start with '#' are comments.
# For a project mostly in C, the following would be a good set of
# exclude patterns (uncomment them if you want to use them):
# *.[oa]
# *~
models/CAFE.json
dish/models/CAFE.json

MBP:dish devin$ git status
# On branch master
# Changes not staged for commit:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working directory)
#
# modified:   models/CAFE.json ***Shouldn't appear
# modified:   page_0.ejs
# modified:   page_0.xml
# modified:   page_1.ejs
# modified:   page_1.xml
#
no changes added to commit (use "git add" and/or "git commit -a")
