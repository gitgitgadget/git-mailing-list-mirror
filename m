From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] describe: Break annotated tag ties by tagger date
Date: Sat, 10 Apr 2010 19:40:08 -0700
Message-ID: <20100411024008.GC23075@spearce.org>
References: <0B8BD2B7-E6F9-4EFC-BCD6-2B2E876AD1FC@spy.net> <20100402183147.GA20007@spearce.org> <4BBB0377.8080007@op5.se> <20100411002825.GA23075@spearce.org> <20100411015433.GB23075@spearce.org> <7vwrwera05.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Ericsson <ae@op5.se>, Dustin Sallings <dustin@spy.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 11 04:40:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0n5u-0000cM-7q
	for gcvg-git-2@lo.gmane.org; Sun, 11 Apr 2010 04:40:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752409Ab0DKCkM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Apr 2010 22:40:12 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:45336 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752224Ab0DKCkL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Apr 2010 22:40:11 -0400
Received: by gyg13 with SMTP id 13so2297461gyg.19
        for <git@vger.kernel.org>; Sat, 10 Apr 2010 19:40:10 -0700 (PDT)
Received: by 10.101.131.22 with SMTP id i22mr1599957ann.174.1270953610153;
        Sat, 10 Apr 2010 19:40:10 -0700 (PDT)
Received: from localhost (yellowpostit.mtv.corp.google.com [172.18.104.34])
        by mx.google.com with ESMTPS id 35sm726508yxh.33.2010.04.10.19.40.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 10 Apr 2010 19:40:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vwrwera05.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144627>

Junio C Hamano <gitster@pobox.com> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > If more than one annotated tag points at the same commit, use the
> > tag whose tagger field has a more recent date stamp.  This resolves
> > non-deterministic cases where the maintainer has done:
> 
> I think it is a good idea to introduce this tiebreaker to give the listing
> some degree of stability.  And I also notice that you prepared a patch
> that can easily apply to an older codebase like 1.6.6 maintenance track.
> 
> I have anything against this as an incremental and low impact improvement,
> but at the same time I think we might want to consider adding the tagger
> date to "struct tag".

Yea, I thought about that.  It would have simplified the code
in describe.  But I was also trying to avoid a larger impact.  :-)

I'm more than happy to respin with a new date field in struct tag.
I just won't be able to get to it before Monday.

-- 
Shawn.
