From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: CAREFUL! No more delta object support!
Date: Mon, 27 Jun 2005 19:48:51 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506271946140.19755@ppc970.osdl.org>
References: <Pine.LNX.4.58.0506271755140.19755@ppc970.osdl.org>
 <7vwtofi6jk.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0506271910390.19755@ppc970.osdl.org>
 <7vslz3yzwf.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 28 04:40:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dn61G-0002YB-3w
	for gcvg-git@gmane.org; Tue, 28 Jun 2005 04:40:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262389AbVF1CrF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Jun 2005 22:47:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262392AbVF1CrF
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Jun 2005 22:47:05 -0400
Received: from smtp.osdl.org ([65.172.181.4]:52965 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262389AbVF1Cq6 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Jun 2005 22:46:58 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j5S2kljA006840
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 27 Jun 2005 19:46:47 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j5S2kjbh008929;
	Mon, 27 Jun 2005 19:46:46 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vslz3yzwf.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0.667 required=5 tests=MANY_EXCLAMATIONS
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 27 Jun 2005, Junio C Hamano wrote:
> 
> By the way, you broke t/t0000 with the last commit.  Now an
> empty GIT_OBJECT_DIRECTORY has 257 subdirectories.

Yup, I noticed that. Fix pushed out (along with another one that was 
failing because it wanted to create the "pack" directory itself, and was 
unhappy when it already existed).

		Linus
