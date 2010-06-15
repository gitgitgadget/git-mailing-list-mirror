From: "Tor Arntsen" <tor@spacetec.no>
Subject: Re: [PATCH/RFC] Fix for default pager
Date: Tue, 15 Jun 2010 18:32:56 +0200
Message-ID: <4C17AB38.3060705@spacetec.no>
References: <4C0E5103.7030501@viscovery.net> <AANLkTilWg8hw5j20o-xGsVO-q_OeSmtKEKAO6O416qvH@mail.gmail.com> <4C0E6810.3070301@viscovery.net> <AANLkTinZSuXJEXzpvEavYNLSyqUlx8qzWlrbtIH6q6fx@mail.gmail.com> <4C0E932B.3010702@viscovery.net> <AANLkTinB_SBilMOfgnHtDrQS-NBOLF4yY5NaP7ZvN9rK@mail.gmail.com> <4C0EB741.9020905@op5.se> <AANLkTinAO5empFix9W_rbtU3Vv4O73OsJBtA1stb66DS@mail.gmail.com> <20100610082916.GA5559@coredump.intra.peff.net> <AANLkTinLt3p0q-q5oDFk5CWzdhqQ2lwkWuvpdPzKZvYe@mail.gmail.com> <20100610085952.GA8269@coredump.intra.peff.net> <gJV0lM_e77LzoiHR7moWdAApSZ7yI38lZ-w8kZwc97unWqtBc94nfg@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Brandon Casey <drafnel@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Andreas Ericsson <ae@op5.se>,
	Dario Rodriguez <soft.d4rio@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Ben Walton <bwalton@artsci.utoronto.ca>,
	git <git@vger.kernel.org>, gary@thewrittenword.com
To: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Tue Jun 15 18:33:18 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOZ4e-0008Qs-Hd
	for gcvg-git-2@lo.gmane.org; Tue, 15 Jun 2010 18:33:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756658Ab0FOQdL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jun 2010 12:33:11 -0400
Received: from puck.spacetec.no ([192.51.5.29]:49863 "HELO puck.spacetec.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752410Ab0FOQdK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jun 2010 12:33:10 -0400
Received: (qmail 5601 invoked from network); 15 Jun 2010 16:33:08 -0000
Received: from citadel.spacetec.no (10.10.2.22)
  by puck.spacetec.no with SMTP; 15 Jun 2010 16:33:08 -0000
Received: from [10.10.1.233] (ringworld4.spacetec.no [10.10.1.233])
	by citadel.spacetec.no; Tue, 15 Jun 2010 18:32:57 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100515 Iceowl/1.0b1 Icedove/3.0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149201>

On 06/15/10 18:11, Brandon Casey wrote:

> Yes, I currently set DEFAULT_PAGER to 'more' in my config.mak file
> on both of these platforms.  The 'more' on IRIX is decent (it can go
> backwards), but the 'more' on Solaris sucks.  I've seen 'less' on some
> newer versions of Solaris.  Is it a standard component yet?

'less' appears to be standard on Solaris 10 (5.10). My older 5.8 box
is offline so I can't check that one. AFAIK the difference between
Solaris 8 and Solaris 10 is pretty big so I suspect there's no 'less' 
there but I can't say for certain. I could try to fire up that old 
box and check though.

-Tor
