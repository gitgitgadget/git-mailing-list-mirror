From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/5] New version of pre-commit hook
Date: Fri, 14 Dec 2007 01:17:42 +0100
Organization: At home
Message-ID: <fjsi37$7ji$1@ger.gmane.org>
References: <1197552751-53480-1-git-send-email-win@wincent.com> <1197552751-53480-2-git-send-email-win@wincent.com> <1197552751-53480-3-git-send-email-win@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 14 01:18:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2yFx-0001Di-LH
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 01:18:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765234AbXLNAR6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Dec 2007 19:17:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765104AbXLNAR6
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Dec 2007 19:17:58 -0500
Received: from main.gmane.org ([80.91.229.2]:33445 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763358AbXLNAR4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2007 19:17:56 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1J2yFT-0007Du-Gb
	for git@vger.kernel.org; Fri, 14 Dec 2007 00:17:51 +0000
Received: from abwv165.neoplus.adsl.tpnet.pl ([83.8.245.165])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 14 Dec 2007 00:17:51 +0000
Received: from jnareb by abwv165.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 14 Dec 2007 00:17:51 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abwv165.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68205>

Wincent Colaiuta wrote:

> Now that "git diff --check" indicates problems with its exit code the
> pre-commit hook becomes a trivial one-liner.

> -         if (/^(?:[<>=]){7}/) {
> -             bad_line("unresolved merge conflict", $_);
> -         }

Aren't you losing this check with rewrite?

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
