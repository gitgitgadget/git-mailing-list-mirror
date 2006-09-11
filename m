From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Change set based shallow clone
Date: Mon, 11 Sep 2006 13:52:30 -0400
Message-ID: <20060911175230.GA7213@spearce.org>
References: <Pine.LNX.4.64.0609081600530.27779@g5.osdl.org> <9e4733910609081628w2a59551foc28c689d0538a984@mail.gmail.com> <17668.2019.732961.855446@cargo.ozlabs.ibm.com> <20060911000306.GA28927@spearce.org> <7vfyezqlny.fsf@assigned-by-dhcp.cox.net> <ee2cms$o18$1@sea.gmane.org> <20060911024434.GA29368@spearce.org> <7vac57nfb5.fsf@assigned-by-dhcp.cox.net> <20060911060820.GB29368@spearce.org> <7vr6yikhdj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 11 19:52:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GMpxe-0004W4-Kc
	for gcvg-git@gmane.org; Mon, 11 Sep 2006 19:52:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751314AbWIKRwf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Sep 2006 13:52:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751328AbWIKRwf
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Sep 2006 13:52:35 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:58839 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751314AbWIKRwe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Sep 2006 13:52:34 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GMpxJ-0003Re-5S; Mon, 11 Sep 2006 13:52:25 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id A4E4920E49A; Mon, 11 Sep 2006 13:52:30 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vr6yikhdj.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26855>

Junio C Hamano <junkio@cox.net> wrote:
> As you know I've shelved the 64-bit offset stuff.  My preference
> is to base it on 106d710b but basing it on 'next' would be fine.
> Between 106d710b and next there is only one unrelated change to
> sha1_file.c, which is the hexval[] change that is in 'master'.

OK.  I'll rebase on 106d710b and try to get the series out in a day
or two.
 
> So far I liked the per-object-type dictionary conjecture the
> most, primarily because my gut feeling tells me that it would
> involve the least amount of hassle in the interoperability area.

Agreed, except I don't think its going to save us very much (~4%)
and its enough of a change still to make things a little ugly.
If the "true" dictionary compression idea has any value it may
save us even more and make it easier to implement fast full text
searching across files.  But its definately more complex.  So I'm
going to shut up now.
 
> But honestly speaking I am not looking forward to a packfile
> format update at this moment.  I'd like things to settle down a
> bit now, after merging good bits from 'next' to 'master' and
> declare 1.4.3 first, perhaps by the end of the month.

No worry there.  I won't have enough time between now and the end
of this month to create a dictionary pack that's even ready for pu,
let alone next.  I hope we see 1.4.3 before then.  :-)

-- 
Shawn.
