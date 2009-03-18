From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Google Summer of Code 2009: GIT
Date: Thu, 19 Mar 2009 00:16:21 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903190003100.10279@pacific.mpi-cbg.de>
References: <49B74373.3090609@gmail.com>  <7veix33f5e.fsf@gitster.siamese.dyndns.org>  <ab9fa62a0903120545o7e5bc359g7df233b00858869c@mail.gmail.com>  <alpine.DEB.1.10.0903121052310.16753@asgard.lang.hm>  <ab9fa62a0903121119j6c2a1d43kd9cda99db47b5e7c@mail.gmail.com>
  <alpine.DEB.1.10.0903121148540.16753@asgard.lang.hm>  <ab9fa62a0903121200v73ec3522gcdebcd34122efc72@mail.gmail.com>  <alpine.DEB.1.10.0903121214390.16753@asgard.lang.hm>  <ab9fa62a0903121245m621643bfq3c58557ccc9b266f@mail.gmail.com> 
 <alpine.DEB.1.10.0903121255040.16753@asgard.lang.hm> <ab9fa62a0903121303v5a6cbf0ax413cc440b9c32e77@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: david@lang.hm, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: saurabh gupta <saurabhgupta1403@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 19 00:16:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lk4zX-0001AX-Vm
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 00:16:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752817AbZCRXOb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2009 19:14:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751644AbZCRXOa
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Mar 2009 19:14:30 -0400
Received: from mail.gmx.net ([213.165.64.20]:58262 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751196AbZCRXO3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2009 19:14:29 -0400
Received: (qmail invoked by alias); 18 Mar 2009 23:14:26 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp015) with SMTP; 19 Mar 2009 00:14:26 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18aP41e2RkajwgzNAzQ9RjgdabJXMD1AkRYl5Xhrx
	lYkR4UCuX/Yo7V
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <ab9fa62a0903121303v5a6cbf0ax413cc440b9c32e77@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113701>

Hi,

On Fri, 13 Mar 2009, saurabh gupta wrote:

> On Fri, Mar 13, 2009 at 1:29 AM,  <david@lang.hm> wrote:
> > On Fri, 13 Mar 2009, saurabh gupta wrote:
> >
> >> Very well described, David. I agree with you and providing these 
> >> merge options to the user, merge drivers can do the work and mark the 
> >> conflicts according to the option. The work to do is to modify the 
> >> merge driver. I think in this way, even people who have only a 
> >> terminal can also gain from it. They can choose the apt option to see 
> >> the conflict markers in their way. So, the aim is to make merge 
> >> driver configurable and create the merged/conflicted file according 
> >> to the options.
> >
> > for the GSOC I suspect that the right thing to do is the define one or 
> > more merge drivers to create, and list what applications are going to 
> > be used for testing these merges.
> >
> > you and the mentor can decide what is a reasonable amount of work.
> 
> I will very glad to hear about this thing from the mentor (Johannes 
> Schindelin, according to wiki). I will try to plan out the things in a 
> proper way to carry out this project if I get a chance to work on this 
> for GSoC 2009.

Well, now that we have been accepted as an organization, we can move 
forward with this idea!

My main concern is that we define early on what should be the user 
interface, preferably with a quick sketch.

The technical details, we can hash them out later, I have no doubt that 
with the help of the complete Git community, we can overcome almost every 
problem handling XML data or some such.

> > it may be just doing an XML merge driver is a summer's worth of work, 
> > or it may be that it's not really enough and you should try to do 
> > another one or two.
> >
> > it also may be that there is a lot of overlap between different merge 
> > drivers, and once you have the XML driver the others become fairly 
> > trivial to do. (I'm thinking the config file examples I posted earlier 
> > in the thread)
> 
> with the options given to the user, one can handle the config files
> also where order doesn't matter and also the whitespaces problem can
> also be handled in the similar way.

In my humble opinion, we should focus on the data types we want to be 
able to support at the end of the summer first.

For example, if we decide that OOXML is a must (as it is a proper 
standard, and many people will benefit from it), we will most likely end 
up in having to write a merge _driver_ (to handle those .zip files), _and_ 
a merge _helper_, although we can avoid writing our own GUI, as we can 
create an OOXML that has its own version of conflict markers.

If we decide that SVG is something we want to support by the end of the 
summer, then we can probably avoid writing a merge _driver_, as plain text 
is handled reasonably well in Git.  OTOH it could turn out that there are 
_real_ conflicts in overlapping tag ids, and it would still be easier to 
write a merge driver, too.

IOW the details are not as important as

- knowing what data types we want to support _at the least_, and what data 
  types we keep for the free skate,

- a clear picture of the user interface we want to be able to provide,

- a timeline (weekly milestones should be fine, I guess) what should be 
  achieved when, and

- being flexible in how to support that (IOW if a merge driver appears 
  unnecessary first, but necessary later, we should be able to fit that 
  into both the design and the timeline).

How does that sound?

Ciao,
Dscho
