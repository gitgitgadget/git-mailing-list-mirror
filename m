From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Linux 2.6.15-rc2
Date: Thu, 24 Nov 2005 10:37:15 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511241020050.13959@g5.osdl.org>
References: <Pine.LNX.4.64.0511191934210.8552@g5.osdl.org>
 <200511240737.59153.tomlins@cam.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932647AbVKXShc@vger.kernel.org Thu Nov 24 19:38:11 2005
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932647AbVKXShc@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EfLyx-0004BT-OP
	for glk-linux-kernel-3@gmane.org; Thu, 24 Nov 2005 19:38:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932647AbVKXShc (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Thu, 24 Nov 2005 13:37:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932646AbVKXShc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 13:37:32 -0500
Received: from smtp.osdl.org ([65.172.181.4]:62089 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932642AbVKXShb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 13:37:31 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jAOIbGnO029869
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 24 Nov 2005 10:37:17 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jAOIbFbn006698;
	Thu, 24 Nov 2005 10:37:15 -0800
To: Ed Tomlinson <tomlins@cam.org>
In-Reply-To: <200511240737.59153.tomlins@cam.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.56__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12709>



On Thu, 24 Nov 2005, Ed Tomlinson wrote:
> 
> What is happening?

The http transport isn't very good for git, so git adds various special 
files to make it work at all. They need to be specially updated, and I 
hadn't done that.

Using the native git protocol through git://git.kernel.org/.. gets around 
it, as does using rsync. 

I just repacked and updated it now, so how http should work too, although 
inefficiently (because it will get a whole new pack - just one of the 
disadvantages of the non-native protocols).

		Linus
