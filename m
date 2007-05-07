From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: Anyone running GIT on native Windows
Date: Mon, 07 May 2007 14:01:03 +0200
Organization: eudaptics software gmbh
Message-ID: <463F14FF.F8DF11EB@eudaptics.com>
References: <2b6901c78faa$cf9aa7e0$0200a8c0@AMD2500>
		 <7vejlufmhd.fsf@assigned-by-dhcp.cox.net>
		 <2b7f01c78fb1$be4dc6a0$0200a8c0@AMD2500>
		 <463ECEF4.625F3633@eudaptics.com> <e5bfff550705070448t7813d064mbac82abb45591888@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 07 14:01:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hl1uc-0007fp-4f
	for gcvg-git@gmane.org; Mon, 07 May 2007 14:01:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933482AbXEGMBA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 May 2007 08:01:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933506AbXEGMBA
	(ORCPT <rfc822;git-outgoing>); Mon, 7 May 2007 08:01:00 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:28237 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933482AbXEGMA7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2007 08:00:59 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtp (Exim 4.44)
	id 1Hl1tg-0004fe-Bb; Mon, 07 May 2007 14:00:56 +0200
Received: from eudaptics.com (unknown [192.168.1.88])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 1481354D; Mon,  7 May 2007 14:00:56 +0200 (CEST)
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
X-Spam-Score: 0.0 (/)
X-Spam-Report: AWL=0.042
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46452>

Marco Costalba wrote:
> 
> On 5/7/07, Johannes Sixt <J.Sixt@eudaptics.com> wrote:
> > Aaron Gray wrote:
> > > What I want is to be able to work in Windows CMD and envoke .sh scripts by
> > > association (unfortunately you have to add the .sh on the command name
> > > though).
> >
> > I run the mingw port exclusively from CMD without a .sh association. So
> > exclusively that I don't even know whether any other way of using the
> > tools even works. Of course, you have to get used to
> >
> 
> Is it public available?

gitweb: http://repo.or.cz/w/git/mingw.git
clone:  git://repo.or.cz/git/mingw.git

I only have either time to hack on mingw.git or a Windows installation,
but not both at the same time. Therefore, the port is now a bit falling
back (it's still at 1.5.1). I hope to be able to change this in a few
weeks.

The next big thing to think about is an installer. Does anyone have a
suggestion for a free installer tool? I only know about Microsoft's WiX
(wix.sf.net), but it requires .NET (for the developer, not the user).

-- Hannes
