From: Miles Bader <miles@gnu.org>
Subject: Re: [PATCH 12/13] revert: Introduce skip-all to cleanup sequencer data
Date: Mon, 04 Jul 2011 13:59:58 +0900
Message-ID: <buowrfy8wtt.fsf@dhlpc061.dev.necel.com>
References: <1308661489-20080-1-git-send-email-artagnon@gmail.com>
 <1308661489-20080-13-git-send-email-artagnon@gmail.com>
 <7vtybj6ji2.fsf@alter.siamese.dyndns.org>
 <BANLkTimy17b-F7eg+R9ReRUrx0rhA1cumg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 04 07:00:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QdbGR-0002F8-Lf
	for gcvg-git-2@lo.gmane.org; Mon, 04 Jul 2011 07:00:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751270Ab1GDFAB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jul 2011 01:00:01 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:61009 "EHLO
	relmlor2.renesas.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751286Ab1GDFAA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jul 2011 01:00:00 -0400
Received: from relmlir3.idc.renesas.com ([10.200.68.153])
 by relmlor2.idc.renesas.com ( SJSMS)
 with ESMTP id <0LNS00H2VLVZKO60@relmlor2.idc.renesas.com> for
 git@vger.kernel.org; Mon, 04 Jul 2011 13:59:59 +0900 (JST)
Received: from relmlac1.idc.renesas.com ([10.200.69.21])
 by relmlir3.idc.renesas.com ( SJSMS)
 with ESMTP id <0LNS002PLLVZQPC0@relmlir3.idc.renesas.com> for
 git@vger.kernel.org; Mon, 04 Jul 2011 13:59:59 +0900 (JST)
Received: by relmlac1.idc.renesas.com (Postfix, from userid 0)
	id 5B9DB80088; Mon, 04 Jul 2011 13:59:59 +0900 (JST)
Received: from relmlac1.idc.renesas.com (localhost [127.0.0.1])
	by relmlac1.idc.renesas.com (Postfix) with ESMTP id 5626480086; Mon,
 04 Jul 2011 13:59:59 +0900 (JST)
Received: from relmlii2.idc.renesas.com [10.200.68.66]	by
 relmlac1.idc.renesas.com with ESMTP id PAP19165; Mon,
 04 Jul 2011 13:59:59 +0900
X-IronPort-AV: E=Sophos;i="4.65,470,1304262000";   d="scan'208";a="35102584"
Received: from unknown (HELO relay31.aps.necel.com) ([10.29.19.54])
 by relmlii2.idc.renesas.com with ESMTP; Mon, 04 Jul 2011 13:59:59 +0900
Received: from relay31.aps.necel.com ([10.29.19.54] [10.29.19.54])
 by relay31.aps.necel.com with ESMTP; Mon, 04 Jul 2011 13:59:59 +0900
Received: from dhlpc061 ([10.114.98.166] [10.114.98.166])
 by relay31.aps.necel.com with ESMTP; Mon, 04 Jul 2011 13:59:59 +0900
Received: by dhlpc061 (Postfix, from userid 31295)	id C6CEC52E1F3; Mon,
 04 Jul 2011 13:59:58 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
Blat: Foop
In-reply-to: <BANLkTimy17b-F7eg+R9ReRUrx0rhA1cumg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176590>

Ramkumar Ramachandra <artagnon@gmail.com> writes:
> Interesting side note: I'd initially wanted to use "skip_all" and
> "continue", but "continue" is a C keyword.  That's why I'd reluctantly
> suffixed "_oper" to both for consistency.

It seems a good idea to restrict such uglification to only those cases
where it's necessary, not make _everything_ ugly just for the sake of
consistency.....

[The traditional thing to do with C-keyword conflicts, when there's no
obvious and natural alternative, seems to just be intentional mispelling
-- "continu", "kontinue", "cont", "_continue", whatever.  Yes, they're
ugly, but people will know why you did it, and they'll forgive you.]

-Miles

-- 
Helpmate, n. A wife, or bitter half.
