From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Re* [PATCH] "not uptodate" changed to "has local changes"
Date: Mon, 19 May 2008 15:32:14 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0805191523060.19665@iabervon.org>
References: <1209833972-12256-1-git-send-email-timcharper@gmail.com> <e2b179460805060631l506e2a6leaafc9c0acf3b05b@mail.gmail.com> <b8bf37780805151914j65ce5406xc5e6b3d29e3bfb9b@mail.gmail.com> <alpine.DEB.1.00.0805161125320.30431@racer>
 <1ED37CF1-EABD-4881-BA29-ED2CB1CE73FC@sb.org> <b8bf37780805162030m4c961505nabd72e8f5bd08404@mail.gmail.com> <alpine.DEB.1.00.0805171102480.30431@racer> <e06498070805170744l7ad213aeqb779b0c0381e1de4@mail.gmail.com> <bd6139dc0805170912w14b7894fxfebe15c14e4c44ef@mail.gmail.com>
 <7v63tcda7e.fsf_-_@gitster.siamese.dyndns.org> <D925ECD3-1EE2-48EB-B1E5-2604C10AD643@wincent.com> <7vzlqm89tj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1547844168-1329237433-1211225534=:19665"
Cc: Wincent Colaiuta <win@wincent.com>, sverre@rabbelier.nl,
	Steven Walter <stevenrwalter@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?ISO-8859-15?Q?Andr=E9_Goddard_Rosa?= <andre.goddard@gmail.com>,
	Kevin Ballard <kevin@sb.org>,
	Mike Ralphson <mike.ralphson@gmail.com>,
	Tim Harper <timcharper@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 19 21:33:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JyB6c-0003yG-En
	for gcvg-git-2@gmane.org; Mon, 19 May 2008 21:33:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757779AbYESTcT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 May 2008 15:32:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755901AbYESTcT
	(ORCPT <rfc822;git-outgoing>); Mon, 19 May 2008 15:32:19 -0400
Received: from iabervon.org ([66.92.72.58]:36988 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755263AbYESTcS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 May 2008 15:32:18 -0400
Received: (qmail 30223 invoked by uid 1000); 19 May 2008 19:32:14 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 19 May 2008 19:32:14 -0000
In-Reply-To: <7vzlqm89tj.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82441>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1547844168-1329237433-1211225534=:19665
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Mon, 19 May 2008, Junio C Hamano wrote:

> Wincent Colaiuta <win@wincent.com> writes:
> 
> > El 17/5/2008, a las 21:03, Junio C Hamano escribió:
> >> +	/* not_uptodate_file */
> >> +	"Entry '%s' not uptodate. Cannot merge.",
> >
> >
> > Minor nit, "uptodate" is not a word. Should be either "up-to-date" or
> > "up to date"; most dictionaries list both.
> 
> Why does *everybody* keep missing the whole point of this patch?

That section needs a comment stating that it's the scripting API, not just 
an arbitrary set of messages. For that matter, maybe those shouldn't be 
the default set, but an alternate set used (as a group) by plumbing 
programs; I don't think it's too likely that there will be a whole lot of 
new plumbing programs, and new porcelain programs that don't specify 
anything probably ought to get something more generic.

	-Daniel
*This .sig left intentionally blank*
--1547844168-1329237433-1211225534=:19665--
