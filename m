From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git submodule merge madness
Date: Thu, 15 Jan 2009 01:36:24 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901150134530.3586@pacific.mpi-cbg.de>
References: <ADC7A3B1-6756-4258-93CD-DB40C7D2793C@develooper.com> <alpine.DEB.1.00.0901142354120.3586@pacific.mpi-cbg.de> <AE1922C4-0543-424B-A635-494445E17E45@develooper.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-2053501765-1231979784=:3586"
Cc: git@vger.kernel.org
To: =?ISO-8859-15?Q?Ask_Bj=F8rn_Hansen?= <ask@develooper.com>
X-From: git-owner@vger.kernel.org Thu Jan 15 01:37:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNGEC-0005Zk-Ua
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 01:36:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760215AbZAOAfe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 19:35:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757054AbZAOAfd
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 19:35:33 -0500
Received: from mail.gmx.net ([213.165.64.20]:49896 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756784AbZAOAfd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 19:35:33 -0500
Received: (qmail invoked by alias); 15 Jan 2009 00:35:31 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp024) with SMTP; 15 Jan 2009 01:35:31 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+6dpZrDgW6FoC3eIka+duSUzViGgR+UkpPt2IWJy
	5qRA3VXPEG8e/5
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <AE1922C4-0543-424B-A635-494445E17E45@develooper.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.54
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105742>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2053501765-1231979784=:3586
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

Hi,

On Wed, 14 Jan 2009, Ask Bjørn Hansen wrote:

> On Jan 14, 2009, at 2:55 PM, Johannes Schindelin wrote:
> 
> > >We've (again) replaced a few directories with submodules.  Man, it's 
> > >madness!
> > >
> > >The typical problem is that we get an error trying to merge a 
> > >"pre-submodule" branch into master:
> > >
> > >	fatal: cannot read object 894c77319a18c4d48119c2985a9275c9f5883584
> > >'some/sub/dir': It is a submodule!
> > >Mark Levedahl wrote an example in July, but I don't think he got any
> > >replies:
> > >http://marc.info/?l=git&m=121587851313303
> >
> >So.... Which Git version are you are using?  Did you test any Git version
> >containing the commit d5a84fb(merge-recursive: fail gracefully with
> >directory/submodule conflicts)?
> 
> IIRC I tried 1.6.1 and master as of about a week ago.
> 
> I don't see d5a84fb in my repository (and google doesn't find it referenced
> anywhere when I search for "directory/submodule conflicts".

Well.  Can do arithmetics in my head after midnight, but not think 
straight...

In any case, could you please provide a patch to the testsuite 
demonstrating the problem?  History shows that such patches are very 
helpful.

Ciao,
Dscho

--8323328-2053501765-1231979784=:3586--
