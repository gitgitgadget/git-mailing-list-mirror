From: Christoph Bartoschek <bartoschek@gmx.de>
Subject: Submodules implementation
Date: Wed, 24 Feb 2010 00:50:44 +0100
Organization: =?UTF-8?B?VW5pdmVyc2l0w6R0?= Bonn
Message-ID: <k76e57-g67.ln1@burns.bruehl.pontohonk.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 24 00:52:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nk4YS-0007JE-Dx
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 00:52:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754842Ab0BWXwf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2010 18:52:35 -0500
Received: from lo.gmane.org ([80.91.229.12]:33525 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754358Ab0BWXwf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2010 18:52:35 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Nk4YL-0007HZ-Lp
	for git@vger.kernel.org; Wed, 24 Feb 2010 00:52:33 +0100
Received: from p54bacd4f.dip.t-dialin.net ([84.186.205.79])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 24 Feb 2010 00:52:33 +0100
Received: from bartoschek by p54bacd4f.dip.t-dialin.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 24 Feb 2010 00:52:33 +0100
X-Injected-Via-Gmane: http://gmane.org/
Followup-To: gmane.comp.version-control.git
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: p54bacd4f.dip.t-dialin.net
User-Agent: KNode/4.3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140876>

Hi,

what is the main reason that submodules are their own repositories linked 
into the enclosing one and not just additional pointers in the main 
repository?

My impression is that submodules as pointers to existing tree objects would 
make a design more easier to understand and more user friendly. 
Especially I see no need for most of the submodule commands. Maybe "git 
submodule add" but the other commands are already covered by existing ones.

Or is there a tool that uses such additional pointers for submodule 
management?

Thanks
Christoph
