From: Miles Bader <miles@gnu.org>
Subject: Re: [PATCH/RFC] init, clone: support --real-git-dir for .git file
Date: Fri, 04 Mar 2011 15:57:04 +0900
Message-ID: <buoaahb8jb3.fsf@dhlpc061.dev.necel.com>
References: <1299156201-12149-1-git-send-email-pclouds@gmail.com>
 <7v8vwv927a.fsf@alter.siamese.dyndns.org>
 <AANLkTimG7Hg4YxJbMVaXVkZ1CRb0ttK6RAYEoRQ_4iW4@mail.gmail.com>
 <7v4o7j8lxg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 04 07:57:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PvOwp-0000A9-F3
	for gcvg-git-2@lo.gmane.org; Fri, 04 Mar 2011 07:57:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754878Ab1CDG5H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Mar 2011 01:57:07 -0500
Received: from relmlor3.renesas.com ([210.160.252.173]:64735 "EHLO
	relmlor3.renesas.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751421Ab1CDG5G (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Mar 2011 01:57:06 -0500
Received: from relmlir1.idc.renesas.com ([10.200.68.151])
 by relmlor3.idc.renesas.com ( SJSMS)
 with ESMTP id <0LHI00AWMTZ5XGE0@relmlor3.idc.renesas.com> for
 git@vger.kernel.org; Fri, 04 Mar 2011 15:57:05 +0900 (JST)
Received: from relmlac3.idc.renesas.com ([10.200.69.23])
 by relmlir1.idc.renesas.com (SJSMS)
 with ESMTP id <0LHI000JETZ46740@relmlir1.idc.renesas.com> for
 git@vger.kernel.org; Fri, 04 Mar 2011 15:57:05 +0900 (JST)
Received: by relmlac3.idc.renesas.com (Postfix, from userid 0)
	id F2A5E18077; Fri, 04 Mar 2011 15:57:04 +0900 (JST)
Received: from relmlac3.idc.renesas.com (localhost [127.0.0.1])
	by relmlac3.idc.renesas.com (Postfix) with ESMTP id F114318080; Fri,
 04 Mar 2011 15:57:04 +0900 (JST)
Received: from relmlii2.idc.renesas.com [10.200.68.66]	by
 relmlac3.idc.renesas.com with ESMTP id RAG22484; Fri,
 04 Mar 2011 15:57:04 +0900
X-IronPort-AV: E=Sophos;i="4.62,263,1297004400";   d="scan'208";a="14898397"
Received: from unknown (HELO relay11.aps.necel.com) ([10.29.19.46])
 by relmlii2.idc.renesas.com with ESMTP; Fri, 04 Mar 2011 15:57:04 +0900
Received: from relay11.aps.necel.com ([10.29.19.46] [10.29.19.46])
 by relay11.aps.necel.com with ESMTP; Fri, 04 Mar 2011 15:57:04 +0900
Received: from dhlpc061 ([10.114.97.66] [10.114.97.66])
 by relay11.aps.necel.com with ESMTP; Fri, 04 Mar 2011 15:57:04 +0900
Received: by dhlpc061 (Postfix, from userid 31295)	id B92A852E1D6; Fri,
 04 Mar 2011 15:57:04 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
Blat: Foop
In-reply-to: <7v4o7j8lxg.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168430>

Junio C Hamano <gitster@pobox.com> writes:
> You are only saying you want to move it, not saying why you want to move
> it.
>
> That is not an explanation _why_ it is useful to be able to do so.

Hmm, one scenario would be when you want to "manage" a work tree using a
relatively-passive tool that might barf over the contents (large, weird,
files...) of a .git dir.  E.g., eclipse or something (well I guess
eclipse might actually have direct git support these days, but you get
the idea).

-Miles

-- 
Politeness, n. The most acceptable hypocrisy.
