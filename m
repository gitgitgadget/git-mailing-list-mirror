From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] git gui: visually wrap lines of commit message
Date: Sun, 10 Aug 2008 00:59:13 -0700
Message-ID: <20080810075913.GB24229@spearce.org>
References: <20080809160557.GA902@localhost> <200808092344.33332.johannes.sixt@telecom.at> <20080809220637.GA20963@localhost> <200808100014.13408.johannes.sixt@telecom.at> <20080809224150.GA21530@localhost> <20080810022504.GA22137@spearce.org> <20080810075602.GA5381@lars.home.noschinski.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Clemens Buchacher <drizzd@aon.at>,
	Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org
To: Lars Noschinski <lars-2008-1@usenet.noschinski.de>
X-From: git-owner@vger.kernel.org Sun Aug 10 10:00:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KS5qb-0008OM-Q6
	for gcvg-git-2@gmane.org; Sun, 10 Aug 2008 10:00:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752891AbYHJH7P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Aug 2008 03:59:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752951AbYHJH7P
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Aug 2008 03:59:15 -0400
Received: from george.spearce.org ([209.20.77.23]:45428 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752393AbYHJH7O (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2008 03:59:14 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id DD28638375; Sun, 10 Aug 2008 07:59:13 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20080810075602.GA5381@lars.home.noschinski.de>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91809>

Lars Noschinski <lars-2008-1@usenet.noschinski.de> wrote:
> * Shawn O. Pearce <spearce@spearce.org> [08-08-10 04:25]:
>>> Maybe I'm doing something wrong, but on my system (wish8.5) the box width
>>> changes with the window size, and gui.commitmsgwidth appears to be ignored.
>>> Even if I close and restart git gui, the old window size is kept.
>>
>> That's a bug, and I now understand why you have a problem.  That box
>> should not be resizing itself.  Its supposed to be using a fixed
>> width font, and have a fixed number of columns, so you can format
>> a message including drawing ASCII art to explain yourself clearly
>> as you write a change.
>
> The box always resizes, unless the window is wide enough. But I do not
> see a good way to fix that.

Oh, you mean the window isn't large enough to show the full column
width of the text area?  But if you make it large enough, the box
stops expanding?

-- 
Shawn.
