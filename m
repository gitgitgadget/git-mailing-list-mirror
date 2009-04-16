From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 4/5] archive: do not read .gitattributes in working directory
Date: Thu, 16 Apr 2009 09:29:12 +0200
Organization: At home
Message-ID: <gs6mo9$nc6$1@ger.gmane.org>
References: <1239848917-14399-1-git-send-email-gitster@pobox.com> <1239848917-14399-2-git-send-email-gitster@pobox.com> <1239848917-14399-3-git-send-email-gitster@pobox.com> <1239848917-14399-4-git-send-email-gitster@pobox.com> <1239848917-14399-5-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 16 09:31:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LuM3r-0004XR-LM
	for gcvg-git-2@gmane.org; Thu, 16 Apr 2009 09:31:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752945AbZDPH3b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2009 03:29:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752661AbZDPH3a
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Apr 2009 03:29:30 -0400
Received: from main.gmane.org ([80.91.229.2]:53766 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751365AbZDPH3a (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2009 03:29:30 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LuM2G-0000zZ-4R
	for git@vger.kernel.org; Thu, 16 Apr 2009 07:29:24 +0000
Received: from abvp180.neoplus.adsl.tpnet.pl ([83.8.213.180])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 16 Apr 2009 07:29:24 +0000
Received: from jnareb by abvp180.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 16 Apr 2009 07:29:24 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abvp180.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116679>

Junio C Hamano wrote:

> The old behaviour still remains with --fix-attributes, and it is always on
> for the legacy "git tar-tree".

I thought that we agreed on '--worktree-attributes' being better name,
didn't we?

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
