From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Find the next tag on a given branch
Date: Thu, 9 Sep 2010 10:07:35 +0200
Message-ID: <201009091007.35275.trast@student.ethz.ch>
References: <20100909052841.GA16722@fishbowl.rw.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git discussion list <git@vger.kernel.org>
To: martin f krafft <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Thu Sep 09 10:07:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtcAc-0006NM-Vu
	for gcvg-git-2@lo.gmane.org; Thu, 09 Sep 2010 10:07:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751371Ab0IIIHk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Sep 2010 04:07:40 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:23820 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751071Ab0IIIHh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Sep 2010 04:07:37 -0400
Received: from CAS22.d.ethz.ch (172.31.51.112) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.254.0; Thu, 9 Sep
 2010 10:07:36 +0200
Received: from thomas.site (129.132.153.233) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.1.218.12; Thu, 9 Sep
 2010 10:07:35 +0200
User-Agent: KMail/1.13.5 (Linux/2.6.34-12-desktop; KDE/4.4.4; x86_64; ; )
In-Reply-To: <20100909052841.GA16722@fishbowl.rw.madduck.net>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155849>

martin f krafft wrote:
> The alternative is
> 
>   git describe --contains mycommit --pattern='debian/*'

Maybe

  git tag --contains mycommit | grep ^debian/

?

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
