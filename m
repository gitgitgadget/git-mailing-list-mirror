From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Any command to simplify 'git fetch origin && git reset --hard
 origin/master'?
Date: Sat, 19 Jan 2008 11:15:27 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801191114310.5731@racer.site>
References: <46dff0320801182122t1581b366yad123407aaad6326@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 19 12:16:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGBgQ-00022h-0R
	for gcvg-git-2@gmane.org; Sat, 19 Jan 2008 12:16:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753422AbYASLPj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jan 2008 06:15:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753142AbYASLPj
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jan 2008 06:15:39 -0500
Received: from mail.gmx.net ([213.165.64.20]:54176 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753334AbYASLPi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jan 2008 06:15:38 -0500
Received: (qmail invoked by alias); 19 Jan 2008 11:15:36 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp010) with SMTP; 19 Jan 2008 12:15:36 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18Pf24ylzcPt6q5u2foc4Ub8Rn/lepUN7pl47n7Gi
	yK9PSZP09xjaGg
X-X-Sender: gene099@racer.site
In-Reply-To: <46dff0320801182122t1581b366yad123407aaad6326@mail.gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71099>

Hi,

On Sat, 19 Jan 2008, Ping Yin wrote:

> I often encounter the case that the origin reposotory is rebased and i
> make sure i want to use the origin head as my master
> Now I have to do
> $ git fetch origin && git reset --hard origin/master

Just make an alias if you're too lazy to type.

Personally, I do not see much sense in it, and it is too dangerous to 
bless it with an option to fetch or pull.

Ciao,
Dscho
