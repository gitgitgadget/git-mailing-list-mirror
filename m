From: Miles Bader <miles@gnu.org>
Subject: Re: [PATCH RFC] rebase: add --revisions flag
Date: Wed, 09 Dec 2009 13:51:41 +0900
Message-ID: <buoy6lclpgi.fsf@dhlpc061.dev.necel.com>
References: <20091208144740.GA30830@redhat.com>
	<20091208160822.GA1299@atjola.homenet>
	<20091208161406.GB32045@redhat.com>
	<20091208163737.GA2005@atjola.homenet>
	<20091208164449.GA32204@redhat.com>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Wed Dec 09 05:52:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIEX9-0006Xe-6x
	for gcvg-git-2@lo.gmane.org; Wed, 09 Dec 2009 05:52:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756915AbZLIEwE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Dec 2009 23:52:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755803AbZLIEwC
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Dec 2009 23:52:02 -0500
Received: from TYO201.gate.nec.co.jp ([202.32.8.193]:65062 "EHLO
	tyo201.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755972AbZLIEwB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Dec 2009 23:52:01 -0500
Received: from relay11.aps.necel.com ([10.29.19.46])
	by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id nB94pgtt002957;
	Wed, 9 Dec 2009 13:51:42 +0900 (JST)
Received: from relay11.aps.necel.com ([10.29.19.24] [10.29.19.24]) by relay11.aps.necel.com with ESMTP; Wed, 9 Dec 2009 13:51:42 +0900
Received: from dhlpc061 ([10.114.114.39] [10.114.114.39]) by relay11.aps.necel.com with ESMTP; Wed, 9 Dec 2009 13:51:41 +0900
Received: by dhlpc061 (Postfix, from userid 31295)
	id AC2E352E1FC; Wed,  9 Dec 2009 13:51:41 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
Blat: Foop
In-Reply-To: <20091208164449.GA32204@redhat.com> (Michael S. Tsirkin's message
	of "Tue, 8 Dec 2009 18:44:49 +0200")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134935>

"Michael S. Tsirkin" <mst@redhat.com> writes:
> OTOH, rebase --revisions as I implemented is a "smarter cherry-pick" which
> can't easily be achieved with existing commands, especially if you add
> "-i".

It also allows making use of rebase's rather extensive machinery for
dealing with conflicts (e.g., rebase --continue / --skip / --abort).

But it would make more sense to have it in cherry-pick...
(cherry-pick --continue / --skip / --abort...)

-Miles

-- 
Consult, v.i. To seek another's disapproval of a course already decided on.
