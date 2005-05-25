From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: git-rev-tree ---stdin -s -p broken
Date: Wed, 25 May 2005 14:39:25 +0200
Message-ID: <20050525123925.GA1481@vrfy.org>
References: <20050525121738.GC24325@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed May 25 14:40:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DavA4-0003Gu-FU
	for gcvg-git@gmane.org; Wed, 25 May 2005 14:39:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262328AbVEYMkY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 May 2005 08:40:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261444AbVEYMkY
	(ORCPT <rfc822;git-outgoing>); Wed, 25 May 2005 08:40:24 -0400
Received: from soundwarez.org ([217.160.171.123]:18587 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S262329AbVEYMj2 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 May 2005 08:39:28 -0400
Received: by soundwarez.org (Postfix, from userid 2702)
	id 87E7B39D2D; Wed, 25 May 2005 14:39:25 +0200 (CEST)
To: GIT <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20050525121738.GC24325@cip.informatik.uni-erlangen.de>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, May 25, 2005 at 02:17:38PM +0200, Thomas Glanzmann wrote:
> Hello,
> this doesn't produce any output for me:
> 
> (faui01) [~/work/git/yagf] git-rev-list HEAD | git-diff-tree --stdin -v -s
> (faui01) [~/work/git/yagf]

Works for me with the latest git.
Does git-rev-list work?
Try strace'ing git-diff-tree.

Kay
