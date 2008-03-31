From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: [PATCH] Add new git-graph command
Date: Mon, 31 Mar 2008 20:17:28 +0300
Message-ID: <200803312017.28354.tlikonen@iki.fi>
References: <20080330195840.GA8695@adamsimpkins.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, Adam Simpkins <adam@adamsimpkins.net>
X-From: git-owner@vger.kernel.org Mon Mar 31 19:18:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JgNeA-0008Tn-5V
	for gcvg-git-2@gmane.org; Mon, 31 Mar 2008 19:18:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752674AbYCaRRb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2008 13:17:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751941AbYCaRRb
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Mar 2008 13:17:31 -0400
Received: from pne-smtpout3-sn2.hy.skanova.net ([81.228.8.111]:56109 "EHLO
	pne-smtpout3-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751258AbYCaRRa (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Mar 2008 13:17:30 -0400
Received: from [192.168.0.2] (80.220.180.181) by pne-smtpout3-sn2.hy.skanova.net (7.3.129)
        id 478BDB9600430B6E; Mon, 31 Mar 2008 19:17:29 +0200
User-Agent: KMail/1.9.5
In-Reply-To: <20080330195840.GA8695@adamsimpkins.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78593>

Adam Simpkins kirjoitti:

> I added this since I really like gitk, but don't always have easy
> access to an X display on some of the systems I use.  I tried using
> tig, but I found its graph output very hard to read.  The graph
> produced by git-graph is less compact, but much more readable.
>
> Ultimately, it would probably be better to integrate this
> functionality into git-log, instead of having it as a standalone
> command.  For example, a new --graph option could be added to cause
> the graph to be displayed alongside the existing git log output.
> However, this would require tighter integration between the graphing
> code and the log_tree.c and pretty.c code, which I'm not all that
> familiar with.

I just want to say that I really like your 'git graph'. I would like to 
see it integrated to 'git log', perhaps as 'git log --pretty=graph' 
or 'git log --graph'.
