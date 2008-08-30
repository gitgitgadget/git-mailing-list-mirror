From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH] git gui: use apply --unidiff-zero when staging hunks
	without context
Date: Sat, 30 Aug 2008 23:00:07 +0200
Message-ID: <20080830210007.GA15004@localhost>
References: <20080830164527.GA25370@localhost> <20080830165600.GB25370@localhost> <48B9A2D7.8090801@telecom.at> <20080830202706.GA13573@localhost> <7vprnqfcoo.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <johannes.sixt@telecom.at>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 30 23:01:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZXZ6-0004R4-Pr
	for gcvg-git-2@gmane.org; Sat, 30 Aug 2008 23:01:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753095AbYH3U7y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Aug 2008 16:59:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753065AbYH3U7y
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Aug 2008 16:59:54 -0400
Received: from postman.fh-hagenberg.at ([193.170.124.96]:36283 "EHLO
	mail.fh-hagenberg.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752887AbYH3U7x (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2008 16:59:53 -0400
Received: from darc.dyndns.org ([84.154.72.105]) by mail.fh-hagenberg.at over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 30 Aug 2008 22:59:51 +0200
Received: from drizzd by darc.dyndns.org with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1KZXYF-0003vP-Cn; Sat, 30 Aug 2008 23:00:07 +0200
Content-Disposition: inline
In-Reply-To: <7vprnqfcoo.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-OriginalArrivalTime: 30 Aug 2008 20:59:52.0099 (UTC) FILETIME=[58D52F30:01C90AE3]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94424>

On Sat, Aug 30, 2008 at 01:52:23PM -0700, Junio C Hamano wrote:
> Well, showing is Ok as long as you do not try pick and apply.  Or did I
> miss something?

If I understand correctly git gui bases its patches on what it shows in the
diff window - which makes sense, because otherwise it would be a PITA to
find out which hunk the user actually wanted.

We could allow diffs without context and disable staging in that case, but I
suspect this would only confuse the user.
