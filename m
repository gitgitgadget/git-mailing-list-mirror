From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: Re: [PATCH] Multiple refs from the same remote in one git fetch
Date: Mon, 14 Aug 2006 22:17:33 +0300
Message-ID: <20060814191733.GD16821@mellanox.co.il>
References: <ebqfjq$ujd$1@sea.gmane.org>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 14 21:15:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GChuQ-0001xf-IJ
	for gcvg-git@gmane.org; Mon, 14 Aug 2006 21:15:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932624AbWHNTP3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Aug 2006 15:15:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932609AbWHNTP3
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Aug 2006 15:15:29 -0400
Received: from mxl145v64.mxlogic.net ([208.65.145.64]:11954 "EHLO
	p02c11o141.mxlogic.net") by vger.kernel.org with ESMTP
	id S932624AbWHNTP2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Aug 2006 15:15:28 -0400
Received: from unknown [194.90.237.34] (EHLO mtlexch01.mtl.com)
	by p02c11o141.mxlogic.net (mxl_mta-3.0.0-12)
	with ESMTP id 0dbc0e44.2271169456.132970.00-009.p02c11o141.mxlogic.net (envelope-from <mst@mellanox.co.il>);
	Mon, 14 Aug 2006 13:15:28 -0600 (MDT)
Received: from mellanox.co.il ([10.4.4.6]) by mtlexch01.mtl.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 14 Aug 2006 22:21:30 +0300
Received: by mellanox.co.il (sSMTP sendmail emulation); Mon, 14 Aug 2006 22:17:33 +0300
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <ebqfjq$ujd$1@sea.gmane.org>
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 14 Aug 2006 19:21:30.0984 (UTC) FILETIME=[D8EB3E80:01C6BFD6]
X-Spam: [F=0.0100000000; S=0.010(2006062901)]
X-MAIL-FROM: <mst@mellanox.co.il>
X-SOURCE-IP: [194.90.237.34]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25377>


Quoting r. Jakub Narebski <jnareb@gmail.com>:
> Have only "Pull: master:linus_master" as the pull line, and make origin
> symlink (ln -s $GIT_DIR/refs/heads/linus_master $GIT_DIR/refs/heads/origin)
> or symref (echo "ref: refs/heads/linus_master" > $GIT_DIR/refs/heads/origin)
> or vice versa.

Thanks.

-- 
MST
