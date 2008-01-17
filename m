From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Wed, 16 Jan 2008 16:16:58 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801161615330.2806@woody.linux-foundation.org>
References: <478E1FED.5010801@web.de> <m33asxn2gt.fsf@roke.D-201> <65026F2B-5CE8-4238-A9AB-D3545D336B41@sb.org> <200801162251.54219.jnareb@gmail.com> <1574A90A-8C45-46AD-9402-34AE6F582B3F@sb.org> <alpine.LFD.1.00.0801161424040.2806@woody.linux-foundation.org>
 <7652B11D-9B9F-45EA-9465-8294B701FE7C@sb.org> <alpine.LFD.1.00.0801161522160.2806@woody.linux-foundation.org> <BA518A23-FBF8-49BB-BEFB-D9A6BA1E302C@simplicidade.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Kevin Ballard <kevin@sb.org>, Jakub Narebski <jnareb@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mark Junker <mjscod@web.de>, git@vger.kernel.org
To: Pedro Melo <melo@simplicidade.org>
X-From: git-owner@vger.kernel.org Thu Jan 17 01:17:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFIRt-0000D5-Gu
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 01:17:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751269AbYAQARJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 19:17:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750998AbYAQARH
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 19:17:07 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:58912 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751275AbYAQARG (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Jan 2008 19:17:06 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0H0GwQf001129
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 16 Jan 2008 16:16:59 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0H0Gw7H032156;
	Wed, 16 Jan 2008 16:16:58 -0800
In-Reply-To: <BA518A23-FBF8-49BB-BEFB-D9A6BA1E302C@simplicidade.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.716 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70782>



On Wed, 16 Jan 2008, Pedro Melo wrote:
> 
> The difference I see between us is that if I tell my filesystem that I want to
> name my file with a particular string encoded in X, users using encoding Y
> will be able to read it correctly. I  like my filesystem to make that work for
> me.

The difference I see between us is that when I tell you that this is 
exactly the same thing as your file *contents*, you don't seem to get it.

An OS that silently changes the contents of your files is *crap*.

Get it?

An OS that silently changes the contents of your directories is *crap*.

Get it now?

		Linus
