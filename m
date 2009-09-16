From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC/PATCH 0/2] Speed up fetch with large number of tags
Date: Wed, 16 Sep 2009 15:46:51 -0700
Message-ID: <20090916224651.GA15259@spearce.org>
References: <20090916074737.58044.42776.julian@quantumfyre.co.uk> <7vbplb2pi7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Julian Phillips <julian@quantumfyre.co.uk>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 17 00:52:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mo3Mm-0008Jf-II
	for gcvg-git-2@lo.gmane.org; Thu, 17 Sep 2009 00:52:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760597AbZIPWsC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2009 18:48:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760538AbZIPWqw
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Sep 2009 18:46:52 -0400
Received: from george.spearce.org ([209.20.77.23]:37961 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755432AbZIPWqs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2009 18:46:48 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id D99AE381FE; Wed, 16 Sep 2009 22:46:51 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7vbplb2pi7.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128688>

Junio C Hamano <gitster@pobox.com> wrote:
> A few questions (not criticisms).
> 
>  * 1m50s to 4.5s is quite impressive, even if it is only in a repository
>    with unusual refs-vs-commits ratio, but I personally think 10 refs per
>    every commit is already on the borderline of being insane, and the
>    normal ratio would be more like 1 refs per every 10-20 commits.

Under Gerrit Code Review it is normaly to have 2-5 refs per commit,
every iteration of a patch is held as a commit and anchored by a
unique ref.

So we're borderline insane.  :-)
 
-- 
Shawn.
