From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Allow branch names that end with ".lock"
Date: Thu, 7 May 2009 17:54:17 -0700
Message-ID: <20090508005417.GV30527@spearce.org>
References: <1241708714-20326-1-git-send-email-spearce@spearce.org> <1241708714-20326-2-git-send-email-spearce@spearce.org> <200905080102.44053.robin.rosenberg@dewire.com> <alpine.LFD.2.01.0905071620240.4983@localhost.localdomain> <7vprekbfik.fsf@alter.siamese.dyndns.org> <7viqkcbenb.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 08 02:54:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2EM7-00075m-5E
	for gcvg-git-2@gmane.org; Fri, 08 May 2009 02:54:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753391AbZEHAyR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2009 20:54:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753126AbZEHAyR
	(ORCPT <rfc822;git-outgoing>); Thu, 7 May 2009 20:54:17 -0400
Received: from george.spearce.org ([209.20.77.23]:47421 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751813AbZEHAyR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2009 20:54:17 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id A9DEC381D0; Fri,  8 May 2009 00:54:17 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7viqkcbenb.fsf_-_@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118551>

Junio C Hamano <gitster@pobox.com> wrote:
> A project policy for naming branches could be to use a dot as a word
> separator (instead of '-' which is often done by existing projects), and
> "fix.vm.lock" could be a very valid name for a branch to address a VM
> locking issues.

I think we sent the same patch... except...
 
>  git-gui/lib/index.tcl                    |    2 +-

Don't do that.  I'll patch git-gui and send you a pull request.

-- 
Shawn.
