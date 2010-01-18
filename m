From: "J.H." <warthog19@eaglescrag.net>
Subject: Re: [RFC] Git Wiki Move
Date: Sun, 17 Jan 2010 16:43:24 -0800
Message-ID: <4B53AEAC.6060100@eaglescrag.net>
References: <20100113232908.GA3299@machine.or.cz> <20100114012449.GB3299@machine.or.cz> <4B4EF1E0.3040808@eaglescrag.net> <vpqbpgxrn32.fsf@bauges.imag.fr> <4B4F68E8.5050809@eaglescrag.net> <4B50F7DB.7020204@eaglescrag.net> <vpqwrzhszye.fsf@bauges.imag.fr> <alpine.DEB.1.00.1001172357420.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jan 18 01:43:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWfib-0002N8-8W
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jan 2010 01:43:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755154Ab0ARAni (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jan 2010 19:43:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754304Ab0ARAni
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jan 2010 19:43:38 -0500
Received: from shards.monkeyblade.net ([198.137.202.13]:43195 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754198Ab0ARAnh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jan 2010 19:43:37 -0500
Received: from voot-cruiser.eaglescrag.net (c-71-202-189-206.hsd1.ca.comcast.net [71.202.189.206])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.3/8.14.3) with ESMTP id o0I0hPpf023697
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
	Sun, 17 Jan 2010 16:43:25 -0800
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.95.3 at shards.monkeyblade.net
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.5) Gecko/20091209 Fedora/3.0-4.fc12 Lightning/1.0pre Thunderbird/3.0
In-Reply-To: <alpine.DEB.1.00.1001172357420.4985@pacific.mpi-cbg.de>
X-Enigmail-Version: 1.0
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.3 (shards.monkeyblade.net [198.137.202.13]); Sun, 17 Jan 2010 16:43:25 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137351>

On 01/17/2010 03:06 PM, Johannes Schindelin wrote:
> Hi,
> 
> On Sun, 17 Jan 2010, Matthieu Moy wrote:
> 
>> "J.H." <warthog19@eaglescrag.net> writes:
>>
>>> Quick update - I think I've got the vast majority of the obvious and
>>> simple to correct problems fixed at http://git.wiki.kernel.org anyone
>>> want to run through and see if there's anything else that would be
>>> considered a show stopper?
>>
>> The main page is locked, and there are some broken links formatting in
>> the News section: http://git.wiki.kernel.org/index.php/Main_Page#News
>> I'm user "Moy" there if you want to let me fix them.
> 
> I think I managed to edit them.

You have to have a confirmed e-mail account to be able to edit anything,
the errors on why you can't edit are fairly straight forward.

> 
>> You should set $wgLogo to some Git logo, among
>> http://git.or.cz/gitwiki/GitRelatedLogos
> 
> Best would be the standard one: http://git.or.cz/git-logo.png but I would 
> actually also like http://henrik.nyh.se/uploads/git-logo.png.

I'd leave that up to the greater community.  The second one there would
fit better on the page honestly, but I don't want to go making a logo
decision for the entirety of the project.

> 
>> You can also add a few links to the sidebar, by editting:
>> http://git.wiki.kernel.org/index.php/MediaWiki:Sidebar
>>
>> (it seems I don't have permission to do it myself).
> 
> You need to be in the Sysop list to do so.  Warthog, if you trust me :-) 
> would you mind adding me to that group?  You can do that by visiting
> 
> http://git.wiki.kernel.org/index.php/Special:Userrights
> 
> when you are a sysop.

Done.

> 
>> I suggest taking the ones of the front-page:
>>
>> * Starting points
>> ** Installation|Installation
>> ** InterfacesFrontendsAndTools|Git Tools
>> ** GitDocumentation|Git Documentation
>> ** GitCommunity|Git Community Support
>> ** GitProjects|Projects using Git
>> ** GitFaq|FAQ
>> ** GitHosting|Git Hosting
>> ** GitLinks|Git Links
>> ** GitComparison|Git Compared
> 
> Let's not forget
> 
> * navigation
> ** mainpage|mainpage-description
> ** recentchanges-url|recentchanges
> ** randompage-url|randompage
> ** helppage|help
> * SEARCH
> * TOOLBOX
> 
> BTW there is a file KHTMLFixes.css in the directory skins/monobook/ which 
> makes the layout break with Chromium.  Apparently, it is no longer needed 
> by KHTML anyway.  So could you please replace that file with an empty one, 
> or comment out the offending part, like so:
> 
> 	/* #column-content { margin-left: 0; } */

I'm not keen on making changes since that file is still coming from the
shipping version of mediawiki and I'm trying, quite a lot, to not run a
modified version of it.  I've got enough troubles with the fact that
that one change would affect 22 wikis in a single go.

As bad as it is to say this, I'd rather wait for 1.16 to come out vs.
modify it in place.  Mediawiki is claiming they are in continuous
integration development with quarterly releases but their last release
was June of 2009, so take that as you will.

- John 'Warthog9' Hawley
