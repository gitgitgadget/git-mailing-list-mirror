From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: RE: FW: git via http protocol _and_ a proxy using NTLM authentication
 -- git 1.5.4.2 & curl 7.18.0
Date: Thu, 28 Feb 2008 00:10:17 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802280007390.22527@racer.site>
References: <AA28F077645B324881335614E4F7C428034C0A@win-ex01.bench.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: mh@glandium.org, git@vger.kernel.org
To: Ken.Fuchs@bench.com
X-From: git-owner@vger.kernel.org Thu Feb 28 01:11:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUWNK-00061x-Kb
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 01:11:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758957AbYB1AK7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2008 19:10:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758849AbYB1AK6
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 19:10:58 -0500
Received: from mail.gmx.net ([213.165.64.20]:38484 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757731AbYB1AK5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 19:10:57 -0500
Received: (qmail invoked by alias); 28 Feb 2008 00:10:50 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp020) with SMTP; 28 Feb 2008 01:10:50 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/4CzA98bL42y9VQDKuAWFkJfP/1hW1kMfe7Wa5Q4
	Nbq2QXlg+Z8IC8
X-X-Sender: gene099@racer.site
In-Reply-To: <AA28F077645B324881335614E4F7C428034C0A@win-ex01.bench.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75328>

Hi,

On Wed, 27 Feb 2008, Ken.Fuchs@bench.com wrote:

[Ken did not say who said this:]

> > git-clone is not a builtin yet. When it is (and a patch has come for
> > that), it will correctly use proxys.
> 
> Is there a work-around for cloning a git repository via a proxy?

Yes.

Just export "http_proxy".  AFAICT this works... See

http://repo.or.cz/w/msysgit.git?a=commitdiff;h=257a62710c0253d940a59b6fb2f371afa84dcf56

for a working example.

Hth,
Dscho
