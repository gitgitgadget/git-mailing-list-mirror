From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: What's cooking in git.git (Apr 2015, #02; Tue, 14)
Date: Wed, 15 Apr 2015 10:21:22 +0200
Organization: gmx
Message-ID: <dc65eeeac0e973b35c62bcea8100a408@www.dscho.org>
References: <xmqqh9si1itr.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, git-owner@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 15 10:21:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YiIZt-0005xF-Lj
	for gcvg-git-2@plane.gmane.org; Wed, 15 Apr 2015 10:21:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751698AbbDOIVl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Apr 2015 04:21:41 -0400
Received: from mout.gmx.net ([212.227.17.21]:54104 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751241AbbDOIVi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Apr 2015 04:21:38 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0LzYY2-1ZUMnR43vu-014hk9; Wed, 15 Apr 2015 10:21:24
 +0200
In-Reply-To: <xmqqh9si1itr.fsf@gitster.dls.corp.google.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:xv1CFDeDNCao2T2pXiniUIWkosFmJyD/EqWpTsLSN8vkxCyWr7l
 VpxIH6ae61wsDrPuzw3hD58wN8dekxn3yP9X06WsVNnqhZGqBs5Z3llrZEs8l3PGZoIv+If
 qzWTeBtfIfW6hnzA4JZc7B9/9+etcYYxgSet9bFZXBL2BqrdIt8wyEAEntSYbNnVXnI/Anl
 STFDBMPBmz5OULHXbECnQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267190>

Hi Junio,

On 2015-04-14 23:49, Junio C Hamano wrote:
> 
> * jc/update-instead-into-void (2015-04-01) 1 commit
>   (merged to 'next' on 2015-04-08 at 8ef4e15)
>  + push-to-deploy: allow pushing into an unborn branch and updating it
> 
>  A push into an unborn branch, with "receive.denyCurrentBranch" set
>  to "updateInstead", did not check out the working tree as expected.

Thank you for cleaning up after me.

> * js/fsck-opt (2015-01-21) 19 commits
>  - fsck: support ignoring objects in `git fsck` via fsck.skiplist
>  - fsck: git receive-pack: support excluding objects from fsck'ing
>  - fsck: introduce `git fsck --quick`
>  - fsck: support demoting errors to warnings
>  - fsck: document the new receive.fsck.* options
>  - fsck: allow upgrading fsck warnings to errors
>  - fsck: optionally ignore specific fsck issues completely
>  - fsck: disallow demoting grave fsck errors to warnings
>  - fsck: add a simple test for receive.fsck.*
>  - fsck: make fsck_tag() warn-friendly
>  - fsck: handle multiple authors in commits specially
>  - fsck: make fsck_commit() warn-friendly
>  - fsck: make fsck_ident() warn-friendly
>  - fsck: report the ID of the error/warning
>  - fsck: allow demoting errors to warnings via receive.fsck.warn = <key>
>  - fsck: offer a function to demote fsck errors to warnings
>  - fsck: provide a function to parse fsck message IDs
>  - fsck: introduce identifiers for fsck messages
>  - fsck: introduce fsck options
> 
>  "fsck.warnings = <list of error tokens>" I suggested turned out to
>  be an unpopular choice (sorry Dscho).
> 
>  Expecting a reroll.

Yeah, I'll get to this either today or tomorrow.

Sorry for the long wait,
Dscho
