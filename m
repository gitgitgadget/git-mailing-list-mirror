From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-status too verbose?
Date: Tue, 7 Mar 2006 10:38:47 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0603071037270.8753@wbgn013.biozentrum.uni-wuerzburg.de>
References: <38b80e980603040952j15152a21h2c903bd011d7e905@mail.gmail.com>
 <7vacc36r4v.fsf@assigned-by-dhcp.cox.net> <20060307053547.GK6346@always.joy.eth.net>
 <20060307091717.GA16645@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1148973799-293485847-1141724327=:8753"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 07 10:39:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FGYei-000193-DI
	for gcvg-git@gmane.org; Tue, 07 Mar 2006 10:39:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752130AbWCGJiw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Mar 2006 04:38:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752132AbWCGJiw
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Mar 2006 04:38:52 -0500
Received: from wrzx35.rz.uni-wuerzburg.de ([132.187.3.35]:10967 "EHLO
	mailrelay.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1752130AbWCGJiw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Mar 2006 04:38:52 -0500
Received: from virusscan.mail (mail04.mail [172.25.1.103])
	by mailrelay.mail (Postfix) with ESMTP id 9E97C11AC;
	Tue,  7 Mar 2006 10:38:48 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 91D645CAD;
	Tue,  7 Mar 2006 10:38:48 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 60C3BA9C;
	Tue,  7 Mar 2006 10:38:48 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
In-Reply-To: <20060307091717.GA16645@diana.vm.bytemark.co.uk>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17328>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1148973799-293485847-1141724327=:8753
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Tue, 7 Mar 2006, Karl Hasselström wrote:

> On 2006-03-07 11:05:47 +0530, Joshua N Pritikin wrote:
> 
> > On Mon, Mar 06, 2006 at 04:21:52PM -0800, Junio C Hamano wrote:
> >
> > >                     HEAD->index     index->files
> > >     ------------------------------------------------
> > >     hello.c         unmodified      modified
> > >     world.c         modified        unmodified
> > >     frotz.c         new             unmodified
> > >         ...
> > >     garbage.c~      ???             n/a
> >
> > For what it's worth, this chart immediately made sense to me and I
> > would prefer it to the current git-status output.
> 
> I agree. This kind of status information makes the whole index concept
> an order of magnitude less confusing. In a way, it lets you learn what
> the index is by example, rather than first having to learn what it is
> in order to be able to grok the status information.

I beg to differ. The index thing is complex enough as it is. You should 
not shy away potentially customers by such output at such often used 
place.

Ciao,
Dscho

---1148973799-293485847-1141724327=:8753--
