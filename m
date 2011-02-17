From: Chunlin Zhang <zhangchunlin@gmail.com>
Subject: Re: How to git checkout a orgin(unstage) version file in another directoy?
Date: Thu, 17 Feb 2011 10:03:04 +0000 (UTC)
Message-ID: <loom.20110217T110216-810@post.gmane.org>
References: <loom.20110217T074533-358@post.gmane.org> <4D5CDBAD.4050700@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 17 11:03:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pq0hm-000747-B9
	for gcvg-git-2@lo.gmane.org; Thu, 17 Feb 2011 11:03:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754306Ab1BQKDS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Feb 2011 05:03:18 -0500
Received: from lo.gmane.org ([80.91.229.12]:47397 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752844Ab1BQKDR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Feb 2011 05:03:17 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Pq0hf-0006y8-N1
	for git@vger.kernel.org; Thu, 17 Feb 2011 11:03:16 +0100
Received: from 218.107.217.218 ([218.107.217.218])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 17 Feb 2011 11:03:15 +0100
Received: from zhangchunlin by 218.107.217.218 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 17 Feb 2011 11:03:15 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 218.107.217.218 (Mozilla/5.0 (X11; U; Linux i686; zh-CN; rv:1.9.2.12) Gecko/20101027 Ubuntu/10.04 (lucid) Firefox/3.6.12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167061>

Michael J Gruber <git <at> drmicha.warpmail.net> writes:

> 
> I'm not sure what you mean by "origin" version, but if you mean the
> version from the current revision (before making and staging changes),
> you would check out from HEAD instead of from the index:
Yes,I mean HEAD version.
> 
> git --work-tree=. --git-dir="/media/linux/t/kernel/.git" checkout HEAD
It works! Thank you very much!
