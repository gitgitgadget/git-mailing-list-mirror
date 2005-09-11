From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Fix buffer overflow in ce_flush().
Date: Sun, 11 Sep 2005 11:54:23 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509111153490.3242@g5.osdl.org>
References: <20050911132747.GA26401@mayhq.zapto.org>
 <Pine.LNX.4.58.0509111050040.3242@g5.osdl.org> <7vpsrfsavy.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Qingning Huo <qhuo@mayhq.co.uk>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 11 20:56:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEWyK-0005k3-VV
	for gcvg-git@gmane.org; Sun, 11 Sep 2005 20:54:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965040AbVIKSye (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Sep 2005 14:54:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965041AbVIKSye
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Sep 2005 14:54:34 -0400
Received: from smtp.osdl.org ([65.172.181.4]:48515 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965040AbVIKSyd (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Sep 2005 14:54:33 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8BIsOBo017767
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 11 Sep 2005 11:54:25 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8BIsN6W017084;
	Sun, 11 Sep 2005 11:54:24 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vpsrfsavy.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.115 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8320>



On Sun, 11 Sep 2005, Junio C Hamano wrote:
> 
> Hmph.  I thought ce_flush is not in the fast path so the extra
> check would not hurt...

Not a performance issue. A code simplicity issue. 

			Linus
