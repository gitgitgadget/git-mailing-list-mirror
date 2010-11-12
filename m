From: Miles Bader <miles@gnu.org>
Subject: Re: [PATCH 1/2] [RFC] Use --find- instead of --detect- as prefix for long forms of -M and -C.
Date: Fri, 12 Nov 2010 12:56:11 +0900
Message-ID: <buomxpfry90.fsf@dhlpc061.dev.necel.com>
References: <1289420833-20602-1-git-send-email-ydirson@altern.org>
	<1289420833-20602-2-git-send-email-ydirson@altern.org>
	<7884E3F5-D622-49E2-BEBE-12936F388C30@sb.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Yann Dirson <ydirson@altern.org>, git@vger.kernel.org
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Fri Nov 12 04:57:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGklh-0004sJ-Tk
	for gcvg-git-2@lo.gmane.org; Fri, 12 Nov 2010 04:57:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753733Ab0KLD4d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Nov 2010 22:56:33 -0500
Received: from TYO202.gate.nec.co.jp ([202.32.8.206]:43840 "EHLO
	tyo202.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753360Ab0KLD4d (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Nov 2010 22:56:33 -0500
Received: from mailgate3.nec.co.jp ([10.7.69.192])
	by tyo202.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id oAC3uD1i015146;
	Fri, 12 Nov 2010 12:56:13 +0900 (JST)
Received: (from root@localhost) by mailgate3.nec.co.jp (8.11.7/3.7W-MAILGATE-NEC)
	id oAC3uCL23170; Fri, 12 Nov 2010 12:56:12 +0900 (JST)
Received: from relay41.aps.necel.com ([10.29.19.9])
	by vgate01.nec.co.jp (8.14.4/8.14.4) with ESMTP id oAC3bk3D009314;
	Fri, 12 Nov 2010 12:56:12 +0900 (JST)
Received: from relay41.aps.necel.com ([10.29.19.24] [10.29.19.24]) by relay41.aps.necel.com with ESMTP; Fri, 12 Nov 2010 12:56:12 +0900
Received: from dhlpc061 ([10.114.96.110] [10.114.96.110]) by relay41.aps.necel.com with ESMTP; Fri, 12 Nov 2010 12:56:12 +0900
Received: by dhlpc061 (Postfix, from userid 31295)
	id 2F4DA52E1F9; Fri, 12 Nov 2010 12:56:12 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
Blat: Foop
In-Reply-To: <7884E3F5-D622-49E2-BEBE-12936F388C30@sb.org> (Kevin Ballard's
	message of "Thu, 11 Nov 2010 19:00:05 -0800")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161319>

Kevin Ballard <kevin@sb.org> writes:
> I'm not sure I like the wording --find-copies and --find-renames. Maybe I'm
> just being silly, but it sounds like those are directives, saying "I want you
> to find copies/renames", as opposed to just saying "while you're working you
> should also detect copies/renames". The original flag --find-copies-harder
> is a bit different, because it's modifying the action of finding copies
> rather than making finding copies the prime directive.
>
> On the other hand, --detect-copies and --detect-renames sounds to me like
> you're just telling it that it should, well, detect copies/renames as it goes
> about its business.

I agree.  The current names are better than the proposed names.

[For the reasons you state.]

-Miles

-- 
The automobile has not merely taken over the street, it has dissolved the
living tissue of the city.  Its appetite for space is absolutely insatiable;
moving and parked, it devours urban land, leaving the buildings as mere
islands of habitable space in a sea of dangerous and ugly traffic.
[James Marston Fitch, New York Times, 1 May 1960]
