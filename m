From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: gitweb pathinfo improvements
Date: Wed, 03 Sep 2008 12:02:54 +0200
Message-ID: <g9lncf$182$1@ger.gmane.org>
References: <1220435839-29360-1-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 03 12:04:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KapE7-00028B-RX
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 12:04:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751533AbYICKDO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2008 06:03:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751598AbYICKDN
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 06:03:13 -0400
Received: from main.gmane.org ([80.91.229.2]:53335 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751533AbYICKDN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2008 06:03:13 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KapCg-0002mM-8p
	for git@vger.kernel.org; Wed, 03 Sep 2008 10:03:10 +0000
Received: from 78.15.13.249 ([78.15.13.249])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 03 Sep 2008 10:03:10 +0000
Received: from giuseppe.bilotta by 78.15.13.249 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 03 Sep 2008 10:03:10 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 78.15.13.249
User-Agent: KNode/0.10.9
X-Face: ::w9}R^l{WGM\{y)C0QF@4^U,',W3Mk^X0HP)=:bKM^Z]A9+6bY6fe3}O*]fH{l<j1/9RTp  `KR0idy]Im#9^%}P5Dga'>AViT_'?&>&ufo2_X5Vs3C^tPO@drZRuu&6iK}x}~9`F\-dNZ>(p|V7`4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94781>

Damn, I forgot the patch sequence numbers.

On Wednesday 03 September 2008 11:57, Giuseppe Bilotta wrote:
> The following patchset improves on gitweb's support for PATH_INFO
> by supporting paths in the form project/action/[parent..]hash,
> both in generating them and in accepting them. The old path info
> style project/hash is still supported as long as it doesn't
> conflict with the new style
> 
> For those that prefer git trees to patch bombs, my git tree is
> available for gitweb browsing at http://git.oblomov.eu/git and for
> git cloning at git://git.oblomov.eu/git/git
> 
> The changes are very local to the PATH_INFO parsing and creation,
> so I hope they don't conflict with Lea's cache work.

-- 
Giuseppe "Oblomov" Bilotta
