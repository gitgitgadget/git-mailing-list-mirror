From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-fast-import
Date: Thu, 8 Feb 2007 00:55:06 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702080054180.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20070206023111.GB9222@spearce.org> <45C81C33.6010704@gmail.com>
 <20070206061817.GB10508@spearce.org> <Pine.LNX.4.64.0702062347060.20138@iabervon.org>
 <20070207091351.GA1632@diana.vm.bytemark.co.uk>
 <Pine.LNX.4.63.0702071216330.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070207225532.GA1970@spearce.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1148973799-1341508771-1170892506=:22628"
Cc: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Feb 08 00:55:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEwdA-0006Uc-A7
	for gcvg-git@gmane.org; Thu, 08 Feb 2007 00:55:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422776AbXBGXzM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Feb 2007 18:55:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422821AbXBGXzL
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 18:55:11 -0500
Received: from mail.gmx.net ([213.165.64.20]:59076 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1422776AbXBGXzJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 18:55:09 -0500
Received: (qmail invoked by alias); 07 Feb 2007 23:55:08 -0000
X-Provags-ID: V01U2FsdGVkX18U4NNKa3EU3JKUdjHOFULwjYttEpdE9h+/VmtHQC
	y98g==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20070207225532.GA1970@spearce.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39007>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1148973799-1341508771-1170892506=:22628
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Wed, 7 Feb 2007, Shawn O. Pearce wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > On Wed, 7 Feb 2007, Karl Hasselström wrote:
> > > In other words, general history rewriting, but fast.
> > 
> > For this, it would be better to use a different approach: fast-import 
> > still hashes all the objects, which would not be necessary when rewriting. 
> > I guess that is what cogito's tool is doing.
> 
> gfi doesn't require that it rehash blob objects.
> 
> If the blobs in question are already available in the repository
> gfi is running against (say, from the old branch history) you
> can just feed those blob SHA-1s at gfi in its 'M' commands when
> making commits.

Ah! I overlooked that feature. Certainly, this makes gfi (could we please 
call it "fast-import", please?) very useful for history rewriting 
purposed.

Ciao,
Dscho
---1148973799-1341508771-1170892506=:22628--
