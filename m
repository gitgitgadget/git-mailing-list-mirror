From: Chen Bin <chenbin.sh@gmail.com>
Subject: Can `git grep` have `--Author` option?
Date: Wed, 06 Apr 2016 09:45:54 +1000
Message-ID: <8737qztya5.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 06 01:46:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anafn-0002Cv-P5
	for gcvg-git-2@plane.gmane.org; Wed, 06 Apr 2016 01:46:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760501AbcDEXqF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Apr 2016 19:46:05 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:36761 "EHLO
	mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760448AbcDEXqE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Apr 2016 19:46:04 -0400
Received: by mail-pf0-f173.google.com with SMTP id e128so20504539pfe.3
        for <git@vger.kernel.org>; Tue, 05 Apr 2016 16:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:mime-version;
        bh=LN+VRWZDh4aKjME1UA+DcAyoAffSuyoUDyQtlqtLyF4=;
        b=Il7INWsSAUoCRTaAalF8ZV59OPj4blNWhyXVjFZBUbjnepD9cTufV5RVF5g+M+Nj2p
         QE3Lsr6NuLhwZKkqzIIhZUo7QSJ+oE8G9wAtgFNJlmQeiHM4vAD1Z5tYcm69UAjn3PRg
         6MRzucjR9K3ySb/GNYikhsHHYHDbTA9nj76nsoRVEB8ItsJrBeNJkvlkbpj2K9fWFAiA
         w6K2Op/PphY/q08zZNeCGgN8rBUUSlcobi+pGMDSQmrTLsP7PUkC4fD3MMGUVgVUpst/
         0gYdC9tLyhl9+t3C1yLtvTbyDBADB/1rYFkxudUF0JOhGpubVcgY1XxrE37vFLmRgOtP
         0ClQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version;
        bh=LN+VRWZDh4aKjME1UA+DcAyoAffSuyoUDyQtlqtLyF4=;
        b=IKEBPmAK/vG8tVj/5H51yML8sCReqh9q4ldxwgwZ75fxs7Tt5gAZKSE8snrk1q5B+r
         Itv+276esxCyzRAa25B4wDBYZkbt8KuSsVzY/V1cUc2xKci6bR0s2oGWVU8zoB5sK7EX
         QcsVs1RXl5ZLw6BM6NnSLUobwVm8l3Fmps4KpSiTN4OE4urSfN8JnTPC4Hc4ZtM/FFU7
         JCDfrrOH8bwy251VoBzGxiOP9hTFlkBI2PRkT+D76A8BFkCefkYa6LZYnoyyeRmzigaG
         X6kJFUmLulsB4Tjh12NwtoQwVkpfG2P4vEiK2oozmCeFa11OHfqjvMGjZLTvwVYB4xoV
         rHUA==
X-Gm-Message-State: AD7BkJJ6rKM32djMFZbxsnObqGlv6wNd/5dUE59LvT4PWwT2RP7/eAbDiBw9pC2VsIffAQ==
X-Received: by 10.98.7.153 with SMTP id 25mr34058730pfh.38.1459899956470;
        Tue, 05 Apr 2016 16:45:56 -0700 (PDT)
Received: from debiancb.homepc (203-219-98-82.static.tpgi.com.au. [203.219.98.82])
        by smtp.gmail.com with ESMTPSA id ta2sm84700pab.42.2016.04.05.16.45.54
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 05 Apr 2016 16:45:55 -0700 (PDT)
X-Google-Original-From: Chen Bin <chenin.sh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290818>

This is a feature request.

>From time to time, I want to re-use MY code. So git grep with --Author options is really useful. My current git version is 2.6.3, looks it doesn't have this option.

-- 
Best Regards,
Chen Bin

--
Help me, help you
