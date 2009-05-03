From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: bug in git diff --unified=0 ?
Date: Sat, 2 May 2009 17:23:52 -0700
Message-ID: <20090503002352.GP23604@spearce.org>
References: <20090502234701.GL23604@spearce.org> <7vocub59b3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 03 02:25:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M0PWk-0002vG-0m
	for gcvg-git-2@gmane.org; Sun, 03 May 2009 02:25:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752833AbZECAXw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 May 2009 20:23:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752719AbZECAXw
	(ORCPT <rfc822;git-outgoing>); Sat, 2 May 2009 20:23:52 -0400
Received: from george.spearce.org ([209.20.77.23]:56983 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752266AbZECAXv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 May 2009 20:23:51 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 120C338081; Sun,  3 May 2009 00:23:52 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7vocub59b3.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118154>

Junio C Hamano <gitster@pobox.com> wrote:
> I do not know what the current status of the POSIX draft for spliting
> "context diff" format into "copied context" and "unified context", but
> see http://www.opengroup.org/austin/aardvark/latest/xcubug2.txt for the
> definition that was on track the last time I checked.

Doh.  Thank you for the clarification Junio.
 
> So, JGit is wrong.

Yup, I agree.  /me works up a replacement patch.

-- 
Shawn.
