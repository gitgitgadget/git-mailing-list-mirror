From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH, take 2] Linear-time/space rename logic (exact renames
 only)
Date: Mon, 22 Oct 2007 14:37:55 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710221437030.30120@woody.linux-foundation.org>
References: <alpine.LFD.0.999.0710211603200.10525@woody.linux-foundation.org>
 <20071022070750.GM1179MdfPADPa@greensroom.kotnet.org>
 <alpine.LFD.0.999.0710220932150.10525@woody.linux-foundation.org>
 <alpine.LFD.0.999.0710221009580.10525@woody.linux-foundation.org>
 <alpine.LFD.0.999.0710221207300.30120@woody.linux-foundation.org>
 <alpine.LFD.0.999.0710221241560.30120@woody.linux-foundation.org>
 <20071022211706.GD23714@steel.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Kastrup <dak@gnu.org>, Jeff King <peff@peff.net>,
	Sven Verdoolaege <skimo@liacs.nl>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 22 23:38:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ik4yy-0002Yh-5D
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 23:38:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750944AbXJVVid (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 17:38:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751119AbXJVVid
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 17:38:33 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:47353 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750928AbXJVVic (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Oct 2007 17:38:32 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9MLbuVZ015445
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 22 Oct 2007 14:37:57 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9MLbuBS016260;
	Mon, 22 Oct 2007 14:37:56 -0700
In-Reply-To: <20071022211706.GD23714@steel.home>
X-Spam-Status: No, hits=-3.222 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62048>



On Mon, 22 Oct 2007, Alex Riesen wrote:
> 
> It breaks t3402-rebase-merge.sh

Hmm. Works for me here. But I will check if there is some incomplete 
dependency in the makefile or something...

		Linus
