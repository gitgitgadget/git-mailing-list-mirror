From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: mingw, windows, crlf/lf, and git
Date: Mon, 12 Feb 2007 01:46:56 +0100
Organization: At home
Message-ID: <eqodam$r17$1@sea.gmane.org>
References: <45CFA30C.6030202@verizon.net> <Pine.LNX.4.63.0702120028340.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 12 01:47:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGPLN-0002qK-A5
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 01:46:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932881AbXBLApy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Feb 2007 19:45:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932938AbXBLApy
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Feb 2007 19:45:54 -0500
Received: from main.gmane.org ([80.91.229.2]:45134 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932881AbXBLApb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Feb 2007 19:45:31 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HGPJp-0005bD-14
	for git@vger.kernel.org; Mon, 12 Feb 2007 01:45:21 +0100
Received: from host-81-190-18-64.torun.mm.pl ([81.190.18.64])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 12 Feb 2007 01:45:21 +0100
Received: from jnareb by host-81-190-18-64.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 12 Feb 2007 01:45:21 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-18-64.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39346>

Johannes Schindelin wrote:
> On Sun, 11 Feb 2007, Mark Levedahl wrote:
> 
>> The major competing solutions git seeks to supplant (cvs, cvsnt, svn, 
>> hg) have capability to recognize "text" files and transparently replace 
>> \r\n with \n on input, the reverse on output, and ignore all such 
>> differences on diff operations.
> 
> Agree with transformations on input and output; disagree on diff.

I wonder if this could/should be solved with adding some option to git-diff,
similar to --ignore-space-change and --ignore-all-space...

Just a [idle] thought.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
