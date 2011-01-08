From: Stephen Kelly <steveire@gmail.com>
Subject: Re: [PATCH] Introduce new configuation option to override committer information
Date: Sat, 08 Jan 2011 20:24:01 +0100
Message-ID: <igadki$4tb$2@dough.gmane.org>
References: <ig73o1$lbg$1@dough.gmane.org> <1294473809-11850-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 08 20:25:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbePe-0004zp-1l
	for gcvg-git-2@lo.gmane.org; Sat, 08 Jan 2011 20:25:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751455Ab1AHTZH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Jan 2011 14:25:07 -0500
Received: from lo.gmane.org ([80.91.229.12]:59682 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751086Ab1AHTZF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jan 2011 14:25:05 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PbePQ-0004tV-Qj
	for git@vger.kernel.org; Sat, 08 Jan 2011 20:25:04 +0100
Received: from dslb-092-078-138-003.pools.arcor-ip.net ([92.78.138.3])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 08 Jan 2011 20:25:04 +0100
Received: from steveire by dslb-092-078-138-003.pools.arcor-ip.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 08 Jan 2011 20:25:04 +0100
X-Injected-Via-Gmane: http://gmane.org/
Followup-To: gmane.comp.version-control.git
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: dslb-092-078-138-003.pools.arcor-ip.net
User-Agent: KNode/4.4.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164838>

Ramkumar Ramachandra wrote:

> Currently, there is no way to set committer information on a
> per-repository basis. The 'user.name' and 'user.email' configuration
> options set both author and committer information. To solve this,
> introduce 'user.committername' and 'user.committeremail' configuration
> options to override committer name and email respectively.
> 
> Reported-by: Stephen Kelly <steveire@gmail.com>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.co

<snip>

Thanks for working on this. I wanted to try it out, but it no longer applies 
cleanly since 4c28e4ada03f5440251545cf91e0d81bce9b010d and after trivial 
merging, I can't build.

Can you update the patch?

Thanks,

Steve.
