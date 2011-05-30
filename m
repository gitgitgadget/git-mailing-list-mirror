From: Miles Bader <miles@gnu.org>
Subject: Re: [PATCH] rebase: learn --discard subcommand
Date: Mon, 30 May 2011 14:01:31 +0900
Message-ID: <buolixokcic.fsf@dhlpc061.dev.necel.com>
References: <1306551495-26685-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <20110528230844.GA31498@elie>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Tim Mazid <timmazid@hotmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 30 07:02:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QQucZ-0006lc-JM
	for gcvg-git-2@lo.gmane.org; Mon, 30 May 2011 07:02:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751874Ab1E3FC0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 May 2011 01:02:26 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:44315 "EHLO
	relmlor2.renesas.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751359Ab1E3FC0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2011 01:02:26 -0400
Received: from relmlir4.idc.renesas.com ([10.200.68.154])
 by relmlor2.idc.renesas.com ( SJSMS)
 with ESMTP id <0LLZ00EHFSMK9U00@relmlor2.idc.renesas.com> for
 git@vger.kernel.org; Mon, 30 May 2011 14:01:32 +0900 (JST)
Received: from relmlac4.idc.renesas.com ([10.200.69.24])
 by relmlir4.idc.renesas.com ( SJSMS)
 with ESMTP id <0LLZ00C81SMK1V90@relmlir4.idc.renesas.com> for
 git@vger.kernel.org; Mon, 30 May 2011 14:01:32 +0900 (JST)
Received: by relmlac4.idc.renesas.com (Postfix, from userid 0)
	id 6899A4807B; Mon, 30 May 2011 14:01:32 +0900 (JST)
Received: from relmlac4.idc.renesas.com (localhost [127.0.0.1])
	by relmlac4.idc.renesas.com (Postfix) with ESMTP id 63FDB48070; Mon,
 30 May 2011 14:01:32 +0900 (JST)
Received: from relmlii1.idc.renesas.com [10.200.68.65]	by
 relmlac4.idc.renesas.com with ESMTP id QAG28343; Mon,
 30 May 2011 14:01:32 +0900
X-IronPort-AV: E=Sophos;i="4.65,290,1304262000";   d="scan'208";a="29280816"
Received: from unknown (HELO relay11.aps.necel.com) ([10.29.19.46])
 by relmlii1.idc.renesas.com with ESMTP; Mon, 30 May 2011 14:01:32 +0900
Received: from relay11.aps.necel.com ([10.29.19.46] [10.29.19.46])
 by relay11.aps.necel.com with ESMTP; Mon, 30 May 2011 14:01:32 +0900
Received: from dhlpc061 ([10.114.96.12] [10.114.96.12])
 by relay11.aps.necel.com with ESMTP; Mon, 30 May 2011 14:01:32 +0900
Received: by dhlpc061 (Postfix, from userid 31295)	id EE93F52E1EF; Mon,
 30 May 2011 14:01:31 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
Blat: Foop
In-reply-to: <20110528230844.GA31498@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174720>

Jonathan Nieder <jrnieder@gmail.com> writes:
> Agh, "git rebase --abort --keep-head" feels a little too long to be
> memorable.  Still, hope that helps.

"--abort --stay"...?

-miles

-- 
Cat, n. A soft, indestructible automaton provided by nature to be kicked when
things go wrong in the domestic circle.
