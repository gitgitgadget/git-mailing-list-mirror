From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git diff --chunk-pickaxe?
Date: Mon, 22 Jun 2009 14:27:46 +0200
Organization: At home
Message-ID: <h1nt21$lk4$1@ger.gmane.org>
References: <fcaeb9bf0906220507q45a61dc3w25ad41a4a65a2d5a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 22 14:22:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MIiY1-0000OQ-Rw
	for gcvg-git-2@gmane.org; Mon, 22 Jun 2009 14:22:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751113AbZFVMWo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2009 08:22:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751084AbZFVMWn
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jun 2009 08:22:43 -0400
Received: from main.gmane.org ([80.91.229.2]:42150 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750958AbZFVMWn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2009 08:22:43 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1MIiXp-00051H-EQ
	for git@vger.kernel.org; Mon, 22 Jun 2009 12:22:41 +0000
Received: from abrz167.neoplus.adsl.tpnet.pl ([83.8.119.167])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 22 Jun 2009 12:22:41 +0000
Received: from jnareb by abrz167.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 22 Jun 2009 12:22:41 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abrz167.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122031>

Nguyen Thai Ngoc Duy wrote:

> What I want is only show diff chunks that add or remove a line that
> does not start with '#', something like a chunk-level pickaxe. Any
> pointer where to start? It looks like I can start from
> xdi_diff_outf(). Just wanted to make sure I won't follow a wrong way
> from the beginning.

Perhaps you can use textconv here?

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
