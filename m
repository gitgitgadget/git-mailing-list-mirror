From: Chunlin Zhang <zhangchunlin@gmail.com>
Subject: Re: How to do with access control per repo with a smart http git server?
Date: Wed, 24 Nov 2010 05:07:46 +0000 (UTC)
Message-ID: <loom.20101124T060650-817@post.gmane.org>
References: <loom.20101124T035911-773@post.gmane.org> <20101124045025.GA12399@LK-Perkele-V2.elisa-laajakaista.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 24 06:08:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PL7aR-0003P1-GK
	for gcvg-git-2@lo.gmane.org; Wed, 24 Nov 2010 06:08:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751366Ab0KXFIB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Nov 2010 00:08:01 -0500
Received: from lo.gmane.org ([80.91.229.12]:39759 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751261Ab0KXFIA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Nov 2010 00:08:00 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PL7aJ-0003NK-IB
	for git@vger.kernel.org; Wed, 24 Nov 2010 06:07:59 +0100
Received: from 119.233.251.15 ([119.233.251.15])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 24 Nov 2010 06:07:59 +0100
Received: from zhangchunlin by 119.233.251.15 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 24 Nov 2010 06:07:59 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 119.233.251.15 (Mozilla/5.0 (X11; U; Linux i686; zh-CN; rv:1.9.2.12) Gecko/20101027 Ubuntu/10.04 (lucid) Firefox/3.6.12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162045>

Ilari Liusvaara <ilari.liusvaara <at> elisanet.fi> writes:

> 
> On Wed, Nov 24, 2010 at 03:10:27AM +0000, Chunlin Zhang wrote:
> > I setup a smart http git server with apache(
> > http://progit.org/2010/03/04/smart-http.html ),and I do the authentication with
> > SSPI,but how can I do with access control per repo?
> > 
> > Does somebody know it?
> 
> Easiest way to do it is via Gitolite.

I notice that:"gitolite depends heavily on ssh pubkey (passwordless) access" (
https://github.com/sitaramc/gitolite/blob/pu/doc/1-INSTALL.mkd )

> 
> -Ilari
> 
