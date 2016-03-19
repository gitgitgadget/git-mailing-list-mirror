From: Rogier Goossens <goossens.rogier@gmail.com>
Subject: [PATCH v2 0/2] gitk: Two improvements to the branch context menu
Date: Sat, 19 Mar 2016 19:31:32 +0100
Message-ID: <10662590.KWXHt2RUKZ@wiske>
References: <51900395.pKIx87RN0F@wiske>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sun Mar 20 09:15:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahYVv-0000nk-8n
	for gcvg-git-2@plane.gmane.org; Sun, 20 Mar 2016 09:15:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755245AbcCTIPC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Mar 2016 04:15:02 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36300 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752317AbcCTIOt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Mar 2016 04:14:49 -0400
Received: by mail-wm0-f68.google.com with SMTP id l68so14980716wml.3
        for <git@vger.kernel.org>; Sun, 20 Mar 2016 01:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:user-agent:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SishWvZSZbmos1E28J0bKyAQCYZPNfau8NL+jwvqnCc=;
        b=H/95oU2fFTzZZXxOJp8/SPAVJ5EeNnx4f1dVlDMVhBkD2/qarpAxyapdGai7t83pUd
         UwFWngaEuaQ9cF5S4so1sSIgwa9unNLERsqldARu/9LpAT+64GKAVCIFVBm1dshzhHVr
         q9Q6C0lAVGhpVOBcGVvWXCTA6Bbgc6M6ssgq1Qm15+bvlolw9GhuZ/WtJajSXzv0c7Ci
         f+LWHltspwGZeVKzk4P35dee62TM/AuXmh8XrwMG+t5ToY1N0ZMvKwublhxfBifFHpcd
         l+e7hzyoDivHfRIiebJNM1FhOnFrJhczFuUPtSu9zgd/1gGMek9KqBcR2KbQVEI/WXwb
         G+Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:user-agent
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=SishWvZSZbmos1E28J0bKyAQCYZPNfau8NL+jwvqnCc=;
        b=EfyS5I0umbfzfQ4KThgph6J8sXxBdDy5IzHMmAjqKiNnbFrtNpxXgp5WOYlMCIZkCy
         Xpobx+vuZmYS+UjGSHM4C5N2jiXCORdNTxEbrKZHn8AiOAYjCVUgqqmh0h+M2+JZv0Em
         B7575nUDZIpLsxxc9f4N7Gtl+/yU/eHcejzNJdUPs72iU3dfpOrDdGNScFu/LRoOJrls
         Xr1w1bag3h0kxtFR3gPmBygZPNtf+sRtdCaOQnMQBIHDhHOmQEowq8/TnKVzVLG+jyre
         eINKuRh7Dxd4BQd5JGIvrWm7r6egfiY2B6Xnnsh8sN67+Pr2pJqPuNPhBLqvtTRAN0BV
         uqTQ==
X-Gm-Message-State: AD7BkJLOQZTvfLrdw9n0cdvAitA8y4BVz/BDIKksz1jYwB9FfvfIv9Of04rYe9COB1mjwA==
X-Received: by 10.28.136.211 with SMTP id k202mr8100894wmd.93.1458461688075;
        Sun, 20 Mar 2016 01:14:48 -0700 (PDT)
Received: from wiske.localnet ([86.81.114.242])
        by smtp.gmail.com with ESMTPSA id hx10sm19692564wjb.25.2016.03.20.01.14.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 20 Mar 2016 01:14:47 -0700 (PDT)
User-Agent: KMail/4.14.1 (Linux/3.16.0-4-amd64; KDE/4.14.2; x86_64; ; )
In-Reply-To: <51900395.pKIx87RN0F@wiske>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289342>

Hi,

Hereby the revised patches.

Changes since v1:
- Rebased on latest master
- Made the changes you suggested
- Moved 'rename branch' menu option above 'delete branch'
- Cleaned up some code duplication that the previous patches 
introduced.

Rogier.
