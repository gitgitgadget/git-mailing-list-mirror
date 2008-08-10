From: Lars Noschinski <lars-2008-1@usenet.noschinski.de>
Subject: Re: [PATCH] git gui: visually wrap lines of commit message
Date: Sun, 10 Aug 2008 09:56:03 +0200
Message-ID: <20080810075602.GA5381@lars.home.noschinski.de>
References: <20080809160557.GA902@localhost> <200808092344.33332.johannes.sixt@telecom.at> <20080809220637.GA20963@localhost> <200808100014.13408.johannes.sixt@telecom.at> <20080809224150.GA21530@localhost> <20080810022504.GA22137@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Clemens Buchacher <drizzd@aon.at>,
	Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Aug 10 09:57:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KS5nc-00073t-Md
	for gcvg-git-2@gmane.org; Sun, 10 Aug 2008 09:57:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752589AbYHJH4K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Aug 2008 03:56:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752847AbYHJH4K
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Aug 2008 03:56:10 -0400
Received: from smtprelay04.ispgateway.de ([80.67.18.16]:39918 "EHLO
	smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752589AbYHJH4I (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2008 03:56:08 -0400
Received: from [87.78.65.145] (helo=vertikal.home.noschinski.de)
	by smtprelay04.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <lars-2008-1@usenet.noschinski.de>)
	id 1KS5mW-0007ub-Jf; Sun, 10 Aug 2008 09:56:04 +0200
Received: from lars by vertikal.home.noschinski.de with local (Exim 4.69)
	(envelope-from <lars-2008-1@usenet.noschinski.de>)
	id 1KS5mV-0001Su-87; Sun, 10 Aug 2008 09:56:03 +0200
Content-Disposition: inline
In-Reply-To: <20080810022504.GA22137@spearce.org>
User-Agent: mutt-ng/devel-r804 (Linux)
X-Df-Sender: 336680
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91808>

* Shawn O. Pearce <spearce@spearce.org> [08-08-10 04:25]:
>> Maybe I'm doing something wrong, but on my system (wish8.5) the box width
>> changes with the window size, and gui.commitmsgwidth appears to be ignored.
>> Even if I close and restart git gui, the old window size is kept.
>
>That's a bug, and I now understand why you have a problem.  That box
>should not be resizing itself.  Its supposed to be using a fixed
>width font, and have a fixed number of columns, so you can format
>a message including drawing ASCII art to explain yourself clearly
>as you write a change.

The box always resizes, unless the window is wide enough. But I do not
see a good way to fix that.
