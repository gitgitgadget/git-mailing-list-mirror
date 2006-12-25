From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] git-add: warn when adding an ignored file with an explicit request.
Date: Mon, 25 Dec 2006 23:24:30 +0100
Organization: At home
Message-ID: <empitl$t6p$1@sea.gmane.org>
References: <7vbqlskz2u.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0612251443230.19693@wbgn013.biozentrum.uni-wuerzburg.de> <7vslf3khsc.fsf@assigned-by-dhcp.cox.net> <7vodprizuw.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Mon Dec 25 23:25:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GyyFv-0001VT-EO
	for gcvg-git@gmane.org; Mon, 25 Dec 2006 23:25:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754553AbWLYWZI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Dec 2006 17:25:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754499AbWLYWZI
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Dec 2006 17:25:08 -0500
Received: from main.gmane.org ([80.91.229.2]:51460 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754553AbWLYWZH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Dec 2006 17:25:07 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1GyyFh-0007sD-Ts
	for git@vger.kernel.org; Mon, 25 Dec 2006 23:25:01 +0100
Received: from host-81-190-19-121.torun.mm.pl ([81.190.19.121])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 25 Dec 2006 23:25:01 +0100
Received: from jnareb by host-81-190-19-121.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 25 Dec 2006 23:25:01 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-19-121.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35397>

Junio C Hamano wrote:

> We allow otherwise ignored paths to be added to the index by
> spelling its path out on the command line, but we would warn the
> user about them when we do so.

I'm for warning user that the file to be added is ignored file and
telling how to make an exception in .gitignore _AND_ that -f option
can be used to bypass that check. And adding ignored path as above
with -f option.

But otherwise: nice series of patches.

P.S. Were all the patches sent as replies to introductory letter?
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
