From: Jan Hudec <bulb@ucw.cz>
Subject: Re: [ANNOUNCE] Example Cogito Addon - cogito-bundle
Date: Sat, 21 Oct 2006 21:20:38 +0200
Message-ID: <20061021192038.GD29927@artax.karlin.mff.cuni.cz>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	<20061020225917.GA30584@coredump.intra.peff.net>
	<20061021174056.GA29927@artax.karlin.mff.cuni.cz>
	<200610211951.43495.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org
X-From: bazaar-ng-bounces@lists.canonical.com Sat Oct 21 21:20:40 2006
Return-path: <bazaar-ng-bounces@lists.canonical.com>
Envelope-to: gcvbg-bazaar-ng@m.gmane.org
Received: from esperanza.ubuntu.com ([82.211.81.173])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbMOc-0003Uf-DG
	for gcvbg-bazaar-ng@m.gmane.org; Sat, 21 Oct 2006 21:20:38 +0200
Received: from localhost ([127.0.0.1] helo=esperanza.ubuntu.com)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <bazaar-ng-bounces@lists.canonical.com>)
	id 1GbMOb-0002ll-In; Sat, 21 Oct 2006 20:20:37 +0100
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125])
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <jhud7196@artax.karlin.mff.cuni.cz>)
	id 1GbMOW-0002kY-9E
	for bazaar-ng@lists.canonical.com; Sat, 21 Oct 2006 20:20:32 +0100
Received: by artax.karlin.mff.cuni.cz (Postfix, from userid 17196)
	id AC9274A86; Sat, 21 Oct 2006 21:20:38 +0200 (CEST)
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <200610211951.43495.jnareb@gmail.com>
User-Agent: Mutt/1.5.9i
X-BeenThere: bazaar-ng@lists.canonical.com
X-Mailman-Version: 2.1.8
Precedence: list
List-Id: bazaar-ng discussion <bazaar-ng.lists.canonical.com>
List-Unsubscribe: <https://lists.ubuntu.com/mailman/listinfo/bazaar-ng>,
	<mailto:bazaar-ng-request@lists.canonical.com?subject=unsubscribe>
List-Archive: <https://lists.ubuntu.com/archives/bazaar-ng>
List-Post: <mailto:bazaar-ng@lists.canonical.com>
List-Help: <mailto:bazaar-ng-request@lists.canonical.com?subject=help>
List-Subscribe: <https://lists.ubuntu.com/mailman/listinfo/bazaar-ng>,
	<mailto:bazaar-ng-request@lists.canonical.com?subject=subscribe>
Sender: bazaar-ng-bounces@lists.canonical.com
Errors-To: bazaar-ng-bounces@lists.canonical.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29662>

On Sat, Oct 21, 2006 at 07:51:43PM +0200, Jakub Narebski wrote:
> Jan Hudec wrote:
> 
> > Besides I start to think that it should be actually possible to solve
> > this case with the git-style approach. I have to state beforehand, that
> > I don't know how the most recent git algorithm works, but I imagine
> > there is some kind of 'brackets' saying the text is in a given file. Now
> > if those 'brackets' were not flat, but nested, ie. instead of saying
> > 'this is in foo/bar' it would say 'this is in bar is in foo', the
> > difference when renaming directory would only affect the 'outer bracket'
> > and therefore merge correctly with adding content inside it.
> 
> You mean, to consider "contents" of a directory union of contents
> of files and directories it contains, and then use the same "rename
> detection" algorithm as for files?

Yes, something like that.

--------------------------------------------------------------------------------
                  				- Jan Hudec `Bulb' <bulb@ucw.cz>
