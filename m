From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: how do I merge completely unrelated repositories ?
Date: Thu, 26 Jun 2008 13:04:27 +0200
Organization: At home
Message-ID: <g3vt3r$lm3$1@ger.gmane.org>
References: <46d6db660806260239xc57ffaag6469967ae2257cb1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 26 13:05:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBpIY-0001AS-Bf
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 13:05:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757159AbYFZLEj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2008 07:04:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751519AbYFZLEj
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 07:04:39 -0400
Received: from main.gmane.org ([80.91.229.2]:34930 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757868AbYFZLEi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2008 07:04:38 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KBpHF-0004aJ-UT
	for git@vger.kernel.org; Thu, 26 Jun 2008 11:04:33 +0000
Received: from abvw164.neoplus.adsl.tpnet.pl ([83.8.220.164])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 26 Jun 2008 11:04:33 +0000
Received: from jnareb by abvw164.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 26 Jun 2008 11:04:33 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abvw164.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86430>

Christian MICHON wrote:

> I'd like to create a new empty repository and merge into it 2
> completely unrelated remote repositories.
> 
> How would you do it, since merge will not merge if it cannot find a
> common ancestor ?

The problem probably is _empty_ repository (what do you want to merge),
not lack of common ancestors.  git.git repository has joined unrelated
projects (git-mail-tools, gitweb, gitk, git-gui) and it has several
roots, and even a few separate branches.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
