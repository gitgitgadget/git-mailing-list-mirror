From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: On Tabs and Spaces
Date: Thu, 18 Oct 2007 08:36:23 +0400
Message-ID: <20071018043623.GA20054@dpotapov.dyndns.org>
References: <634393B0-734A-4884-93E3-42F7D3CB157F@mit.edu> <471476B7.5050105@users.sourceforge.net> <8c5c35580710160204s5a4f9fb3j68c0a86c4d080cb7@mail.gmail.com> <47148F72.1090602@users.sourceforge.net> <1192548367.3821.4.camel@lt21223.campus.dmacc.edu> <B2F6DB0C-4EFE-4C56-8E7A-31820320CA02@mit.edu> <3awb7zw6.fsf@blue.sea.net> <alpine.LFD.0.999.0710161214530.6887@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jari Aalto <jari.aalto@cante.net>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Oct 18 06:36:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiN7d-00074S-Cr
	for gcvg-git-2@gmane.org; Thu, 18 Oct 2007 06:36:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753767AbXJREg0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 00:36:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753802AbXJREg0
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 00:36:26 -0400
Received: from smtp05.mtu.ru ([62.5.255.52]:57235 "EHLO smtp05.mtu.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753742AbXJREgZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 00:36:25 -0400
Received: from potapov.private (ppp85-141-239-26.pppoe.mtu-net.ru [85.141.239.26])
	by smtp05.mtu.ru (Postfix) with ESMTP id AC01E985DD5;
	Thu, 18 Oct 2007 08:36:23 +0400 (MSD)
Received: from dpotapov by potapov.private with local (Exim 4.63)
	(envelope-from <dpotapov@gmail.com>)
	id 1IiN7P-0005GA-BM; Thu, 18 Oct 2007 08:36:23 +0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.999.0710161214530.6887@woody.linux-foundation.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61464>

On Tue, Oct 16, 2007 at 12:20:50PM -0700, Linus Torvalds wrote:
> The answer is *also* not "tabs are just for initial code 
> indents",

Unfortunately, it leads to some problems. For example, you can type:
git blame alloc.c

2c1cbec1 (Linus Torvalds     2007-04-16 22:10:19 -0700 21) #define DEFINE_ALLOCATOR(name, type)				\
855419f7 (Linus Torvalds     2006-06-19 10:44:15 -0700 22) static unsigned int name##_allocs;				\
100c5f3b (Linus Torvalds     2007-04-16 22:11:43 -0700 23) void *alloc_##name##_node(void)					\
855419f7 (Linus Torvalds     2006-06-19 10:44:15 -0700 24) {								\
855419f7 (Linus Torvalds     2006-06-19 10:44:15 -0700 25) 	static int nr;						\

and see that the end of line 23 does not look right. Because of that,
I prefer tabs for initial code indents and spaces in other places. Of
course, my preferences are irrelevant when it comes to someone else's
project, and I can easily use whatever style it takes to get things
done. It is just that "use tabs elsewhere and everything will be fine
as long as you have the standard tab setting" is not exactly correct.
The rest is people's preferences and habits...

Dmitry
