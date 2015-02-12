From: "Jason Pyeron" <jpyeron@pdinc.us>
Subject: RE: Windows Bluescreen
Date: Thu, 12 Feb 2015 07:53:44 -0500
Organization: PD Inc
Message-ID: <6CEE72C927ED42B4A834612538B22F5D@black>
References: <20150209201218.Horde.w9pQrdbL-Mf8IdgtaJtVuQ9@server.aercontechnologies.net><CAFOYHZADerTE88KudrH7LTi3yX4Sg1vJe3Xj0vJH+DNeO6NOEw@mail.gmail.com><CAEuupitA4PHBByLLcqc5pVbn1C+ZyQ6Vzbk-LsOjseOEHhkENw@mail.gmail.com><CAFOYHZAMv5BEmDXGSoo53iSwCYLdhOcM7dHwCMidZBaJh0xmUQ@mail.gmail.com> <CAEuupiuv=gRnnZm1C75dx35nC=sXR1Hb_PzLXzAKHwaD7kYsXA@mail.gmail.com>
Reply-To: "Erik Friesen" <erik@aercon.net>,
	  "Chris Packham" <judge.packham@gmail.com>,
	  "GIT" <git@vger.kernel.org>, <msysgit@googlegroups.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "'GIT'" <git@vger.kernel.org>, <msysgit@googlegroups.com>
To: "'Erik Friesen'" <erik@aercon.net>,
	"'Chris Packham'" <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 12 13:53:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YLtHG-0002ow-3S
	for gcvg-git-2@plane.gmane.org; Thu, 12 Feb 2015 13:53:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755478AbbBLMxu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2015 07:53:50 -0500
Received: from mail.pdinc.us ([67.90.184.27]:39905 "EHLO mail.pdinc.us"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755381AbbBLMxt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Feb 2015 07:53:49 -0500
Received: from black (nsa1.pdinc.us [67.90.184.2])
	(authenticated bits=0)
	by mail.pdinc.us (8.14.4/8.12.11) with ESMTP id t1CCrjux030209;
	Thu, 12 Feb 2015 07:53:45 -0500
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <CAEuupiuv=gRnnZm1C75dx35nC=sXR1Hb_PzLXzAKHwaD7kYsXA@mail.gmail.com>
Thread-Index: AdBGvnXtB7YHg82tRLCPm7QYBVV87QABAaDg
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.4913
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263737>

> -----Original Message-----
> From: Erik Friesen
> Sent: Thursday, February 12, 2015 7:22
> 
> I'd say this is related.  http://sourceforge.net/p/mingw/bugs/2240/
> 
> There isn't much hope, that was filed months ago with no action.  I
> suggest moving to another ssh library perhaps?  Anyways, this is a
> windows git bug report, so it really needs to stay with mysgit in my
> opinion.

FWIW, if it does not get fixed you can use the cygwin git and openssh without many problems, and the cygwin group is pretty responsive to issues like this.

> 
> I'd say it should reproduce without much effort.  Do a git push using
> win7 64 pro or similar, I'd say it will have issues.
> 
> At minimum, this should be on the list for others to view.  I have run
> across problems from others, but I don't think they realized it could
> be an ssh problem.
> 
> On Thu, Feb 12, 2015 at 4:33 AM, Chris Packham 
> <judge.packham@gmail.com> wrote:
> > On Thu, Feb 12, 2015 at 1:33 AM, Erik Friesen 
> <erik@aercon.net> wrote:
> >> Pushing over http and https are unaffected..  My linux nas 
> died, so on
> >> rebuild I tried to do the ssh thing, and realized quite soon that
> >> things weren't right.
> >>
> >> As far as other uses of ssh, I don't know, I use putty 
> frequently, but
> >> I am not clear if it is using the same libraries or not.
> >
> > I think putty ships it's own ssh implementation rather than using an
> > openSSH port.
> >
> >> I hunted around for the bugreport email on mysgit but 
> couldn't seem to
> >> find it.  It seems in the foggy recesses I remember 
> reading about an
> >> ssh issue with windows, but can't find it now.
> >>
> >
> > https://github.com/msysgit/git/issues
> >
> > Happy hunting :). Actually if it is a ssh problem it might be a
> > generic MSYS issue. So there's another bug tracker to look through
> >
> > http://sourceforge.net/p/mingw/bugs/
> >
> >

--
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
-                                                               -
- Jason Pyeron                      PD Inc. http://www.pdinc.us -
- Principal Consultant              10 West 24th Street #100    -
- +1 (443) 269-1555 x333            Baltimore, Maryland 21218   -
-                                                               -
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
This message is copyright PD Inc, subject to license 20080407P00.
