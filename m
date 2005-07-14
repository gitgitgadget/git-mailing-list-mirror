From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Document two pack push-pull protocols.
Date: Wed, 13 Jul 2005 20:34:01 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507132032460.19183@g5.osdl.org>
References: <7v64vem5rh.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 14 05:34:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DsuUP-0000Sh-OB
	for gcvg-git@gmane.org; Thu, 14 Jul 2005 05:34:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262881AbVGNDeI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jul 2005 23:34:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262882AbVGNDeI
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jul 2005 23:34:08 -0400
Received: from smtp.osdl.org ([65.172.181.4]:55237 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262881AbVGNDeH (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Jul 2005 23:34:07 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j6E3Y2jA015939
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 13 Jul 2005 20:34:02 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j6E3Y1R1022945;
	Wed, 13 Jul 2005 20:34:01 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v64vem5rh.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 13 Jul 2005, Junio C Hamano wrote:
> 
> There currently are these two pack push-pull protocols used for
> different purposes.  Maybe you invented another today?  I have
> not looked beyond your log message.

No, it's the upload-pack one.

The send-pack protocol is just for writing new stuff, not appropriate for
an anonymous connection with no authentication.

		Linus
