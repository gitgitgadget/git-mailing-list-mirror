From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Wed, 16 Jan 2008 16:19:30 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801161617070.2806@woody.linux-foundation.org>
References: <478E1FED.5010801@web.de> <m33asxn2gt.fsf@roke.D-201> <65026F2B-5CE8-4238-A9AB-D3545D336B41@sb.org> <200801162251.54219.jnareb@gmail.com> <1574A90A-8C45-46AD-9402-34AE6F582B3F@sb.org> <alpine.LFD.1.00.0801161424040.2806@woody.linux-foundation.org>
 <7652B11D-9B9F-45EA-9465-8294B701FE7C@sb.org> <alpine.LFD.1.00.0801161522160.2806@woody.linux-foundation.org> <85ir1tpbk8.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Kevin Ballard <kevin@sb.org>, Jakub Narebski <jnareb@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mark Junker <mjscod@web.de>, git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Thu Jan 17 01:29:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFIdb-0003wf-4s
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 01:29:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752554AbYAQA3N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 19:29:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752450AbYAQA3M
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 19:29:12 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:52847 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752484AbYAQA3L (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Jan 2008 19:29:11 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0H0SnWq001958
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 16 Jan 2008 16:28:50 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0H0JUA7032309;
	Wed, 16 Jan 2008 16:19:31 -0800
In-Reply-To: <85ir1tpbk8.fsf@lola.goethe.zz>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.715 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70785>



On Thu, 17 Jan 2008, David Kastrup wrote:
> 
> Actually, there is no good reason for non-normalized forms (deficient
> software not able to deal with some of the normalized forms is not a
> good reason: such software should be fixed).

I'd actually agree, and it then boils down to the second sane choice I 
gave earlier:

 - don't accept data you don't like

if you don't like non-normalized names, don't create them. That's fine.

But don't go normalizing them behind the users back.

> Yup.  But that does not mean that normalization is a bad idea.  It is
> just that the filesystem is not the right place for it.

Oh, absolutely. You can - and often should - normalize in the application 
(or have libraries to do it for you). 

Not silently and behind peoples backs.

		Linus
