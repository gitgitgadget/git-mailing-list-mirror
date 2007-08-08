From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Submodules
Date: Wed, 08 Aug 2007 12:59:30 -0700
Message-ID: <7vps1x3ihp.fsf@assigned-by-dhcp.cox.net>
References: <a1bbc6950708071537xfa6b9a0ne8cf66e345fa31b4@mail.gmail.com>
	<Pine.LNX.4.64.0708072349400.14781@racer.site>
	<a1bbc6950708071631w5d232e92gd0fa27158b27b5c3@mail.gmail.com>
	<20070808104117.GK999MdfPADPa@greensroom.kotnet.org>
	<7vhcn94y9l.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0708082138520.21916@wbgn129.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: skimo@liacs.nl, Dmitry Kakurin <dmitry.kakurin@gmail.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Aug 08 22:00:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIrhO-0001H7-DA
	for gcvg-git@gmane.org; Wed, 08 Aug 2007 22:00:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936101AbXHHT7e (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Aug 2007 15:59:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760831AbXHHT7d
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Aug 2007 15:59:33 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:52605 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936069AbXHHT7b (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2007 15:59:31 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070808195932.GGCZ2095.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Wed, 8 Aug 2007 15:59:32 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id ZXzW1X0071kojtg0000000; Wed, 08 Aug 2007 15:59:30 -0400
In-Reply-To: <Pine.LNX.4.64.0708082138520.21916@wbgn129.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Wed, 8 Aug 2007 21:40:59 +0200
	(CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55352>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Wed, 8 Aug 2007, Junio C Hamano wrote:
>
>> +  Note that the current submodule support is minimal and this is
>> +  deliberately so.  A design decision we made is that operations
>> +  at the supermodule level do not recurse into submodules by
>> +  default.  The expectation is that later we would add a
>> +  mechanism to tell git which submodules the user is interested
>> +  in, and this information might be used to determine the
>> +  recursive behaviour of certain commands (e.g. "git checkout"
>> +  and "git diff"), but currently we haven't agreed on what that
>> +  mechanism should look like.  Therefore, if you use submodules,
>> +  you would probably need "git submodule update" on the
>> +  submodules you care about after running a "git checkout" at
>> +  the supermodule level.
>> +
>
> Nice write up!
>
> Is it true that you can run "update" without "init" first?  (I haven't 
> tried yet.)
>
> Also, I realised that git is not really happy unless you install 
> alternates pointing to the object stores of the submodules.  Shouldn't we 
> make this my default (for example in "init")?

Sorry, but I do not use submodules yet myself.  The questions
need to be answered, errors need to be corrected and omissions
need to be added by people who have been more involved in that
area of the system.

That's would be Sven and Lars, probably.

I also think we should have a paragraph of similar spirit
about the work-tree stuff as the top-level bullet point, before
the "New commands and options" list.  I suspect Matthias and you
are the prime candidates to do the honors?
