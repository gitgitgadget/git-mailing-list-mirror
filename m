From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Fri, 18 Jan 2008 18:24:44 +0100
Organization: At home
Message-ID: <fmqncq$5sf$1@ger.gmane.org>
References: <478E1FED.5010801@web.de> <200801180205.28742.robin.rosenberg.lists@dewire.com> <alpine.LFD.1.00.0801171716310.2957@woody.linux-foundation.org> <200801181042.37391.robin.rosenberg.lists@dewire.com> <20080118103036.GD14871@dpotapov.dyndns.org> <Pine.LNX.4.64.0801181631150.817@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 18 18:26:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFuyZ-0003l2-5E
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 18:25:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758140AbYARRY7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2008 12:24:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756965AbYARRY7
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jan 2008 12:24:59 -0500
Received: from main.gmane.org ([80.91.229.2]:48096 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754087AbYARRY6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2008 12:24:58 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JFuxa-0003Jn-AK
	for git@vger.kernel.org; Fri, 18 Jan 2008 17:24:54 +0000
Received: from abvf217.neoplus.adsl.tpnet.pl ([83.8.203.217])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 18 Jan 2008 17:24:54 +0000
Received: from jnareb by abvf217.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 18 Jan 2008 17:24:54 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abvf217.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71041>

Peter Karlsson wrote:

> Dmitry Potapov:
> 
>> because Microsoft C library does not work with encoding that requires
>> more than two bytes per character.
> 
> Indeed. On Windows, you should avoid using UTF-8 and instead use UTF-16
> everywhere. That usually works better, and if you run on an NT-based
> system it will convert all the data to WinAPI to UTF-16 anyway.

Errr... doesn't UTF-16 (as compared to USC-2) sometimes (for some exotic
characters) require more than two bytes per character?

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
