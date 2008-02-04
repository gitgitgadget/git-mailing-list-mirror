From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: rebase -i and --whitespace, was Re: [PATCH] git-rebase.sh: Update
 USAGE string (No. 1)
Date: Mon, 4 Feb 2008 15:06:52 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802041505230.7372@racer.site>
References: <m3lk6161jo.fsf@localhost.localdomain>    <prvd3i9e.fsf@blue.sea.net>    <ir15399p.fsf@blue.sea.net> <200802041113.m14BDLMl004301@mi1.bluebottle.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811741-686537155-1202137614=:7372"
Cc: Jakub Narebski <jnareb@gmail.com>,
	Jari Aalto <jari.aalto@cante.net>, git@vger.kernel.org
To: =?ISO-2022-JP?Q?=1B$B$7$i$$$7$J$J$3=1B=28J?= 
	<nanako3@bluebottle.com>
X-From: git-owner@vger.kernel.org Mon Feb 04 16:08:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JM2vW-0002F0-6S
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 16:08:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750999AbYBDPHb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 10:07:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751039AbYBDPHb
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 10:07:31 -0500
Received: from mail.gmx.net ([213.165.64.20]:59254 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750996AbYBDPHa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 10:07:30 -0500
Received: (qmail invoked by alias); 04 Feb 2008 15:07:28 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp014) with SMTP; 04 Feb 2008 16:07:28 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+gtHQizzugrPGdQjkfdIWS1wJWirrWAfqQ6fWJTk
	K4FRzxSJtPXjS+
X-X-Sender: gene099@racer.site
In-Reply-To: <200802041113.m14BDLMl004301@mi1.bluebottle.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72514>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811741-686537155-1202137614=:7372
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

On Mon, 4 Feb 2008, しらいしななこ wrote:

> I tried to run "git rebase --interactive --whitespace=strip" but it does 
> not seem to strip blank characters at the end of my lines.  Did I find a 
> bug?

Yes.  Interactive rebase never bothered with --whitespace options, since 
it works purely with cherry-pick (the --merge option to non-interactive 
rebase).  Therefore, the operation is not patch based, and does not call 
git-apply at all (which would handle the whitespace).

Ciao,
Dscho

---1463811741-686537155-1202137614=:7372--
