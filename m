From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Fix filename verification when in a subdirectory
Date: Wed, 26 Apr 2006 11:14:00 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604261112240.3701@g5.osdl.org>
References: <17483.27938.890830.375324@cargo.ozlabs.ibm.com>
 <Pine.LNX.4.64.0604230906370.3701@g5.osdl.org> <E1FYlwn-0005mf-CL@moooo.ath.cx>
 <Pine.LNX.4.64.0604260832240.3701@g5.osdl.org> <Pine.LNX.4.64.0604261010390.3701@g5.osdl.org>
 <20060426210541.5e145e88.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: junkio@cox.net, matled@gmx.net, git@vger.kernel.org,
	paulus@samba.org
X-From: git-owner@vger.kernel.org Wed Apr 26 20:14:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FYoX9-0007i6-Bq
	for gcvg-git@gmane.org; Wed, 26 Apr 2006 20:14:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964776AbWDZSOg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Apr 2006 14:14:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964793AbWDZSOg
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Apr 2006 14:14:36 -0400
Received: from smtp.osdl.org ([65.172.181.4]:51127 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964776AbWDZSOg (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Apr 2006 14:14:36 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3QIE2tH004104
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 26 Apr 2006 11:14:02 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k3QIE0FG002953;
	Wed, 26 Apr 2006 11:14:01 -0700
To: Timo Hirvonen <tihirvon@gmail.com>
In-Reply-To: <20060426210541.5e145e88.tihirvon@gmail.com>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19216>



On Wed, 26 Apr 2006, Timo Hirvonen wrote:
> 
> Extra semicolon.

Duh, indeed. It just didn't show up in any of the normal cases.

Junio, just apply without that stupid semicolon..

		Linus
