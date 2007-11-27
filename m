From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Add 'git fast-export', the sister of 'git fast-import'
Date: Wed, 28 Nov 2007 00:40:30 +0100
Organization: At home
Message-ID: <fii9ta$b2j$1@ger.gmane.org>
References: <Pine.LNX.4.64.0711252236350.4725@wbgn129.biozentrum.uni-wuerzburg.de> <20071127020842.GN14735@spearce.org> <Pine.LNX.4.64.0711271127440.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 28 00:41:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxA3I-0000CK-BA
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 00:41:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757819AbXK0Xk5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2007 18:40:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757032AbXK0Xk5
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 18:40:57 -0500
Received: from main.gmane.org ([80.91.229.2]:50941 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753479AbXK0Xk4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2007 18:40:56 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IxA2j-00010B-Uh
	for git@vger.kernel.org; Tue, 27 Nov 2007 23:40:41 +0000
Received: from abvx114.neoplus.adsl.tpnet.pl ([83.8.221.114])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 27 Nov 2007 23:40:41 +0000
Received: from jnareb by abvx114.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 27 Nov 2007 23:40:41 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abvx114.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66274>

Johannes Schindelin wrote:

> On Mon, 26 Nov 2007, Shawn O. Pearce wrote:

>> I think this should be prefixed by fast-import patch to teach it 
>> something like "encoding N" as a subcommand of commit, so that you can 
>> feed data in a non UTF-8 encoding and get it to include the proper 
>> encoding header in the commit object it creates.  That way a pipeline 
>> like the above really does create a duplicate repository, with the same 
>> commit SHA-1s, even if the commits weren't in UTF-8.
> 
> IMHO it's not worth that hassle.  People who want to use fast-import 
> usually want something fast which works, and not bother with specifying 
> encodings.

Well, when I am converting some repository which uses legacy encoding
(not utf-8), I'd like to use this git feature of specifying encoding;
actually, to be generic, it could be any header which would be added to
all created commit objects.

Yes, I could reencode commit messages...


P.S. One nice use of proposed (at one time) 'note' header would be to
save revision identifier from the version control system you import
(CVS revision number, Subversion sequential revision number, etc.).

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
