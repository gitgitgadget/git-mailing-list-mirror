From: Marcus Nascimento <marcus.cps@gmail.com>
Subject: Git gui - Commit message lost when changing from New Commit to Amend
 Last Commit
Date: Wed, 20 Apr 2016 17:13:27 +0100
Message-ID: <CAO+c80580vmOh7U22-z3Tjkn1e6rTYNKQ66=c9ehCArzEAJcUg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 20 18:13:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asulE-0007KR-Hl
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 18:13:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751371AbcDTQNt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2016 12:13:49 -0400
Received: from mail-lb0-f180.google.com ([209.85.217.180]:34867 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750717AbcDTQNs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2016 12:13:48 -0400
Received: by mail-lb0-f180.google.com with SMTP id os9so12123517lbb.2
        for <git@vger.kernel.org>; Wed, 20 Apr 2016 09:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=EvAd28/5l55d9oDXiZDyLaFBTUTs+DUGGWzwTcK+UG8=;
        b=lwnZATYX07xtJUJvsZJB6uHDcD1Cdp2BkjKRAZKGIeKXICUjra3tC4Bfg1306oo3Px
         UjEAMJn+pmv+mGAWnxN2b+hn7KazZZF8+w6qDlAYyC1UPbjWDAbHhx5IFDTyBjNO0E/C
         NbwWlxWUzvPr39MDKDmUIAilcWOQ/r+PGER0lMPVYzIQfTcTfM6Lmp+WXOtkxtqujmmQ
         VfZM3umm4r21W4qOntsLOzPDdxJHkwvCUMfJcHNU4chovRu7mF3SsLAY2m3hm/rBgMNx
         6lYo2ODY4s7E8inrhmoltcuXu+uBkOV3wVP9CWoxrTGxvA+plan0gnWjIhPBQ8RCT/ZZ
         HgkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=EvAd28/5l55d9oDXiZDyLaFBTUTs+DUGGWzwTcK+UG8=;
        b=O/XXntQa1VhnXMbGfjuBYEQyzZBT5DSmCs0ExbF3VY0Owlk3YiIMq1mv9fWaKvunIU
         7R3hha6Zso39w+7hiF10+FwrfN6LRUo1XXYTtkgcmYcfzAL0Qi8vPX/VSnGf5eiQO+wN
         PhLq4vvUIHyjFWgN2gBARbo+pyJoQU/eiIXGfNKUX+JZz3tNwr0ltOfeL3Gi+cOSHOCn
         ZGZUs93Zu07Rh+GZIoBSu4TNrIzkmRTYDXYrQ/aZHQroJNvP2j7wLNikMI22llMRUeRG
         lMH1Q1TO0MrCXUcg+u0ZCH6WGkeWrBIP1HsA+z/KJ4eBTo19BmF4fs96SlyfRzdBOr/W
         wINA==
X-Gm-Message-State: AOPr4FUR+CsY/rbFeMIlcTSV2hDoAkuEb8GlPLnTA/qafFnJkwGII9rlTD08VN3g+NnTiNaIK8DTWlpT5t2JWw==
X-Received: by 10.112.147.101 with SMTP id tj5mr3430793lbb.119.1461168826891;
 Wed, 20 Apr 2016 09:13:46 -0700 (PDT)
Received: by 10.112.221.38 with HTTP; Wed, 20 Apr 2016 09:13:27 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292036>

Hi,

When changing from New Commit to Amend Last Commit, the commit message
it discarded.
It could be appended to the previous commit message with a place
holder or something similar.

git-gui version 0.20.0.1
git version 2.8.0.rc3

Cheers,
--
Marcus Nascimento
