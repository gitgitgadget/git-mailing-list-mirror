From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: What should be the CRLF policy when win + Linux?
Date: Thu, 6 May 2010 13:23:56 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.1005061317250.901@i5.linux-foundation.org>
References: <4BE141E3.2060904@gmail.com> <x2h600158c31005051935i6f379a9j6aa36b4503776b87@mail.gmail.com>  <o2ved79be1d1005060029n67f451c6p3b48b83c51031222@mail.gmail.com>  <i2i600158c31005060834s72e10fb7te19048e3b174d29b@mail.gmail.com> 
 <alpine.LFD.2.00.1005061009020.901@i5.linux-foundation.org> <h2x600158c31005061300tfe485e01x251ae20b22ef5b27@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Erik Faye-Lund <kusmabite@googlemail.com>
To: hasen j <hasan.aljudy@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 06 22:26:15 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OA7eA-0002Sd-Nx
	for gcvg-git-2@lo.gmane.org; Thu, 06 May 2010 22:26:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758630Ab0EFU0I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 May 2010 16:26:08 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:37354 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757699Ab0EFU0F (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 May 2010 16:26:05 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o46KPhLm010667
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 6 May 2010 13:25:44 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id o46KPh0F011740;
	Thu, 6 May 2010 13:25:43 -0700
In-Reply-To: <h2x600158c31005061300tfe485e01x251ae20b22ef5b27@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.446 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146493>



On Thu, 6 May 2010, hasen j wrote:
> 
> My problem with autocrlf is that, well, it converts line endings in
> the working directory to CRLF, even though I don't always want it to.
> (most of the time, I don't).

You can just set it to 'input' if you want to. It's not just on/off, you 
can also say "I want to check out with no conversion (ie "just LF"), but 
convert CRLF to LF on input".

Btw, one thing to keep in mind with autocrlf is the "auto" part: it tries 
to do a good job noticing when something is text vs binary, but it _is_ a 
heuristic. I think it's a pretty good one, but if you do set autocrlf 
(whether to "true" or to "input"), at least think about attributes ("man 
gitattributes")

		Linus
