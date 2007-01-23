From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] sha1_file.c: Avoid multiple calls to find_pack_entry().
Date: Mon, 22 Jan 2007 16:25:14 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0701221611210.32200@woody.linux-foundation.org>
References: <20070122202945.GA29297@bohr.gbar.dtu.dk> <45B524E1.5060205@fs.ei.tum.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Peter Eriksen <s022018@student.dtu.dk>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 23 01:29:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H99Xp-0001mg-IU
	for gcvg-git@gmane.org; Tue, 23 Jan 2007 01:29:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932582AbXAWA2j (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 Jan 2007 19:28:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932560AbXAWA2j
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jan 2007 19:28:39 -0500
Received: from smtp.osdl.org ([65.172.181.24]:39675 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932584AbXAWA2h (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jan 2007 19:28:37 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l0N0PG3U016303
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 22 Jan 2007 16:25:16 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l0N0PEpX006654;
	Mon, 22 Jan 2007 16:25:15 -0800
To: "Simon 'corecode' Schubert" <corecode@fs.ei.tum.de>
In-Reply-To: <45B524E1.5060205@fs.ei.tum.de>
X-Spam-Status: No, hits=-2.322 required=5 tests=AWL,BIZ_TLD,CASHCASHCASH,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.108__
X-MIMEDefang-Filter: osdl$Revision: 1.170 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37471>



On Mon, 22 Jan 2007, Simon 'corecode' Schubert wrote:
> 
> -- 
> Serve - BSD     +++  RENT this banner advert  +++    ASCII Ribbon   /"\
> Work - Mac      +++  space for low  NOW!1  +++      Campaign     \ /
> Party Enjoy Relax   |   http://dragonflybsd.org      Against  HTML   \
> Dude 2c 2 the max   !   http://golden-apple.biz       Mail + News   / \

Whee. It's been a long time since I saw ascii barfics and posted them to 
alt.fan.warlord, and I doubt the newsgroup even exists any more, but I 
have to commend you for getting a tab-damaged ascii barfic even without 
using any TAB characters!

I assume there are three '$$$' characters missing in your banner 
advertizing space. Maybe an Euro character? The joys of tab-damage just 
expands in the modern world of new character sets..

For extra points, please add ascii runes and/or big ascii swords to your 
signature, to make it truly old-time warlord material.

		Linus "nostalgic for afw" Torvalds
