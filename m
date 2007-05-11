From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] [TRIVIAL] Change default man page path to
 /usr/share/man
Date: Fri, 11 May 2007 10:42:53 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0705111041140.3986@woody.linux-foundation.org>
References: <200705081349.34964.ismail@pardus.org.tr>
 <200705112025.58095.ismail@pardus.org.tr>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463790079-873539324-1178905374=:3986"
Cc: git@vger.kernel.org
To: =?iso-8859-15?Q?Ismail_D=F6nmez?= <ismail@pardus.org.tr>
X-From: git-owner@vger.kernel.org Fri May 11 19:43:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmZ9I-0001nh-Ef
	for gcvg-git@gmane.org; Fri, 11 May 2007 19:43:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754492AbXEKRnU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 May 2007 13:43:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757700AbXEKRnU
	(ORCPT <rfc822;git-outgoing>); Fri, 11 May 2007 13:43:20 -0400
Received: from smtp1.linux-foundation.org ([65.172.181.25]:45621 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754492AbXEKRnT (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 May 2007 13:43:19 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l4BHgsCY028388
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 11 May 2007 10:42:55 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l4BHgr3x022261;
	Fri, 11 May 2007 10:42:54 -0700
In-Reply-To: <200705112025.58095.ismail@pardus.org.tr>
X-Spam-Status: No, hits=-4.989 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.53 on 65.172.181.25
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46972>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463790079-873539324-1178905374=:3986
Content-Type: TEXT/PLAIN; charset=iso-8859-15
Content-Transfer-Encoding: 8BIT



On Fri, 11 May 2007, Ismail Dönmez wrote:
> 
> ACK? NAK? Do we care about this? :)

I'll Ack it, for what it's worth.

As it is, I actually end up doing

	make prefix=/usr/local/share install-doc

(or something like that) to get things in the right place.

I think the old "$(prefix)/man" is just because I still mentally live in 
the early 90's most of the time.

		Linus
---1463790079-873539324-1178905374=:3986--
