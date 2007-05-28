From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: Re: GIT on MinGW problem
Date: Sun, 27 May 2007 21:31:22 -0300
Message-ID: <465A22DA.4010504@xs4all.nl>
References: <1dbc01c79432$b4400a80$0200a8c0@AMD2500> <46592CFE.40303@xs4all.nl> <4659318B.20801@midwinter.com> <200705271109.11942.jnareb@gmail.com> <465A11AB.6060906@xs4all.nl> <Pine.LNX.4.64.0705280059520.4648@racer.site>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>,
	Steven Grimm <koreth@midwinter.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 28 02:33:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HsTBF-0004PN-7k
	for gcvg-git@gmane.org; Mon, 28 May 2007 02:33:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752339AbXE1Adn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 May 2007 20:33:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753300AbXE1Adm
	(ORCPT <rfc822;git-outgoing>); Sun, 27 May 2007 20:33:42 -0400
Received: from main.gmane.org ([80.91.229.2]:55437 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752339AbXE1Adm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 May 2007 20:33:42 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HsTB2-0003hy-I3
	for git@vger.kernel.org; Mon, 28 May 2007 02:33:36 +0200
Received: from c911deb6.bhz.virtua.com.br ([201.17.222.182])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 28 May 2007 02:33:36 +0200
Received: from hanwen by c911deb6.bhz.virtua.com.br with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 28 May 2007 02:33:36 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: c911deb6.bhz.virtua.com.br
User-Agent: Thunderbird 1.5.0.10 (X11/20070302)
In-Reply-To: <Pine.LNX.4.64.0705280059520.4648@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48602>

Johannes Schindelin escreveu:
>>> but it does not do this, and does not check chache by default. Of course
>>> tests have to be written to make use of cache, IIRC...
>> Slowness is a misguided argument as well.  Yes, configure is slow, but 
>> you only have to run it if configure.in , config.h.in or config.make.in 
>> chagnes. And that doesn't happen very often during development.
> 
> Slowness is a good argument. The config does change from time to time (you 
> should know, IICC LilyPond had 36 changes in configure.in through 2006). 

Compared to the 100 recompiles during a typical debug/compile day, that's 
not very significant, IMO.


-- 
 Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
