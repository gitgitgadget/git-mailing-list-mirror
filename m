From: Tony Finch <dot@dotat.at>
Subject: Re: Request for detailed documentation of git pack protocol
Date: Wed, 3 Jun 2009 22:38:31 +0100
Message-ID: <alpine.LSU.2.00.0906032211350.31588@hermes-2.csi.cam.ac.uk>
References: <200905122329.15379.jnareb@gmail.com> <200906031121.38616.jnareb@gmail.com> <20090603144837.GE3355@spearce.org> <200906031851.12160.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Scott Chacon <schacon@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 03 23:38:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MByAa-0005PU-Fa
	for gcvg-git-2@gmane.org; Wed, 03 Jun 2009 23:38:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754219AbZFCVic (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2009 17:38:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754145AbZFCVic
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jun 2009 17:38:32 -0400
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:37685 "EHLO
	ppsw-0.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753607AbZFCVib (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2009 17:38:31 -0400
X-Cam-AntiVirus: no malware found
X-Cam-SpamDetails: not scanned
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from hermes-2.csi.cam.ac.uk ([131.111.8.54]:51641)
	by ppsw-0.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.150]:25)
	with esmtpa (EXTERNAL:fanf2) id 1MByAJ-0005cW-25 (Exim 4.70)
	(return-path <fanf2@hermes.cam.ac.uk>); Wed, 03 Jun 2009 22:38:31 +0100
Received: from fanf2 (helo=localhost) by hermes-2.csi.cam.ac.uk (hermes.cam.ac.uk)
	with local-esmtp id 1MByAJ-0007m9-K9 (Exim 4.67)
	(return-path <fanf2@hermes.cam.ac.uk>); Wed, 03 Jun 2009 22:38:31 +0100
X-X-Sender: fanf2@hermes-2.csi.cam.ac.uk
In-Reply-To: <200906031851.12160.jnareb@gmail.com>
User-Agent: Alpine 2.00 (LSU 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120647>

On Wed, 3 Jun 2009, Jakub Narebski wrote:
> On Wed, 3 Jun 2009, Shawn O. Pearce wrote:
> > Jakub Narebski <jnareb@gmail.com> wrote:
> >>
> >> I do wonder if existing Internet Standard (in the meaning of RFC)
> >> protocols also have such kludges and hacks...
> >
> > I'm sure they have some... oddities.  But perhaps not as bad as git.

One small example is the way DNS was extended to support extra flags and
response codes (and other features). EDNS is signalled using an OPT
pseudo-RR, which is basically the same technique as git's .have refs.

There are a couple of examples in RFC 822 / MIME headers: RFC 2047 (for
encoding character set information in subject and address headers) and RFC
2231 (the same job but for attachment filenames etc.). In practice common
software uses 2047 syntax for both purposes :-/

Mostly Internet protocols have grown generic extension frameworks fairly
early in their lives, so syntactic hacks are rare.

> I wonder if there are some BCP (Best Common Practices) RFC for designing
> protocols (and BCP documents for designing file formats). And which one
> of RFC 2360, RFC 2424,... are applicable here.

As far as I know protocol design is pretty much folklore.

> Magic number (magic sequence) identifying protocol / format plus
> version number.  But it is good that we have capabilities now
> (which is better than version number in this case, IMHO).

Yes, capabilities are a good design pattern.

Tony.
-- 
f.anthony.n.finch  <dot@dotat.at>  http://dotat.at/
GERMAN BIGHT HUMBER: SOUTHWEST 5 TO 7. MODERATE OR ROUGH. SQUALLY SHOWERS.
MODERATE OR GOOD.
