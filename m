From: Mike Taht <mike.taht@timesys.com>
Subject: git options
Date: Mon, 18 Apr 2005 02:23:03 -0700
Message-ID: <42637C77.5070101@timesys.com>
References: <20050416132231.GJ2551@abridgegame.org>	<Pine.LNX.4.58.0504161531470.7211@ppc970.osdl.org>	<20050417121712.GA22772@abridgegame.org>	<Pine.LNX.4.58.0504170916080.7211@ppc970.osdl.org>	<20050417195600.6894e576.pj@sgi.com>	<Pine.LNX.4.58.0504172005450.7211@ppc970.osdl.org> <20050417213632.1f099ff9.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Apr 18 11:21:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNSQM-0001ar-F6
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 11:20:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262009AbVDRJXc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 05:23:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261904AbVDRJXc
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 05:23:32 -0400
Received: from mail.timesys.com ([65.117.135.102]:57566 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S262010AbVDRJXJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2005 05:23:09 -0400
Received: from [10.129.129.212] ([67.180.132.225]) by exchange.timesys.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Mon, 18 Apr 2005 05:18:25 -0400
X-Accept-Language: en-us, en
To: git@vger.kernel.org
In-Reply-To: <20050417213632.1f099ff9.pj@sgi.com>
X-OriginalArrivalTime: 18 Apr 2005 09:18:25.0515 (UTC) FILETIME=[932D9BB0:01C543F7]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Would it be useful at this point to make common and centralize some/most 
of the various options that control git? (as well as add some useful 
ones). Something like:

struct _git_opt {
         int verbose:1;
         int debug:1;
	int dry-run:1;
         int should_block:1;
         int remove_lock:1;
         int allow_add:1;
         int allow_remove:1;
         int null_termination:1;
         int show_cached:1;
         int show_deleted:1;
         int show_others:1;
         int show_ignored:1;
         int show_stage:1;
         int show_unmerged:1;
         int show_edges:1;
         int show_unreachable:1;
         int basemask:1;
         int recursive:1;
         int force_filename:1;
         int force:1;
         int quiet:1;
         int stage:1;
};


-- 

Mike Taht


   "Avoid letting temper block progress; keep cool.
	-- William Feather"
