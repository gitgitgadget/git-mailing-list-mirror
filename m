From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 2/4] completion: Use consistent if [...] convention. No
	test.
Date: Wed, 11 Feb 2009 10:35:57 -0800
Message-ID: <20090211183557.GP30949@spearce.org>
References: <1234375406-27099-1-git-send-email-ted@tedpavlic.com> <1234375406-27099-2-git-send-email-ted@tedpavlic.com> <1234375406-27099-3-git-send-email-ted@tedpavlic.com> <20090211180705.GL30949@spearce.org> <7v1vu4g78q.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ted Pavlic <ted@tedpavlic.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 11 19:38:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXJyE-0003u5-Ae
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 19:38:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757927AbZBKSgA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 13:36:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757662AbZBKSf7
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 13:35:59 -0500
Received: from george.spearce.org ([209.20.77.23]:47614 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757347AbZBKSf6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 13:35:58 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id E360E38210; Wed, 11 Feb 2009 18:35:57 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7v1vu4g78q.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109478>

Junio C Hamano <gitster@pobox.com> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> >> -			elif test -f "$g/rebase-apply/applying"
> >> -			then
> >> +            elif [ -f "$g/rebase-apply/applying" ]; then
> >
> > There is some sort of whitespace damage right here, the elif doesn't
> > seem to line up correctly.
> 
> If that is the only gripe and otherwise if you are Ok with the patch, I'll
> queue the entire series with a fix-up here myself.

Yes, this patch is fine, if you can hand-fix the whitespace damage,
please feel free to add my Ack.

-- 
Shawn.
