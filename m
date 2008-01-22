From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Mon, 21 Jan 2008 19:17:51 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801211914500.2957@woody.linux-foundation.org>
References: <478E1FED.5010801@web.de> <C6C0E6A1-053B-48CE-90B3-8FFB44061C3B@sb.org> <alpine.LFD.1.00.08! 01211129130.2957@woody.linux-foundation.org> <373E260A-6786-4932-956A-68706AA7C469@sb.org> <alpine.LFD.1.00.! 0801211210270.2957@woody.linux-foundation.org>
 <7EB98659-4036-45DA-BD50-42CB23ED517A@sb.org> <alpine.LFD.1.0! 0.0801211323120.2957@woody.linux-foundation.org> <C373E12A-2AC4-4961-833A-7D51584143C9@sb.org> <alpine.LFD.1.00.0! 801211407130.2957@woody.linux-foundation.org> <0CA4DF3F-1B64-4F62-8794-6F82C21BD068@sb.org>
 <alpine.LFD.1.00.0801211538590.2957@woody.linux-foundation.org> <F663E088-BCAD-4C5D-89D5-EAF97A29C1DE@sb.org> <alpine.LFD.1.00.0801211656130.2957@woody.linux-foundation.org> <alpine.LFD.1.00.0801211702050.2957@woody.linux-foundati! on.org>
 <34103945-2078-4983-B409-2D01EF071A8B@sb.org> <alpine.LFD.1.00.0801211846010.2957@woody.linux-foundation.! org> <E3E4F5B3-1740-47E4-A432-C881830E2037@sb.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Peter Karlsson <peter@softwolves.pp.se>,
	Mark Junker <mjscod@web.de>,
	Pedro Melo <melo@simplicidade.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Tue Jan 22 04:18:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JH9ey-0004CY-8R
	for gcvg-git-2@gmane.org; Tue, 22 Jan 2008 04:18:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763064AbYAVDSK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 22:18:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762889AbYAVDSJ
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 22:18:09 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:47444 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760698AbYAVDSH (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Jan 2008 22:18:07 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0M3Hq5W014177
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 21 Jan 2008 19:17:53 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0M3Hp2E001855;
	Mon, 21 Jan 2008 19:17:52 -0800
In-Reply-To: <E3E4F5B3-1740-47E4-A432-C881830E2037@sb.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.722 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71406>



On Mon, 21 Jan 2008, Kevin Ballard wrote:
> 
> No, I am not asking git to do the same thing HFS+ does. You just persist in
> misinterpreting my arguments, no matter how many times I protest that this is
> not what I am saying.

Sure you do. You continue to say that unicode is the only choice, and you 
continue to say that unicode requires that equivalent names be considered 
the same.

What part of that was I mis-interpreting?

> So, what, you're saying git shouldn't do any work at all to try and behave
> nicer on OS X? Because OS X sure as hell can't change to suit git.

Umm. Git works perfectly fine on OS X, and it's not like we can do a whole 
lot more about it, exactly because we cannot fix the real problem. We can 
hide some of the fallout (idiotic choice of normalization), but the bigger 
issues we can hardly even do anything about (case independence).

And quite frankly, you've also made sure that I have absolutely zero 
interest in even trying to help people with it.

			Linus
