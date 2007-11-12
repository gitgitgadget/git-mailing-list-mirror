From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] status&commit: Teach them to show submodule commit summary
Date: Mon, 12 Nov 2007 17:12:02 +0100
Organization: At home
Message-ID: <fh9u0i$n93$1@ger.gmane.org>
References: <1194877277-31777-1-git-send-email-pkufranky@gmail.com> <4738784F.7010106@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 12 17:12:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Irbu8-0004OI-H0
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 17:12:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752322AbXKLQMg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 11:12:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751942AbXKLQMg
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 11:12:36 -0500
Received: from main.gmane.org ([80.91.229.2]:56796 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751672AbXKLQMf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 11:12:35 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Irbtd-0007l4-OV
	for git@vger.kernel.org; Mon, 12 Nov 2007 16:12:21 +0000
Received: from abwz76.neoplus.adsl.tpnet.pl ([83.8.249.76])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 12 Nov 2007 16:12:21 +0000
Received: from jnareb by abwz76.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 12 Nov 2007 16:12:21 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abwz76.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64646>

Johannes Sixt wrote:

>> A configuration variable 'submodule.status' is used to turn this summary
>> behaviour on or off (default off). Also --submodule and --no-submodule options
>> are added.
> 
> There is already 'status.color', I suggest the configuration to become 
> 'status.submoduleSummary'.

Or status.submodule.summary, although we usually use
section.<variable_sub>.key configuration variables,
e.g. branch.<name>.remote. But we have exception:
color.branch.<slot>

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
