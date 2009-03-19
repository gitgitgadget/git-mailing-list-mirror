From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Google Summer of Code 2009: GIT
Date: Fri, 20 Mar 2009 00:42:40 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903200034230.10279@pacific.mpi-cbg.de>
References: <49B74373.3090609@gmail.com>  <alpine.DEB.1.10.0903121052310.16753@asgard.lang.hm>  <ab9fa62a0903121119j6c2a1d43kd9cda99db47b5e7c@mail.gmail.com>  <alpine.DEB.1.10.0903121148540.16753@asgard.lang.hm>  <ab9fa62a0903121200v73ec3522gcdebcd34122efc72@mail.gmail.com>
  <alpine.DEB.1.10.0903121214390.16753@asgard.lang.hm>  <ab9fa62a0903121245m621643bfq3c58557ccc9b266f@mail.gmail.com>  <alpine.DEB.1.10.0903121255040.16753@asgard.lang.hm>  <ab9fa62a0903121303v5a6cbf0ax413cc440b9c32e77@mail.gmail.com> 
 <alpine.DEB.1.00.0903190003100.10279@pacific.mpi-cbg.de> <ab9fa62a0903191217t5d0e6d9cn4915a425ed8084ff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-52542757-1237506161=:10279"
Cc: david@lang.hm, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: saurabh gupta <saurabhgupta1403@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 20 00:42:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkRsP-0001mk-4a
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 00:42:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758595AbZCSXks (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 19:40:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755841AbZCSXkr
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 19:40:47 -0400
Received: from mail.gmx.net ([213.165.64.20]:51360 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755358AbZCSXkq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 19:40:46 -0400
Received: (qmail invoked by alias); 19 Mar 2009 23:40:43 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp012) with SMTP; 20 Mar 2009 00:40:43 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/yJWZOVjDy2Z74MbfditOTcETBhlnbDNwz8auykX
	wu3+VtgoaO7iAR
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <ab9fa62a0903191217t5d0e6d9cn4915a425ed8084ff@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.58
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113863>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-52542757-1237506161=:10279
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Fri, 20 Mar 2009, saurabh gupta wrote:

> On Thu, Mar 19, 2009 at 4:46 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>
> > For example, if we decide that OOXML is a must (as it is a proper 
> > standard, and many people will benefit from it), we will most likely 
> > end up in having to write a merge _driver_ (to handle those .zip 
> > files), _and_ a merge _helper_, although we can avoid writing our own 
> > GUI, as we can create an OOXML that has its own version of conflict 
> > markers.
> 
> Well, for ODF type document, we can write a merge driver which will 
> change the xml file in an appropriate way that OO can understand it and 
> the user can see the merge result/conflict in a comfortable way. As 
> described by Junio, in this case, a dedicated merge helper is not needed 
> as OO can parse the markers made by merge-driver and provide the user to 
> resolve the conflict and register the changes to index.

There is also the idea that OOffice has building blocks in place to help 
resolving merge conflicts.  For a successful application, you will have to 
show that you researched that option, and describe how well/badly it fits 
with the goal of the project.

> > - knowing what data types we want to support _at the least_, and what 
> >   data  types we keep for the free skate,
> 
> As of now, how about going for XML files. For this summer, we can go for 
> XML files and latex files can be handled later.

If your goal is just XML files (without any more specific goal, like ODF 
or SVG), I am afraid that I think that project is not worth 4500 dollar 
from Google's pocket.  I mean, we are not talking peanuts here.

> > - a clear picture of the user interface we want to be able to provide,
> 
> In my opinion, we have following things to do:
> 
> => while merging an ODF document, merge-driver will merge the file at
> file level. If changes don't overlap, then it returns the result with
> a success. For example, if the file is changed only on one side, then
> the driver will simply add the new content.
> 
> => If conflicts appear, then the merge driver will put the markers in
> an appropriate manner which the end-user application (e.g. open
> office) can understand and show the user. For example, the XML file of
> that ODF document will be modified and OO can show it  to user in its
> way. We will have to study about the OO style of version marking.
> Another method is to implement the marker style in our own way. For
> example, to show any marker, the XML file is modified so that user can
> see markers like ">>>> " or "====" in openoffice....In this case, we
> will have to just change the xml content in this way.

That is correct, but I would appreciate a bit more definitive research 
_before_ the project proposal, as a sign that you are capable of working 
out the details of the project.

> > - a timeline (weekly milestones should be fine, I guess) what should 
> >   be  achieved when, and
> 
> Timeline can be decided once we reach some conclusion and the work which 
> needs to be done become clear to us.

Last year, most successful applications detailed a proposed timeline in 
their proposal...

Do not get me wrong, I want this project to succeed.

But on the other hand, I feel the obligation to be a bit demanding for the 
gracious donation of Google: we _do_ want to have something stunningly 
awesome at the end of the summer.

And that means that I have to get the impression from the student proposal 
that something like that is at least _possible_.

Ciao,
Dscho

--8323328-52542757-1237506161=:10279--
