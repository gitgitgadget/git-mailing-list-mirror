From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] t9118: avoid PEG revision identifier in tests
Date: Thu, 8 Jul 2010 13:38:09 -0700
Message-ID: <20100708203809.GA2991@dcvr.yhbt.net>
References: <4C361EB5.7010704@drmicha.warpmail.net> <2f9f1bd8efb818456fcc386f419fc17f4e435e19.1278616418.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Torsten Schmutzler <git-ts@theblacksun.eu>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Jul 08 22:38:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWxrN-0007nA-LQ
	for gcvg-git-2@lo.gmane.org; Thu, 08 Jul 2010 22:38:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755091Ab0GHUiL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jul 2010 16:38:11 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:46459 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754803Ab0GHUiJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jul 2010 16:38:09 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 445091F488;
	Thu,  8 Jul 2010 20:38:09 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <2f9f1bd8efb818456fcc386f419fc17f4e435e19.1278616418.git.git@drmicha.warpmail.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150611>

Michael J Gruber <git@drmicha.warpmail.net> wrote:
> @ is SVN's identifier for PEG revisions. But SVN's treatment of PEG
> identifiers in copy target URLs changed in r954995/r952973, i.e. between
> 1.6.11 and 1.6.12. They get eaten now (which is considered the right
> way).
> 
> Therefore, avoid the @ in the tests with funky branch names.
> 
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
> This version is tested with svn 1.6.9 and 1.6.12.

Thanks Michael, also tested with svn 1.5.1.
Acked and pushed up to git://git.bogomips.org/git-svn

-- 
Eric Wong
