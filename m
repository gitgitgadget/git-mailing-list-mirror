From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: msgmft segfaulting on tiger
Date: Wed, 27 Feb 2008 18:26:24 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802271825330.22527@racer.site>
References: <46a038f90802211553g735215c6q260ddc49ac149bb5@mail.gmail.com>  <46a038f90802211559w457c5460k7447ba8b38352713@mail.gmail.com>  <20080222065836.GE8410@spearce.org> <46a038f90802220957y7db67d8nb6b7ad784124546a@mail.gmail.com>
 <47C5A974.7080207@gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811741-1896327237-1204136786=:22527"
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-15?Q?Gabriel_Salda=F1a?= <gsaldana@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 27 19:27:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUR0C-0005uz-My
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 19:27:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753576AbYB0S06 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2008 13:26:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753487AbYB0S05
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 13:26:57 -0500
Received: from mail.gmx.net ([213.165.64.20]:53114 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751301AbYB0S05 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 13:26:57 -0500
Received: (qmail invoked by alias); 27 Feb 2008 18:26:54 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp052) with SMTP; 27 Feb 2008 19:26:54 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19hrJJnpSRhRIJZ71vCHMMUjK4Byr5+39RZ4LKMLV
	9frxCkuNTRg01A
X-X-Sender: gene099@racer.site
In-Reply-To: <47C5A974.7080207@gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75243>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811741-1896327237-1204136786=:22527
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Wed, 27 Feb 2008, Gabriel Saldaña wrote:

> msgfmt --statistics --tcl -l de -d po/ po/de.po msgfmt: unrecognized option
> `--tcl'

Could you try this, please:

$ msgfmt --tcl; echo $?

Maybe we can have a clever autodetection of msgfmt which does not 
understand --tcl?

Ciao,
Dscho

---1463811741-1896327237-1204136786=:22527--
