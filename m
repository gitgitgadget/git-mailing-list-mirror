From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/2] Allow fetch-pack to decide keeping the fetched pack without exploding
Date: Tue, 23 Jan 2007 11:55:26 +0100
Organization: At home
Message-ID: <ep4phb$fef$1@sea.gmane.org>
References: <7v64b04v2e.fsf@assigned-by-dhcp.cox.net> <7v3b6439uh.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0701212234520.22628@wbgn013.biozentrum.uni-wuerzburg.de> <7vzm8ansrt.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0701231129501.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Tue Jan 23 11:54:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9JIi-0003Gn-PN
	for gcvg-git@gmane.org; Tue, 23 Jan 2007 11:54:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932955AbXAWKyt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Jan 2007 05:54:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932957AbXAWKys
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jan 2007 05:54:48 -0500
Received: from main.gmane.org ([80.91.229.2]:60720 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932955AbXAWKys (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jan 2007 05:54:48 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1H9JIa-0000sq-B9
	for git@vger.kernel.org; Tue, 23 Jan 2007 11:54:44 +0100
Received: from host-81-190-20-200.torun.mm.pl ([81.190.20.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 23 Jan 2007 11:54:44 +0100
Received: from jnareb by host-81-190-20-200.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 23 Jan 2007 11:54:44 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-20-200.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37495>

Johannes Schindelin wrote:

> P.S.: These patches make me dream of yet another diff format enhancement: 
> code moves! Of course, for this to be really usable, you'd also have to 
> automatically determine indent changes... You may say I'm a dreamer. But 
> I'm not the only one...

I wonder if it could be done with e.g.

--- a/fromfile
+++ b/somefile
<code movement or copying>

--- a/somefile
+++ b/somefile
<other changes>

The problem is that context differs usually for code movement.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
