From: "J.H." <warthog19@eaglescrag.net>
Subject: Re: [RFC] Git Wiki Move
Date: Mon, 18 Jan 2010 10:47:25 -0800
Message-ID: <4B54ACBD.6000000@eaglescrag.net>
References: <20100113232908.GA3299@machine.or.cz> <20100114012449.GB3299@machine.or.cz> <4B4EF1E0.3040808@eaglescrag.net> <vpqbpgxrn32.fsf@bauges.imag.fr> <4B4F68E8.5050809@eaglescrag.net> <4B50F7DB.7020204@eaglescrag.net> <vpqwrzhszye.fsf@bauges.imag.fr> <alpine.DEB.1.00.1001172357420.4985@pacific.mpi-cbg.de> <4B53AEAC.6060100@eaglescrag.net> <alpine.DEB.1.00.1001181044410.4985@pacific.mpi-cbg.de> <alpine.DEB.1.00.1001181258540.3044@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jan 18 19:47:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWwdf-0002zs-Lv
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jan 2010 19:47:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755873Ab0ARSrl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jan 2010 13:47:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755871Ab0ARSrl
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jan 2010 13:47:41 -0500
Received: from shards.monkeyblade.net ([198.137.202.13]:40595 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752157Ab0ARSrk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jan 2010 13:47:40 -0500
Received: from voot-cruiser.eaglescrag.net (c-71-202-189-206.hsd1.ca.comcast.net [71.202.189.206])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.3/8.14.3) with ESMTP id o0IIlPtA023767
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
	Mon, 18 Jan 2010 10:47:26 -0800
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.95.3 at shards.monkeyblade.net
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.5) Gecko/20091209 Fedora/3.0-4.fc12 Lightning/1.0pre Thunderbird/3.0
In-Reply-To: <alpine.DEB.1.00.1001181258540.3044@intel-tinevez-2-302>
X-Enigmail-Version: 1.0
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.3 (shards.monkeyblade.net [198.137.202.13]); Mon, 18 Jan 2010 10:47:27 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137397>

On 01/18/2010 04:03 AM, Johannes Schindelin wrote:
> Hi,
> 
> On Mon, 18 Jan 2010, Johannes Schindelin wrote:
> 
>> On Sun, 17 Jan 2010, J.H. wrote:
>>
>>> On 01/17/2010 03:06 PM, Johannes Schindelin wrote:
>>>
>>>> BTW there is a file KHTMLFixes.css in the directory skins/monobook/ 
>>>> which makes the layout break with Chromium.  Apparently, it is no 
>>>> longer needed by KHTML anyway.  So could you please replace that 
>>>> file with an empty one, or comment out the offending part, like so:
>>>>
>>>> 	/* #column-content { margin-left: 0; } */
>>>
>>> I'm not keen on making changes since that file is still coming from 
>>> the shipping version of mediawiki and I'm trying, quite a lot, to not 
>>> run a modified version of it.  I've got enough troubles with the fact 
>>> that that one change would affect 22 wikis in a single go.
>>>
>>> As bad as it is to say this, I'd rather wait for 1.16 to come out vs. 
>>> modify it in place.  Mediawiki is claiming they are in continuous 
>>> integration development with quarterly releases but their last release 
>>> was June of 2009, so take that as you will.
>>
>> Fair enough.  As long as Chromium has a fairly small share of the 
>> market, I think it is safe to tell everybody to wait a little until the 
>> side bar is no longer displayed at the left _below_ the main body text.  
>> AFAICT the problem was solved with Wikipedia, so the next release should 
>> magically fix the issue.
> 
> Actually, in a rare case of cleverness, I found out how to fix it (at 
> least for me, it works):
> 
> 	http://git.wiki.kernel.org/index.php/MediaWiki:Monobook.css
> 
> Of course, this is only a work-around, and it will get broken once 
> Monobook changes dimensions (or more).  But hopefully Chromium will be 
> fixed by then, extending the canvas into the negative arm of the x axis 
> whenever needed.  And then I will happily delete the custom Monobook.css.

That works.

> These are the things left that I would like to see soon:
> 
> - add a link from the old Wiki (with rewrite rules)

I think the rewrites should be simple enough (the pages seem to line up
1:1 easily enough) so all I would need to do is discuss this with Petr.

> - use whatever logo (anything is better than the sunflower)

It's easy enough to change just need to know which one to use.

> - enable anonymous edits

Anonymous edits will *NEVER* be enabled.  You are going to need to have
an account and your going to have to verify it's e-mail to be able to do
eits.  Completely anonymous edits are too much of a risk considering
bots and spam and the abuse they can do.

Even then there is at least one case of a spammer actually going through
and using a verified account.

> - a major cleanup of the broken autolinks and faulty formatting.
> 
> The latter point is probably the most tedious one, so I suggest that only 
> those get a vote on the logo who fix at least 3 pages.

sound fair to me.

- John 'Warthog9' Hawley
