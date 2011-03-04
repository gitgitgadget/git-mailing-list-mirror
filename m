From: Miles Bader <miles@gnu.org>
Subject: Re: [PATCH/RFC] init, clone: support --real-git-dir for .git file
Date: Fri, 04 Mar 2011 13:13:32 +0900
Message-ID: <buozkpb8qvn.fsf@dhlpc061.dev.necel.com>
References: <1299156201-12149-1-git-send-email-pclouds@gmail.com>
 <7v8vwv927a.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 04 05:13:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PvMOc-0005nX-Kd
	for gcvg-git-2@lo.gmane.org; Fri, 04 Mar 2011 05:13:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758523Ab1CDENg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Mar 2011 23:13:36 -0500
Received: from relmlor4.renesas.com ([210.160.252.174]:45745 "EHLO
	relmlor4.renesas.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758465Ab1CDENg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Mar 2011 23:13:36 -0500
Received: from relmlir3.idc.renesas.com ([10.200.68.153])
 by relmlor4.idc.renesas.com ( SJSMS)
 with ESMTP id <0LHI00AI7MEMXW60@relmlor4.idc.renesas.com> for
 git@vger.kernel.org; Fri, 04 Mar 2011 13:13:34 +0900 (JST)
Received: from relmlac2.idc.renesas.com ([10.200.69.22])
 by relmlir3.idc.renesas.com ( SJSMS)
 with ESMTP id <0LHI00H88MEMK060@relmlir3.idc.renesas.com> for
 git@vger.kernel.org; Fri, 04 Mar 2011 13:13:34 +0900 (JST)
Received: by relmlac2.idc.renesas.com (Postfix, from userid 0)
	id 4A50D28076; Fri, 04 Mar 2011 13:13:34 +0900 (JST)
Received: from relmlac2.idc.renesas.com (localhost [127.0.0.1])
	by relmlac2.idc.renesas.com (Postfix) with ESMTP id 3DED528070; Fri,
 04 Mar 2011 13:13:34 +0900 (JST)
Received: from relmlii2.idc.renesas.com [10.200.68.66]	by
 relmlac2.idc.renesas.com with ESMTP id PAK13972; Fri,
 04 Mar 2011 13:13:34 +0900
X-IronPort-AV: E=Sophos;i="4.62,262,1297004400";   d="scan'208";a="14851443"
Received: from unknown (HELO relay11.aps.necel.com) ([10.29.19.46])
 by relmlii2.idc.renesas.com with ESMTP; Fri, 04 Mar 2011 13:13:34 +0900
Received: from relay11.aps.necel.com ([10.29.19.46] [10.29.19.46])
 by relay11.aps.necel.com with ESMTP; Fri, 04 Mar 2011 13:13:34 +0900
Received: from dhlpc061 ([10.114.97.66] [10.114.97.66])
 by relay11.aps.necel.com with ESMTP; Fri, 04 Mar 2011 13:13:34 +0900
Received: by dhlpc061 (Postfix, from userid 31295)	id 658B652E1D6; Fri,
 04 Mar 2011 13:13:33 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
Blat: Foop
In-reply-to: <7v8vwv927a.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168424>

Junio C Hamano <gitster@pobox.com> writes:
>> Instead of creating the repository at $GIT_DIR, --real-git-dir will
>> tell git to put the repository there, then make $GIT_DIR a .git file
>> that points to --real-git-dir.
>
> Just like you, I am also bad at naming things, so I cannot offhand suggest
> a better name, even though I _know_ --real-git-dir sounds horrible.

--separate-git-dir  ?

[Terms like "separate source dir" and "separate build dir" seems to be
common when talking about build systems, and it seems a somewhat
similar situation -- separation of usually co-located information.]

-miles

-- 
It wasn't the Exxon Valdez captain's driving that caused the Alaskan oil spill.
It was yours.  [Greenpeace advertisement, New York Times, 25 February 1990]
