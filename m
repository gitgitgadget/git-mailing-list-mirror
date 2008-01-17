From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Thu, 17 Jan 2008 13:05:05 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801171302410.17650@racer.site>
References: <478E1FED.5010801@web.de> <76718490801162043w3884435ex435f38b9de837540@mail.gmail.com> <76718490801162059i2472cd82va34010caa3130b7e@mail.gmail.com> <7vejchkp6o.fsf@gitster.siamese.dyndns.org> <32DB7E53-1062-4F7C-A42D-6EC5945A70A3@wincent.com>
 <alpine.LSU.1.00.0801171106510.17650@racer.site> <C7439732-3B79-4F2B-9D0C-679C1EC8EA0E@simplicidade.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811741-1251257496-1200575106=:17650"
Cc: Wincent Colaiuta <win@wincent.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jay Soffian <jaysoffian+git@gmail.com>, git@vger.kernel.org
To: Pedro Melo <melo@simplicidade.org>
X-From: git-owner@vger.kernel.org Thu Jan 17 14:06:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFURI-0008R2-19
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 14:05:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751178AbYAQNFS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2008 08:05:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751012AbYAQNFS
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jan 2008 08:05:18 -0500
Received: from mail.gmx.net ([213.165.64.20]:55063 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750955AbYAQNFP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2008 08:05:15 -0500
Received: (qmail invoked by alias); 17 Jan 2008 13:05:08 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp026) with SMTP; 17 Jan 2008 14:05:08 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19mQiMUM29myt0ANFd2gXBY4G1j/ooLwx9dX5H/o+
	2ri7oviuEZD9C0
X-X-Sender: gene099@racer.site
In-Reply-To: <C7439732-3B79-4F2B-9D0C-679C1EC8EA0E@simplicidade.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70856>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811741-1251257496-1200575106=:17650
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Thu, 17 Jan 2008, Pedro Melo wrote:

> On Jan 17, 2008, at 11:10 AM, Johannes Schindelin wrote:
> > [Jay, don't cull Cc: lists on vger.kernel.org.  I consider it rude.]
> > 
> > On Thu, 17 Jan 2008, Wincent Colaiuta wrote:
> > 
> > > El 17/1/2008, a las 6:15, Junio C Hamano escribió:
> > > 
> > > > "Jay Soffian" <jaysoffian+git@gmail.com> writes:
> > > > 
> > > > > So here's what I can see as being useful additions to git:
> > > > > ...
> > > > > Thoughts (besides "patches welcomed")?
> > > > 
> > > > I think we already discussed a plan to store normalization mapping 
> > > > in the index extension section and use it to avoid getting 
> > > > confused by readdir(3) that lies to us.  Is there any more thing 
> > > > that need to be discussed?
> > 
> > Yes, and I think that a lot of time would have more wisely spent on 
> > reading that, and trying to implement it, than writing a number of 
> > long mails, repeating the _same_ (refuted) points over and over again.
> 
> I searched the archives for the posts about normalization and I could 
> not find them, sorry.

Here's my pointer:

http://thread.gmane.org/gmane.comp.gnu.make.devel/387/focus=61073

FWIW I searched by the term "readdir", and then browsed the thread to find 
a more interesting post than the first hit.

> Is stringprep (RFC 3454) being proposed as an optional normalization 
> step before lookups in the index?

I don't know.  I'd probably prefer something using iconv (which we use 
already if it's available), so that the same system can be used for 
case-insensitivity, UTF-8 normalisation, but also other transformations 
you might wish to perform.

Ciao,
Dscho

---1463811741-1251257496-1200575106=:17650--
