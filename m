From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/2 v2] check-attr: Add --stdin-paths option
Date: Sun, 12 Oct 2008 17:04:21 +0200
Organization: At home
Message-ID: <gct3lk$s16$1@ger.gmane.org>
References: <bb6f213e0809220312m6cb8022csa3843cfaccc5b69b@mail.gmail.com> <1223173855-6173-1-git-send-email-dpotapov@gmail.com> <1223173855-6173-2-git-send-email-dpotapov@gmail.com> <48E9B997.1010006@viscovery.net> <20081007001652.GR21650@dpotapov.dyndns.org> <20081008152443.GA4795@spearce.org> <20081012141952.GD21650@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 12 17:06:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kp2Vr-0002J6-Q1
	for gcvg-git-2@gmane.org; Sun, 12 Oct 2008 17:05:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753412AbYJLPEa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Oct 2008 11:04:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753386AbYJLPEa
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Oct 2008 11:04:30 -0400
Received: from main.gmane.org ([80.91.229.2]:50351 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752717AbYJLPE3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Oct 2008 11:04:29 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Kp2Ud-0000TF-Ct
	for git@vger.kernel.org; Sun, 12 Oct 2008 15:04:27 +0000
Received: from abxa211.neoplus.adsl.tpnet.pl ([83.8.250.211])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 12 Oct 2008 15:04:27 +0000
Received: from jnareb by abxa211.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 12 Oct 2008 15:04:27 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abxa211.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98026>

Dmitry Potapov wrote:

>> And since its being
>> used mostly by automated tools (gitk/git-gui) I wonder if a -z should
>> also be supported for input termination with NUL instead of LF.
> 
> I have added it, but after I did, I start to wonder whether it is the
> right thing to do to unquote NUL terminated input line?

I think that -z should be not quoted (like git-diff-tree or git-ls-tree
_output_); if it is, then IMHO it is a bug.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
