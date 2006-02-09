From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Fatal error from git bisect
Date: Thu, 9 Feb 2006 11:50:49 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602091148080.2458@g5.osdl.org>
References: <7E000E7F06B05C49BDBB769ADAF44D0773A48E@NT-SJCA-0750.brcm.ad.broadcom.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 09 20:52:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F7Hoi-00033H-Ml
	for gcvg-git@gmane.org; Thu, 09 Feb 2006 20:51:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750728AbWBITuy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Feb 2006 14:50:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750742AbWBITuy
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Feb 2006 14:50:54 -0500
Received: from smtp.osdl.org ([65.172.181.4]:28889 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750728AbWBITux (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Feb 2006 14:50:53 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k19JooDZ016304
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 9 Feb 2006 11:50:50 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k19JonJr009344;
	Thu, 9 Feb 2006 11:50:49 -0800
To: Mark E Mason <mark.e.mason@broadcom.com>
In-Reply-To: <7E000E7F06B05C49BDBB769ADAF44D0773A48E@NT-SJCA-0750.brcm.ad.broadcom.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15819>


On Thu, 9 Feb 2006, Mark E Mason wrote:
>  
> I'm trying to use 'git bisect' and am running into the following error:
>
> fatal: Entry 'block/elevator.c' would be overwritten by merge. Cannot merge.

This seems to mean that you have a dirty block/elevator.c file. Have you 
perhaps edited it?

		Linus
