From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Verify we know how to read a pack before trying to using it.
Date: Mon, 21 Aug 2006 01:00:24 -0700
Message-ID: <7vhd06wmav.fsf@assigned-by-dhcp.cox.net>
References: <20060821071002.GA26029@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 21 10:00:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GF4hy-0006O9-5h
	for gcvg-git@gmane.org; Mon, 21 Aug 2006 10:00:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030301AbWHUIA0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Aug 2006 04:00:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030302AbWHUIA0
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Aug 2006 04:00:26 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:13725 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1030301AbWHUIA0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Aug 2006 04:00:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060821080025.BFUT8129.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 21 Aug 2006 04:00:25 -0400
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060821071002.GA26029@spearce.org> (Shawn Pearce's message of
	"Mon, 21 Aug 2006 03:10:02 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25786>

I agree we would need this check somewhere, but I am wondering
if we might be better off doing this where we verify pack-idx
pair, e.g. add_packed_git().
