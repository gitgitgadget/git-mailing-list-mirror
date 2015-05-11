From: dturner@twopensource.com
Subject: [PATCH v5 0/3] cat-file --follow-symlinks
Date: Mon, 11 May 2015 18:50:42 -0400
Message-ID: <1431384645-17276-1-git-send-email-dturner@twopensource.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 12 00:51:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YrwYF-0007Jl-F6
	for gcvg-git-2@plane.gmane.org; Tue, 12 May 2015 00:51:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753182AbbEKWvu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2015 18:51:50 -0400
Received: from mail-qg0-f49.google.com ([209.85.192.49]:32950 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751677AbbEKWuy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 May 2015 18:50:54 -0400
Received: by qgdy78 with SMTP id y78so76066581qgd.0
        for <git@vger.kernel.org>; Mon, 11 May 2015 15:50:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=bdg09PoqqoFLyOpWVsWBU5bYjFYTklGNNE6Ws5nsa1s=;
        b=fXEU9drO2+qqf7kxnhXh/P+BkdL8Z9NmWTXcR+UwQJlMXIC4+YNuiphz0+4M3VkveK
         r6pt1wTOv3xxiSXQz9m0T4PZwb4vER40I+8JSYcLeu52u/yQikUKNtPKsFsMYnIvHeIF
         oUKbeBQlVNsaZhrkGRtVwT1wVm25+MmdW/peRUeBwenn1DWEc9dqt8moT0LR+rON9wYa
         AzbyovIpwpa+EGM3e9iF+69zB+WnawG66teJj7d/Wg90G8P1wYc3MQ4o6A7sRtRtuat6
         w84OPKmFhX+qihMWmmDN73nqJdPuYKJYwY8sYRNYHO1CfWsxqzPkomy+Fc/lCDoBODTL
         tlYw==
X-Gm-Message-State: ALoCoQmC4mcSkyDk2zUVH485+vI0UQ/bKHVErnlENnKX6xwIqP/ZjDu63dB15+ylUJOeiUaLhm80
X-Received: by 10.55.21.224 with SMTP id 93mr27517079qkv.89.1431384653384;
        Mon, 11 May 2015 15:50:53 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.147])
        by mx.google.com with ESMTPSA id 8sm11833135qgy.39.2015.05.11.15.50.52
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 11 May 2015 15:50:52 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268833>

This version improves the documentation for git cat-file
--follow-symlinks.  Only Patch 3/3 is changed.

Thanks to Junio Hamano for suggestions.
