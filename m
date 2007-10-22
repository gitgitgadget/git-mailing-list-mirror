From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: best git practices, was Re: Git User's Survey 2007 unfinished
 summary continued
Date: Mon, 22 Oct 2007 14:38:38 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710221428390.25221@racer.site>
References: <8fe92b430710081355i7d3dbaa2q9a8939b55d7ca7dc@mail.gmail.com> 
 <Pine.LNX.4.64.0710130130380.25221@racer.site>  <1192827476.4522.93.camel@cacharro.xalalinux.org>
 <4719B655.90204@op5.se> <DE4FB702-24E8-421F-8447-04A5C7F7B5D2@zib.de>
 <8fe92b430710201606i47e85b24k17abd819bf0d353b@mail.gmail.com>
 <Pine.LNX.4.64.0710210031130.25221@racer.site> <471AFD07.4040606@op5.se>
 <Pine.LNX.4.64.0710212308540.25221@racer.site> <471C586A.9030900@op5.se>
 <Pine.LNX.4.64.0710221156540.25221@racer.site> <ED965042-27DE-450B-96CB-00D27000FAF6@wincent.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andreas Ericsson <ae@op5.se>, Jakub Narebski <jnareb@gmail.com>,
	Steffen Prohaska <prohaska@zib.de>,
	Federico Mena Quintero <federico@novell.com>,
	git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Mon Oct 22 15:39:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjxUw-0001pV-Sv
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 15:39:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751957AbXJVNjD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 09:39:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751783AbXJVNjB
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 09:39:01 -0400
Received: from mail.gmx.net ([213.165.64.20]:54778 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751460AbXJVNjB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 09:39:01 -0400
Received: (qmail invoked by alias); 22 Oct 2007 13:38:59 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp016) with SMTP; 22 Oct 2007 15:38:59 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19ErxU1rlpEe1sdvDxgG9KBUW8fBWpcHENyl8mHZq
	T5adVSWt8j+Fsw
X-X-Sender: gene099@racer.site
In-Reply-To: <ED965042-27DE-450B-96CB-00D27000FAF6@wincent.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62003>

Hi,

On Mon, 22 Oct 2007, Wincent Colaiuta wrote:

> El 22/10/2007, a las 13:04, Johannes Schindelin escribi?:
> 
> > So once again, what operations involving git do people use regularly?
> 
> Here are my top ten commands, sorted by the number of times they appear 
> in my ~/.bash_history:

Thanks.  That's a really good idea.  I did the same, and it turns out that 
my list was wrong:

     68 log
     50 fetch
     36 show
     33 diff
     19 grep
     19 commit
     14 ps (my alias which runs -p status)
     10 config
      8 rebase
      8 push

Everybody who wants to find out the same: this is how I did it:

cat .bash_history |
	tr ";" "\\n" |
	sed -n "s/^ *git[- ]\([^ ]*\).*$/\1/p" |
	sort |
	uniq -c |
	sort -r -n

One thing that I realised by looking at my list: It probably makes more 
sense teaching people about "fetch" in the beginning, teach other parts 
about git, and only then "push".

We tend to teach people about "fetch" and "push" at the same time, but 
this is not consistent with any workflow.

Ciao,
Dscho
