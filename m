From: Sidhant Sharma <tigerkid001@gmail.com>
Subject: log --pretty accepts incomplete pre-defined formats
Date: Wed, 6 Apr 2016 11:43:57 +0530
Message-ID: <5704A925.9030506@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 06 08:14:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1angjC-0004G9-Ez
	for gcvg-git-2@plane.gmane.org; Wed, 06 Apr 2016 08:14:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754362AbcDFGOE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2016 02:14:04 -0400
Received: from mail-pa0-f65.google.com ([209.85.220.65]:34804 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752721AbcDFGOC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2016 02:14:02 -0400
Received: by mail-pa0-f65.google.com with SMTP id hb4so3189041pac.1
        for <git@vger.kernel.org>; Tue, 05 Apr 2016 23:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:subject:to:message-id:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=wu9tZMEMEKgain7xSyHTv5oDFFpH8TiL4/qlA4NS0sQ=;
        b=x/zCDi1VGZgpl//H0Gvy9FIU2XO9ml07F3q/M5q/M/NwBcSKAoK7RcL7CqQbXsU27s
         cBc6casjT0he+6CHfhADoRVC2pseUVqL0W+GWcYOIURzyQ/AKauUNGhF89ysdGhle+MJ
         B7XzVG61MXS6/xB2+6mWRKYJOSALQDSkE8eUfafAZjuqe5d+GoKFkH3IE7Sj/6kdd5yO
         LXd7xHfT7xrkHNRn1qUK6fGOMPu2EHoYy2jc//oT2u4K1QC6oHzPhVeR1XZ+ure4QmDB
         F44y9UdSRnJyx/GYsBvfCGKm5F44LOwRfgnhCaL91BCS8oGLwlkUTjJpzy6bdYGnicac
         7mFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:subject:to:message-id:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=wu9tZMEMEKgain7xSyHTv5oDFFpH8TiL4/qlA4NS0sQ=;
        b=C3UO0c5mYG5w+98ibVDspEhB/T1L05gZF9FJ6TJSwpcQCLaHsvfxFHTgAx5RTHYx6i
         y7uYAgzrCpse5yYhFDrdfa0Tn5rF82eXVqQmUMkx9dqMhJjv7WYOFMdMNV6S54j1yaqe
         8W8XVOJ3Ob7u0cBrUAOVTjoqAbU3aPUuXcxSIuZ2BXybgICtLg4uX5xLHDuNJ8qdUzwK
         8rPN8/8fQDR/I2mkFoijSL6qLuAhGizfnbw/W6QhQxpyMteJ+k0ouoohDiVQcLSl4KaV
         rVfPDMLc71XYAb1vqvJrc2R5+BhlKO6AgCo3HgHqy9cvFtE3lDS5veFerCRAar40WECz
         uwMA==
X-Gm-Message-State: AD7BkJKoDXtGx823PQeignoufwTVz6bV319wjk/y2Y6VBSei5Dmsm9rHVsuIzMyC2b63eA==
X-Received: by 10.66.228.167 with SMTP id sj7mr39383692pac.101.1459923241091;
        Tue, 05 Apr 2016 23:14:01 -0700 (PDT)
Received: from [10.15.2.35] ([14.139.251.107])
        by smtp.gmail.com with ESMTPSA id r68sm1798482pfb.51.2016.04.05.23.13.59
        for <git@vger.kernel.org>
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 05 Apr 2016 23:14:00 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290823>

Hi,

Recently while playing around with git log, I realized that it is possible to
pass incomplete (pre-defined) format names. For example, it is possible to use
`git log --pretty=one` instead of oneline and it would still output the logs in
oneline formatting. Same goes for other formats such as 'raw', 'short' and others.
I looked at the code and it seems that it is intentionally kept so. It this so?
I'm curious to know the reason behind keeping this so.


Thanks and regards,
Sidhant Sharma
