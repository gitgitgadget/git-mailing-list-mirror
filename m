From: Junio C Hamano <junkio@cox.net>
Subject: Re: full kernel history, in patchset format
Date: Sat, 16 Apr 2005 12:19:22 -0700
Message-ID: <7v8y3i7cn9.fsf@assigned-by-dhcp.cox.net>
References: <20050416131528.GB19908@elte.hu>
	<Pine.LNX.4.58.0504160953310.7211@ppc970.osdl.org>
	<7vmzry7ev5.fsf@assigned-by-dhcp.cox.net>
	<42615B00.6090106@timesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 16 21:16:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMsm1-0006vZ-E6
	for gcvg-git@gmane.org; Sat, 16 Apr 2005 21:16:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262737AbVDPTTu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 15:19:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262738AbVDPTTu
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 15:19:50 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:58609 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S262737AbVDPTTt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2005 15:19:49 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050416191924.OKVL4787.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 16 Apr 2005 15:19:24 -0400
To: Mike Taht <mike.taht@timesys.com>
In-Reply-To: <42615B00.6090106@timesys.com> (Mike Taht's message of "Sat, 16
 Apr 2005 11:35:44 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "MT" == Mike Taht <mike.taht@timesys.com> writes:

MT> alternatively, "git-archive-torrent" to create a list of files for a
MT> bittorrent feed....

That is certainly good for establishing the baseline, but you
still need to leverage the inherent delta-compressibility
between related blobs/trees by also doing something like what I
described as "diff package", don't you?




