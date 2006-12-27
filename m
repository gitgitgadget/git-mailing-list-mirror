From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Create 'git gc' to perform common maintenance operations.
Date: Tue, 26 Dec 2006 23:12:57 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612262312170.4473@woody.osdl.org>
References: <20061227070541.GA22982@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 27 08:13:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GzSyQ-00067o-Cy
	for gcvg-git@gmane.org; Wed, 27 Dec 2006 08:13:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932963AbWL0HNL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Dec 2006 02:13:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932965AbWL0HNL
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Dec 2006 02:13:11 -0500
Received: from smtp.osdl.org ([65.172.181.25]:35549 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932963AbWL0HNK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Dec 2006 02:13:10 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kBR7D12J020722
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 26 Dec 2006 23:13:02 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kBR7CvRL004097;
	Tue, 26 Dec 2006 23:13:00 -0800
To: "Shawn O. Pearce" <spearce@spearce.org>
In-Reply-To: <20061227070541.GA22982@spearce.org>
X-Spam-Status: No, hits=-2.658 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.107__
X-MIMEDefang-Filter: osdl$Revision: 1.165 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35448>



On Wed, 27 Dec 2006, Shawn O. Pearce wrote:
>
> Junio asked for a 'git gc' utility which users can execute on a
> regular basis to perform basic repository actions such as:
> 
>  * prune
>  * repack -a -d

You should do "repack -a -d" _before_ pruning, because then pruning will 
be much more efficient (thanks to a more efficient repo format).

		Linus
