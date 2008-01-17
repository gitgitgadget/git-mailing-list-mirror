From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Wed, 16 Jan 2008 16:25:52 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801161619420.2806@woody.linux-foundation.org>
References: <478E1FED.5010801@web.de> <m33asxn2gt.fsf@roke.D-201> <65026F2B-5CE8-4238-A9AB-D3545D336B41@sb.org> <200801162251.54219.jnareb@gmail.com> <1574A90A-8C45-46AD-9402-34AE6F582B3F@sb.org> <alpine.LFD.1.00.0801161424040.2806@woody.linux-foundation.org>
 <7652B11D-9B9F-45EA-9465-8294B701FE7C@sb.org> <alpine.LFD.1.00.0801161522160.2806@woody.linux-foundation.org> <B45968C6-3029-48B6-BED2-E7D5A88747F7@sb.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mark Junker <mjscod@web.de>, git@vger.kernel.org
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Thu Jan 17 01:27:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFIb3-00036v-Ad
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 01:27:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751898AbYAQA0c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 19:26:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751598AbYAQA0c
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 19:26:32 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:33858 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751217AbYAQA0b (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Jan 2008 19:26:31 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0H0PrYB001773
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 16 Jan 2008 16:25:54 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0H0PqIS032556;
	Wed, 16 Jan 2008 16:25:53 -0800
In-Reply-To: <B45968C6-3029-48B6-BED2-E7D5A88747F7@sb.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.715 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70783>



On Wed, 16 Jan 2008, Kevin Ballard wrote:
> 
> My understanding is that normalization is there to help the computer. That
> doesn't give it any semantic meaning, because all normal forms of a given
> string still represent the exact same string to the user.

THAT IS NOT TRUE!

How the hell does the computer know what the string means?

Hint: it does not.

The fact is, the user may use a non-normalized string on purpose. It's not 
your place to say that the user is wrong. Your "undestanding" is simply 
wrong. Two strings are *different* if they are [un]normalized differently.

Really.

The exact same way the word Polish and polish are different, just because 
they are capitalized differently.

> The argument for case insensitivity is different than the argument for
> normalization. I certainly hope you understand why they are different
> arguments, or there's really no point in going further.

You do not understand.

In *order* to do case-insensitivity, you generally need to normalize (and 
do other things too - normalization is just *one* of the things you need 
to do).

So if you are a case-insensitive filesystem, then normalization is sane.

But if you aren't, then there is no reason to normalize.

> You're right, sometimes the sequence matters. As in key sequences. But we're
> not talking about key sequences, we're talking about strings.

You define "string" to be something totally made-up.

In your world "string" means "normalized". BUT IT'S NOT TRUE!

You define normalization to be a property of strings, without any actual 
backing for why that would be.

The fact is, *looks the same* is very very different from *is the same*.

But you seem to be too stupid to undestand the differce.

		Linus
