From: Shikhar <shikharid@gmail.com>
Subject: Bug in Quit shortcut key
Date: Wed, 10 Feb 2016 19:20:52 +0530
Message-ID: <CAGKvVu6OEKEmyoECP=YMD9F8BPe__mcG7sDkN_Qo1ZnqDryTjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 10 14:51:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTVAY-0007cB-LF
	for gcvg-git-2@plane.gmane.org; Wed, 10 Feb 2016 14:50:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751449AbcBJNuy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Feb 2016 08:50:54 -0500
Received: from mail-lb0-f170.google.com ([209.85.217.170]:33172 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751357AbcBJNux (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Feb 2016 08:50:53 -0500
Received: by mail-lb0-f170.google.com with SMTP id x4so10624125lbm.0
        for <git@vger.kernel.org>; Wed, 10 Feb 2016 05:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=APGVVL2G13MzTyYl/8cUP9AGnZGJC8swsCizb+tji1M=;
        b=N3X27144tFfr9tIBhx0OY3D6lNARFKspphtKCA1BiLsG3dQFR8OvN0JNgSRkQbLfUJ
         507yTy0X89DWN4crJZ2LyR3sLUtXSF69gp53dWhINv8E9CETS/bFzPNvqiXnDK1hhYEy
         CZ2sdP5ib938ujniZT6hHQUeh0xCXQYtKqwGzkYOSJJnA2Izr1ulPdAdvbQd/YePzZdP
         aX48BRIaWiCg4Uqe76s0jXmNwb/efo9/vlJ6V/gdf7GnwIKOBVzPIH3sRZgW4DuEGtfQ
         lA9ST9bFx7nP28meNmT9MtCyawnpd1HV3u9Gruu0Dq68NIazJrVtSkdzLvCYgmvLGxZy
         DELw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=APGVVL2G13MzTyYl/8cUP9AGnZGJC8swsCizb+tji1M=;
        b=iGo/IvTay01/XCQHKoQvgJVNi3aOVfI9gqYUiLdQWrfQYfxhUDNh4Ko7RXgtOdlBD9
         LyHbAV1e2Xx6yMwmb9AaoIIScDWbyCQHpvlc862h/wVDwlNilF+10/wKqrrq651GQdyJ
         xHO6meokyNjkOmQtyUum+ckzKgEfuocXV4PFWUh6UFgdWfDYZhfWAV1+Onf+iHKdbCuj
         uJaFUpZ2756+U/qLWw3W+6X7GC3bPfwwftwzwrAtD9dMKFNgt8PdDopJ23MEwMYjiMO4
         h2Ybtmc9oakG35bXgYe8r2SQe7Ee/4IBCD/E3HMRY2PB/vQKmUIVyAjekIF9Vng2/+ik
         gRVA==
X-Gm-Message-State: AG10YORPd8t5cdQw+Xb6lA0EKjU3XuDq51Whd86zhbaJltZX1kikrAW/kfHycRD9uKqM8Atr3l3VvTHi/aFkTg==
X-Received: by 10.112.199.197 with SMTP id jm5mr13183874lbc.109.1455112252050;
 Wed, 10 Feb 2016 05:50:52 -0800 (PST)
Received: by 10.25.89.3 with HTTP; Wed, 10 Feb 2016 05:50:52 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285900>

The shortcut key for quit is ctrl+q which is shown as CTRL+Q in the toolbar.
But the shortcut key only work's when Caps Lock is OFF, it gives no
response when caps lock is ON.
-- 
Success is not final, failure is not fatal: it is the courage to
continue that counts.
