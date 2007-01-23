From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] sha1_file.c: Avoid multiple calls to find_pack_entry().
Date: Mon, 22 Jan 2007 19:17:55 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0701221909190.32200@woody.linux-foundation.org>
References: <20070122202945.GA29297@bohr.gbar.dtu.dk>  <45B524E1.5060205@fs.ei.tum.de>
  <Pine.LNX.4.64.0701221611210.32200@woody.linux-foundation.org>
 <118833cc0701221810kf817ddcm2bff07f3a848d1c2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 23 04:18:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9CAe-0003Vw-IF
	for gcvg-git@gmane.org; Tue, 23 Jan 2007 04:18:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751723AbXAWDR7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 Jan 2007 22:17:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751834AbXAWDR7
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jan 2007 22:17:59 -0500
Received: from smtp.osdl.org ([65.172.181.24]:46826 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751723AbXAWDR6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jan 2007 22:17:58 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l0N3Ht3U020638
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 22 Jan 2007 19:17:56 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l0N3Htnj009663;
	Mon, 22 Jan 2007 19:17:55 -0800
To: Morten Welinder <mwelinder@gmail.com>
In-Reply-To: <118833cc0701221810kf817ddcm2bff07f3a848d1c2@mail.gmail.com>
X-Spam-Status: No, hits=-2.715 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.108__
X-MIMEDefang-Filter: osdl$Revision: 1.170 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37479>



On Mon, 22 Jan 2007, Morten Welinder wrote:
>
> (And I sadly note that linux.cs.helsinki.fi is nowadays refusing finger 
> connections.)

I think the ascii barfics went away even before I left University due to a 
dead harddisk, and me being too lazy to re-create my changing fingerd and 
all the cruddy ascii art.

I think Helsinki University ended up having a simple finger service for a 
while to return the versioning thing (just because it was in too many 
FAQ's to drop entirely), but I don't think the great artwork was ever 
recreated..

(In all honesty, I don't think it ever really had more than a couple of 
pictures - the weasel, the sleeping cat, and some random other ones. 
"Great art" it was not..)

		Linus
