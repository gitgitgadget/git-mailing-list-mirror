From: Krzesimir Nowak <krzesimir@endocode.com>
Subject: [PATCH 0/3] Show extra branch refs in gitweb
Date: Tue,  3 Dec 2013 15:56:40 +0100
Message-ID: <1386082603-8404-1-git-send-email-krzesimir@endocode.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: gitster@pobox.com, jnareb@gmail.com, sunshine@sunshineco.com,
	Krzesimir Nowak <krzesimir@endocode.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 03 15:58:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VnrQG-00074W-6t
	for gcvg-git-2@plane.gmane.org; Tue, 03 Dec 2013 15:58:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754775Ab3LCO5y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Dec 2013 09:57:54 -0500
Received: from mail-bk0-f41.google.com ([209.85.214.41]:44371 "EHLO
	mail-bk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754326Ab3LCO53 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Dec 2013 09:57:29 -0500
Received: by mail-bk0-f41.google.com with SMTP id v15so6178493bkz.28
        for <git@vger.kernel.org>; Tue, 03 Dec 2013 06:57:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-type:content-transfer-encoding;
        bh=SVH0v+uu2L+DpLNC74qV4Z5s+jhWSbeQI1y3fAA3/rE=;
        b=BYq4VRuhNkkGr8r8Wblq+0Yn5NbrtCW+kRmn7Km6On823IARRykl8P8N3zM3V4RQH5
         eKh/1IpNzAgb531KA80M941hZiPWyvPQG7VfQ7KWS7vJfR6DrpQf2Bx3jVzhst45I5Jb
         +9K3Q1fiYIZSJIYoVNf6YdN5S/wWC7bfJCs3g8rN9pDaEar6+ArtEhV7Wp7YcOXYhSVJ
         m7HTGat1FKFmPf9v7Z+9Hs21ENN90q+fkCAgTEdX7/BU6RNHJnAyKPBjdFQ5Nme5zY/f
         IWsSX+oiKiaBceGI1WZsbuVwEyHAOaf0NCN8irZ9GfSduusV18gQWknQ7gSPboMRs6Fz
         giBg==
X-Gm-Message-State: ALoCoQkWeKVXM/1kEbKRCbFBCowkAZJEUglKV6+JydA+nztxzOoqHNN0C7YAK2JBHSvVorUHdxXe
X-Received: by 10.204.171.206 with SMTP id i14mr417151bkz.120.1386082648324;
        Tue, 03 Dec 2013 06:57:28 -0800 (PST)
Received: from localhost.localdomain (p5792264C.dip0.t-ipconnect.de. [87.146.38.76])
        by mx.google.com with ESMTPSA id bf8sm30500407bkb.14.2013.12.03.06.57.26
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Dec 2013 06:57:27 -0800 (PST)
X-Mailer: git-send-email 1.8.3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238696>

First patch just splits some code to a function, second patch adds the
extra-branch-refs feature and third one adds some visual
differentation of branches from non-standard ref directories.

Krzesimir Nowak (3):
  gitweb: Move check-ref-format code into separate function
  gitweb: Add a feature for adding more branch refs
  gitweb: Denote non-heads, non-remotes branches.

 Documentation/gitweb.conf.txt |  27 ++++++++++
 gitweb/gitweb.perl            | 120 +++++++++++++++++++++++++++++++++++-------
 2 files changed, 129 insertions(+), 18 deletions(-)

-- 
1.8.3.1
