From: Miles Bader <miles@gnu.org>
Subject: Re: git-diff new files (without using index)
Date: Sun, 05 Aug 2007 13:37:19 +0900
Message-ID: <87abt6lhq8.fsf@catnip.gol.com>
References: <87wswalkad.fsf@catnip.gol.com>
	<20070805035245.GE9527@spearce.org> <87r6miljfr.fsf@catnip.gol.com>
	<20070805040841.GG9527@spearce.org>
	<7vd4y2ipd0.fsf@assigned-by-dhcp.cox.net>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 05 06:37:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHXrX-0001kE-It
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 06:37:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751349AbXHEEhE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 00:37:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751535AbXHEEhE
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 00:37:04 -0400
Received: from smtp02.dentaku.gol.com ([203.216.5.72]:39517 "EHLO
	smtp02.dentaku.gol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750914AbXHEEhD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2007 00:37:03 -0400
Received: from 203-216-96-074.dsl.gol.ne.jp ([203.216.96.74] helo=catnip.gol.com)
	by smtp02.dentaku.gol.com with esmtpa (Dentaku)
	id 1IHXrQ-00045P-LD; Sun, 05 Aug 2007 13:37:00 +0900
Received: by catnip.gol.com (Postfix, from userid 1000)
	id D3195300F; Sun,  5 Aug 2007 13:37:19 +0900 (JST)
System-Type: i686-pc-linux-gnu
In-Reply-To: <7vd4y2ipd0.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Sat\, 04 Aug 2007 21\:20\:43 -0700")
X-Abuse-Complaints: abuse@gol.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54941>

Junio C Hamano <gitster@pobox.com> writes:
> I suspect that it's probably half superstition and half disease
> to wish for "diff /dev/null new-file".

Er, please, a bit of consideration.  It's not superstition, it's not a disease.

I _want to use the index_:  I want to stage changes, and then make more
changes, and just generally be able to treat these three states (HEAD,
indexed, non-indexed) as points which can be used as inputs to git-diff
-- and I want _applyable patch files_ as the output from git-diff, not
pretty diffs for browsing.

Thanks,

-Miles

-- 
Any man who is a triangle, has thee right, when in Cartesian Space, to
have angles, which when summed, come to know more, nor no less, than
nine score degrees, should he so wish.  [TEMPLE OV THEE LEMUR]
