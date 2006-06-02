From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: http-fetch troubles
Date: Fri, 2 Jun 2006 15:34:34 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606021527340.5498@g5.osdl.org>
References: <20060601232437.GD12261@reactrix.com> <7vhd34dptq.fsf@assigned-by-dhcp.cox.net>
 <7vac8vbgqg.fsf_-_@assigned-by-dhcp.cox.net> <7vmzcv9pba.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nick Hengeveld <nickh@reactrix.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 03 00:34:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FmIE8-00018m-Ng
	for gcvg-git@gmane.org; Sat, 03 Jun 2006 00:34:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030328AbWFBWel (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Jun 2006 18:34:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030330AbWFBWel
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jun 2006 18:34:41 -0400
Received: from smtp.osdl.org ([65.172.181.4]:7353 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030328AbWFBWel (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Jun 2006 18:34:41 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k52MYZ2g017896
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 2 Jun 2006 15:34:36 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k52MYYS1025776;
	Fri, 2 Jun 2006 15:34:35 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vmzcv9pba.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.75__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21179>



On Fri, 2 Jun 2006, Junio C Hamano wrote:
>
> I think this fixes the http trouble with tree parser change in
> the "next" branch.

Ahh, my bad. That happened as a bug in my original understanding of that 
fetch.c thing.

Your fix looks obviously fine,

               Linus
