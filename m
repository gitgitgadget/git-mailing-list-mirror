From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: Commit ID in exported Tar Ball
Date: Sun, 20 May 2007 12:28:53 -0400
Message-ID: <817CD103-261C-4D40-9C8F-00B2E14130BE@silverinsanity.com>
References: <20070517163803.GE4095@cip.informatik.uni-erlangen.de> <200705171857.22891.johan@herland.net> <20070517171150.GL5272@planck.djpig.de> <464F5CA2.3070809@lsrfire.ath.cx> <7vd50wv88t.fsf@assigned-by-dhcp.cox.net> <20070520035752.GG3141@spearce.org> <20070520161048.GI5015@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <junkio@cox.net>,
	=?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Frank Lichtenheld <frank@lichtenheld.de>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Michael Gernoth <simigern@cip.informatik.uni-erlangen.de>
To: Thomas Glanzmann <thomas@glanzmann.de>
X-From: git-owner@vger.kernel.org Sun May 20 18:29:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpoHL-0000Gq-Bx
	for gcvg-git@gmane.org; Sun, 20 May 2007 18:29:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758124AbXETQ3A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 12:29:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758137AbXETQ3A
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 12:29:00 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:37834 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758124AbXETQ3A (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 12:29:00 -0400
Received: from [192.168.1.4] (cpe-69-205-115-17.rochester.res.rr.com [69.205.115.17])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id AEDBC1FFC03B;
	Sun, 20 May 2007 16:28:57 +0000 (UTC)
In-Reply-To: <20070520161048.GI5015@cip.informatik.uni-erlangen.de>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47854>


On May 20, 2007, at 12:10 PM, Thomas Glanzmann wrote:

> Hello,
>
>> git-describe is more human-friendly than a SHA-1...
>
> For me git-describe does the following:
>
>         (thinkpad) [~/work/slides] git-describe --all HEAD
>         heads/master
>
> I don't see how Michael is able to tell from this output what version
> his users is using. Do I miss something? I really do like the patch  
> Rene
> has submitted. And it is exactly what is missing. A unique identifier
> which tells the exact version of the tree the user is using.

For version information it is far more useful to use --tags or no  
options (annotated tags only) instead of --all.

# On git.git's master this morning:
$ git describe HEAD
v1.5.2
$ git describe HEAD^^
v1.5.2-rc3-97-g03f6db0

~~ Brian
