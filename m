From: Mark Levedahl <mdl123@verizon.net>
Subject: Re: mingw, windows, crlf/lf, and git
Date: Mon, 12 Feb 2007 20:36:28 -0500
Message-ID: <45D1161C.6040805@verizon.net>
References: <45CFA30C.6030202@verizon.net> <20070212042425.GB18010@thunk.org>
 <Pine.LNX.4.64.0702120839490.8424@woody.linux-foundation.org>
 <7vps8f6l81.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0702130020450.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vfy9b6iyt.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0702130046450.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45D10D86.3030508@verizon.net>
 <Pine.LNX.4.63.0702130204120.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Theodore Tso <tytso@mit.edu>,
	Mark Levedahl <mlevedahl@verizon.net>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 13 02:36:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGmaw-0001oE-L0
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 02:36:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965466AbXBMBgb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 20:36:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965468AbXBMBgb
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 20:36:31 -0500
Received: from vms044pub.verizon.net ([206.46.252.44]:51210 "EHLO
	vms044pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965466AbXBMBga (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Feb 2007 20:36:30 -0500
Received: from [127.0.0.1] ([71.246.235.75])
 by vms044.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0JDD0019TOGQUD61@vms044.mailsrvcs.net> for
 git@vger.kernel.org; Mon, 12 Feb 2007 19:36:28 -0600 (CST)
In-reply-to: <Pine.LNX.4.63.0702130204120.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Newsgroups: gmane.comp.version-control.git
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39479>

Johannes Schindelin wrote:
> Hi,
> 
> On Mon, 12 Feb 2007, Mark Levedahl wrote:
> 
>> Perhaps I'm too paranoid, but I've been burnt way too many times by 
>> text/binary mode stuff to let this part be trivialized. Maybe it only 
>> gets enabled by core.ImReallyParanoid, but I want that option.
> 
> Be aware that what you proposed costs many CPU cycles. I am totally 
> opposed to enabling that option by default on all platforms. I am okay 
> with .gitattributes (but I would call it .gitfiletypes), but I am _not_ 
> okay with git being _too much_ fscked up by Windows. Microsoft has done 
> enough harm already.

I would assume that none of this crlf stuff exists at all on Linux / 
Unix / Posix, so if done right has zero impact outside of the Windows 
nuthouse. Inside that, folks are already so used to incredible slowness 
in file I/O that I'm not sure the round tripping I suggest as a check 
would be very noticeable, but in any case I fully agree it should be 
optional even there. However, if git could support something that never 
screws up, absolutely guaranteeing data integrity in the presence of 
these transforms, that would be a first in this arena and I believe a 
significant selling point.

Mark
