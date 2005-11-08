From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Comments on recursive merge..
Date: Tue, 8 Nov 2005 13:52:06 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511081351020.3247@g5.osdl.org>
References: <Pine.LNX.4.64.0511070837530.3193@g5.osdl.org>
 <20051107225807.GA10937@c165.ib.student.liu.se> <7vll00ov2l.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0511071629270.3247@g5.osdl.org>
 <Pine.LNX.4.63.0511081254520.2649@wbgn013.biozentrum.uni-wuerzburg.de>
 <20051108210211.GA23265@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 08 22:54:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZbP6-0005de-BM
	for gcvg-git@gmane.org; Tue, 08 Nov 2005 22:53:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030362AbVKHVwk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 Nov 2005 16:52:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030368AbVKHVwk
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Nov 2005 16:52:40 -0500
Received: from smtp.osdl.org ([65.172.181.4]:11756 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030362AbVKHVwj (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Nov 2005 16:52:39 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jA8LqQnO027078
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 8 Nov 2005 13:52:26 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jA8Lq60N022213;
	Tue, 8 Nov 2005 13:52:15 -0800
To: Fredrik Kuivinen <freku045@student.liu.se>
In-Reply-To: <20051108210211.GA23265@c165.ib.student.liu.se>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11360>



On Tue, 8 Nov 2005, Fredrik Kuivinen wrote:
>
> * The code for finding common ancestors is also written in Python and
>   is probably a bit slower than git-merge-base.

Btw, what part of git-merge-bases is it that makes it not be practical?

			Linus
