From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: Weird shallow-tree conversion state, and branches of shallow trees
Date: Mon, 16 Apr 2007 17:54:56 +0200
Message-ID: <20070416155456.GS955MdfPADPa@greensroom.kotnet.org>
References: <20070412005336.GA18378@curie-int.orbis-terrarum.net>
 <200704152051.35639.andyparkins@gmail.com>
 <Pine.LNX.4.64.0704151317180.5473@woody.linux-foundation.org>
 <200704161003.07679.andyparkins@gmail.com>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Robin H. Johnson" <robbat2@gentoo.org>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 16 17:55:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdTXj-0002tX-K3
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 17:55:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030780AbXDPPzA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Apr 2007 11:55:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030781AbXDPPzA
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Apr 2007 11:55:00 -0400
Received: from smtp15.wxs.nl ([195.121.247.6]:34492 "EHLO smtp15.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030780AbXDPPy7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2007 11:54:59 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by smtp15.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006)) with SMTP id
 <0JGL007HBLJK06@smtp15.wxs.nl> for git@vger.kernel.org; Mon,
 16 Apr 2007 17:54:58 +0200 (CEST)
Received: (qmail 868 invoked by uid 500); Mon, 16 Apr 2007 15:54:56 +0000
In-reply-to: <200704161003.07679.andyparkins@gmail.com>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44653>

On Mon, Apr 16, 2007 at 10:03:05AM +0100, Andy Parkins wrote:
> there are two copies of the same file floating around.  Which one am I 
> editing and which one am I printing?

Turn off write permissions on the generated file.

> Have I run the script yet?  When I 

Use a post-commit hook.

> I'm not just being argumentative - I still have not understood what terrible 
> evil it is that keyword expansion causes but crlf conversion does not.

For one thing, this keyword expansion thing requires the SCM to modify
the file during commit.  (Hey, my editor says something changed the file.
Do I have the file opened in another session?  Oh, it's the stupid
keyword expansion!)  AFAIU, crlf conversion will not change the working
tree copy of your file on commit.

skimo
