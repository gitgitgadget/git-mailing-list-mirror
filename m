From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH] user-manual: mention git gui citool (commit, amend)
Date: Fri, 3 Aug 2007 00:24:10 +0200
Message-ID: <107BD473-E055-47D0-9720-9D878BDAB954@zib.de>
References: <11858118802945-git-send-email-prohaska@zib.de> <20070802181853.GB31885@fieldses.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Fri Aug 03 00:23:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGj4o-0006kI-NJ
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 00:23:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754697AbXHBWXX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 18:23:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754522AbXHBWXX
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 18:23:23 -0400
Received: from mailer.zib.de ([130.73.108.11]:52205 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753124AbXHBWXW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 18:23:22 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l72MNIaD006207;
	Fri, 3 Aug 2007 00:23:19 +0200 (CEST)
Received: from [192.168.178.32] (brln-4db11ce5.pool.einsundeins.de [77.177.28.229])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l72MNHLW029033
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Fri, 3 Aug 2007 00:23:17 +0200 (MEST)
In-Reply-To: <20070802181853.GB31885@fieldses.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54631>


On Aug 2, 2007, at 8:18 PM, J. Bruce Fields wrote:

> On Mon, Jul 30, 2007 at 06:11:20PM +0200, Steffen Prohaska wrote:

>> +Another approach for creating commits is git gui:
>> +
>> +-------------------------------------------------
>> +$ git gui citool
>> +-------------------------------------------------
>> +
>> +starts the commit tool (Note, "`git gui`" starts the full gui, which
>> +provides more options).
>> +
>> +Beyond the basic operation of staging and unstaging complete files,
>> +git gui can also selectively stage diff hunks.  You can do so by
>> +selecting a modified or staged file and right-click on the diff view
>> +in the lower part of the gui. A pop-up will appear that lets you
>> +select a specific hunk and stage or unstage it for the next commit.
>> +This is particular useful for slicing large, ugly commits into  
>> smaller
>> +pieces, for example when cherry-picking (see
>> +<<reordering-patch-series>>).
>
> I wonder whether we could get away with just the brief list of  
> features
> ("lets you view changes in the index and the working file, lets you
> individually select diff hunks for inclusion in the index"), and leave
> the how-to stuff to online guit-gui help, if it's necessary?

Maybe, this would be sufficient. I mentioned the pop-up explicitly
because it wasn't obvious to me right away. The reason might be that
my brain adjusted too much to the Mac I'm using. Right-clicking and
pop-ups are rarely used on Macs as the only access point to essential
features, such as selectively staging diff hunks. Typically an icon
or menu entry guides you explicitly to every feature. Pop-ups are only
used for 'optimized' access but never as the only access point.


> Also, I like the verb "stage" as a way to explain the part of the  
> index
> file in creating commits, but I've been consistently using the word
> "index" throughout the user manual, and I think that's consistent with
> the rest of the documentation--so don't avoid it here.

"staging/unstaging" is how git gui calls adding/removing files to and
from the index.

	Steffen
