From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC 5/5] Support 'master@2 hours ago' syntax
Date: Wed, 17 May 2006 07:46:51 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605170745270.10823@g5.osdl.org>
References: <20060517095609.GF28529@spearce.org> <7vbqtwhpum.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 17 16:47:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgNIz-0002Zx-K7
	for gcvg-git@gmane.org; Wed, 17 May 2006 16:47:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750718AbWEQOrG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 May 2006 10:47:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750735AbWEQOrG
	(ORCPT <rfc822;git-outgoing>); Wed, 17 May 2006 10:47:06 -0400
Received: from smtp.osdl.org ([65.172.181.4]:51860 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750718AbWEQOrC (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 May 2006 10:47:02 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4HEkqtH024686
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 17 May 2006 07:46:52 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4HEkp9n015398;
	Wed, 17 May 2006 07:46:52 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vbqtwhpum.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20204>



On Wed, 17 May 2006, Junio C Hamano wrote:
> 
> This does not allow '2006-05-17 00:00:00' as the timespec, and
> the documentation carefully avoids giving that example, but I
> think it is better to spell that limitation out.

It doesn't? The "approxidate()" function should handle any reasonable date 
specifier, and the above is certainly more than reasonable.

Why doesn't approxidate handle it?

		Linus
