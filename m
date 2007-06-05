From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/7] introduce GIT_WORK_TREE to specify the work tree
Date: Tue, 05 Jun 2007 00:52:53 -0700
Message-ID: <7vodjudei2.fsf@assigned-by-dhcp.cox.net>
References: <20070603144401.GA9518@moooo.ath.cx>
	<20070603144714.GD20061@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Matthias Lederhofer <matled@gmx.net>
X-From: git-owner@vger.kernel.org Tue Jun 05 09:53:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvTqh-0008Cn-8n
	for gcvg-git@gmane.org; Tue, 05 Jun 2007 09:53:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756796AbXFEHwz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Jun 2007 03:52:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757280AbXFEHwz
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jun 2007 03:52:55 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:46857 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756796AbXFEHwy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2007 03:52:54 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070605075255.SXTW12556.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Tue, 5 Jun 2007 03:52:55 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 7jst1X00H1kojtg0000000; Tue, 05 Jun 2007 03:52:54 -0400
In-Reply-To: <20070603144714.GD20061@moooo.ath.cx> (Matthias Lederhofer's
	message of "Sun, 3 Jun 2007 16:47:14 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49167>

Hmph.

When this series is applied on top of 'next' (or whatever
contains t7003-filter-branch.sh), this seems to break it quite
badly.
