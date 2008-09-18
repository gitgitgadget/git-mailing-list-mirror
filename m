From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: How to supply "raw" bytes to git grep?
Date: Thu, 18 Sep 2008 18:31:30 +0200
Organization: At home
Message-ID: <gatvp0$kl0$1@ger.gmane.org>
References: <200809181728.18597.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 18 18:33:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgMRB-0001h0-Lz
	for gcvg-git-2@gmane.org; Thu, 18 Sep 2008 18:33:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754745AbYIRQbk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Sep 2008 12:31:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754390AbYIRQbj
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Sep 2008 12:31:39 -0400
Received: from main.gmane.org ([80.91.229.2]:50825 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754219AbYIRQbj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Sep 2008 12:31:39 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KgMPp-0004ZA-6D
	for git@vger.kernel.org; Thu, 18 Sep 2008 16:31:37 +0000
Received: from abve248.neoplus.adsl.tpnet.pl ([83.8.202.248])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 18 Sep 2008 16:31:37 +0000
Received: from jnareb by abve248.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 18 Sep 2008 16:31:37 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abve248.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96215>

Johan Herland wrote:

> I wanted to list all text files in my repo which contain carriage 
> returns, so I tried the following command-line:
> 
>       git grep --cached -I -l -e <CR>
> 
> where <CR> is some magic incantation that I've yet to figure out. I've 
> tried all the obvious cases (\r, 0x0d, \015, etc.), but none of them 
> seem to DWIM...

Why not use _literal_ CR; of course protecting it by piockung it by
shell as end of command by quites, for example

  $ git grep --cached -I -l -e '
  '

It works for me (bash).
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
