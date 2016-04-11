From: Isaac Levy <isaac.r.levy@gmail.com>
Subject: Default authentication over https?
Date: Mon, 11 Apr 2016 12:04:02 -0400
Message-ID: <CAPf1peAW11hZpN6_ztA62tcu6mgCfV3VwwjjtXT5yySUPD9Qpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 11 18:04:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1apeKW-0006nt-BT
	for gcvg-git-2@plane.gmane.org; Mon, 11 Apr 2016 18:04:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755197AbcDKQEo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Apr 2016 12:04:44 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:34756 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752838AbcDKQEn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Apr 2016 12:04:43 -0400
Received: by mail-ig0-f170.google.com with SMTP id gy3so85286062igb.1
        for <git@vger.kernel.org>; Mon, 11 Apr 2016 09:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=ZT9nm7Eek04hhiWFDeuGttAUikJbC/CndkTUv0YnT78=;
        b=lgUPg7HkgLCWSjMbMwh1CUVZvkKX5ZTsnfzIP1cMTrjZR130N0sOcj19M4UHwwO5+o
         4y8j4tVKKVTrjuu9HOPrk1Kb+2D7s9xMDs+3D7qAOtlI37wCoIV9CM2ydu3WZW9wLvJH
         6/9jGuAeaqNqbM+pivcmOHAnlYXlKhEDsep2Ia7cTRCJhQIYb/bglW4l42ldXrMDANMO
         MDapr4HikgUDJcXLRAxOUen3uExLAnUNGNVBT7Km7yqGQnJCibblS2XNYkGBr7YfqC/Y
         eQ+3/5RoTMUQQ/HlTHEpd+7u5zHFSWFNfScbKBtJ4rkhZIvxoY6AE2/LBmivC5vpvjxl
         08nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ZT9nm7Eek04hhiWFDeuGttAUikJbC/CndkTUv0YnT78=;
        b=goN4dZjKxV7Z/VwO/vGx6Hcd84fyCYdRSLdN+1G8xjw2Sstv6woLGR54kRMOaRAcfV
         sHMO/XAZb5NtJHEKlzoJnjkuVyE2P2rA5u1g+wHfPHlBeC5c8bpa/HTCPwlA2qCq3I80
         4Kfq1+E8JF+ubww27IhExH4Fzc3RhcxXtWzxG5ZxS0jjlrmyp4QrSCsXwu4sKffODCCj
         bUG2JpyY1pksaYtXjfXik+RW3kgL14zOvU0MWhJ72ax3OXQWKq0EIV+0nh9P3tI78x/b
         ZpkI9ZTVM2uWoScHFsnxgrxd96s4fBKjuQil+V64VN0FXLBLuTp2RC3trU5JsISj/uZ8
         e2KQ==
X-Gm-Message-State: AOPr4FXqA+9Z01YWNN21uMzJEK5zK1c4QilK7WL2O2fV3gWuPT8g9QSXmRA6XI33pYvRUsK8aBQJulygH9PvPQ==
X-Received: by 10.50.226.179 with SMTP id rt19mr9138344igc.36.1460390682332;
 Mon, 11 Apr 2016 09:04:42 -0700 (PDT)
Received: by 10.107.41.202 with HTTP; Mon, 11 Apr 2016 09:04:02 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291218>

Hi all,

I use a git server which requires authentication over https. Git seems
determined to always try an unauthenticated request first, slowing
down operations by a couple seconds.

Is there a way to configure git to default to authenticated requests?  Thanks!

Regards,
Isaac Levy
