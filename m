From: Petr Baudis <pasky@suse.cz>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Thu, 28 Aug 2008 11:04:21 +0200
Message-ID: <20080828090421.GQ10360@machine.or.cz>
References: <20080826164526.GM26610@one.firstfloor.org> <48B5098E.748.A598B62@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de> <B83CC7EA-C77E-45CA-B9C5-FC81A8C0C9A5@cs.indiana.edu> <20080827195019.GA9962@sigill.intra.peff.net> <38B725C0-40C3-496C-AAD4-4EA65E3085F5@cs.indiana.edu> <48B5BC5F.4070209@kernel.org> <alpine.DEB.1.10.0808271717190.19923@gandalf.stny.rr.com> <7vd4jukphm.fsf@gitster.siamese.dyndns.org> <F86A1E37-8015-41B5-A462-F044B8D1C2B1@cs.indiana.edu> <BD6DEBB7-4D1C-43E9-B3D2-B46E42D9771D@cs.indiana.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kristian H??gsberg <krh@redhat.com>,
	Matthias Kestenholz <mk@spinlock.ch>,
	Steven Rostedt <rostedt@goodmis.org>, users@kernel.org,
	Jeff King <peff@peff.net>,
	Ulrich Windl <ulrich.windl@rz.uni-regensburg.DE>,
	Andi Kleen <andi@firstfloor.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	David Woodhouse <dwmw2@infradead.org>, git@vger.kernel.org
To: Perry Wagle <wagle@cs.indiana.edu>
X-From: git-owner@vger.kernel.org Thu Aug 28 11:06:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYdRa-0005FV-Vm
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 11:05:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751525AbYH1JE0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 05:04:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751523AbYH1JE0
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 05:04:26 -0400
Received: from w241.dkm.cz ([62.24.88.241]:44315 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751055AbYH1JEZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 05:04:25 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id EF4683939B42; Thu, 28 Aug 2008 11:04:21 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <BD6DEBB7-4D1C-43E9-B3D2-B46E42D9771D@cs.indiana.edu>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This thread is starting to seriously irritate even *me* by now, which
is quite a feat...

On Wed, Aug 27, 2008 at 05:05:33PM -0700, Perry Wagle wrote:
> Oh yeah, sorry.  I neglected to mention that my problem was having the  
> git- forms in scripts all over an internal network, and having no  
> amazingly easy way of fixing them.  I don't know who all copied them.

  Should I count for you how many times the $PATH workaround has been
mentioned already? Or the gitexecdir workaround?

> On Aug 27, 2008, at 4:53 PM, Perry Wagle wrote:
> 
> >
> > On Aug 27, 2008, at 4:27 PM, Junio C Hamano wrote:
> >
> >> Steven Rostedt <rostedt@goodmis.org> writes:
> >>
> >>> Yes, they are all a bunch of Nazi git fanatics, that Hitler  
> >>> himself would
> >>> have used the space version of git. He sent the Jews off to the
> >>> concentration camps because they insisted on using the dashes.
> >>>
> >>> There, we have a Hitler reference.
> >>>
> >>> CAN WE PLEASE LET THIS THREAD DIE!

  Intentional invocations of Godwin's Law don't count - sadly. ;-)

> > I suggested that git<DASH><TAB> used to give the same 143  
> > completions that git<SPACE><TAB> would now.  This meant that making  
> > any arguments that the number was off-putting to newbies did not  
> > apply, since you had a same number (143)  either way.  Putting stuff  
> > in libexec does not change the above observation in any fashion.
> >
> > A response to my observation was that "not everything will show up  
> > in the latter completion".  I balked at that as it distorted the  
> > truth.  If this distortion would actually take place then I have a  
> > real complaint.  Not a tangent.
> >
> > But as long as git<DASH><TAB> does the *same* thing as  
> > git<SPACE><TAB>, I really do not see why you had to go break my  
> > scripts on a *minor* revision for what amounts to no reason as all.

  What the hell are you talking about? Did you *try*? git<SPACE><TAB>
does not do the same thing as git<DASH><TAB>, and it has been clearly
stated in this thread several times. It shows only the commands that are
*interesting* for the user, just as $PATH does not include /usr/sbin and
/sbin and /usr/lib/wine because the executables in these directories
just aren't interesting for the users. If you care about all the Git
internals, go read git(1) to see the list of all the plumbing stuff.

-- 
				Petr "Pasky" Baudis
The next generation of interesting software will be done
on the Macintosh, not the IBM PC.  -- Bill Gates
