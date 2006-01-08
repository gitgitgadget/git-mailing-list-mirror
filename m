From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git pull on Linux/ACPI release tree
Date: Sun, 8 Jan 2006 11:57:32 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0601081156430.3169@g5.osdl.org>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005A13505@hdsmsx401.amr.corp.intel.com>
 <46a038f90601081119r39014fbi995cc8b6e95774da@mail.gmail.com>
 <7vace61plu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	"Brown, Len" <len.brown@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	akpm@osdl.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 08 20:58:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EvggF-0002si-Sa
	for gcvg-git@gmane.org; Sun, 08 Jan 2006 20:58:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932761AbWAHT5o (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Jan 2006 14:57:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161191AbWAHT5n
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jan 2006 14:57:43 -0500
Received: from smtp.osdl.org ([65.172.181.4]:9887 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932761AbWAHT5m (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Jan 2006 14:57:42 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k08JvXDZ026911
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 8 Jan 2006 11:57:34 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k08JvWaH001423;
	Sun, 8 Jan 2006 11:57:32 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vace61plu.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.64__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14331>



On Sun, 8 Jan 2006, Junio C Hamano wrote:
> 
> Careful.  I do not think rebase works across merges at all.

Right. You have to do one or the other (rebase your changes to another 
tree _or_ merge another tree into your changes), but not mix the two.

		Linus
