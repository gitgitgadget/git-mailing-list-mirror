From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [RFC/PATCH 0/2] Commits with ancient timestamps
Date: Fri, 3 Feb 2012 11:44:09 +0100
Message-ID: <87mx90yz5y.fsf@thomas.inf.ethz.ch>
References: <1328218903-5681-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 03 11:44:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtGcr-0006Ju-HU
	for gcvg-git-2@plane.gmane.org; Fri, 03 Feb 2012 11:44:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755914Ab2BCKoN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Feb 2012 05:44:13 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:35740 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755906Ab2BCKoM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Feb 2012 05:44:12 -0500
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Fri, 3 Feb
 2012 11:44:07 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.1.355.2; Fri, 3 Feb
 2012 11:44:09 +0100
In-Reply-To: <1328218903-5681-1-git-send-email-gitster@pobox.com> (Junio
	C. Hamano's message of "Thu, 2 Feb 2012 13:41:41 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189748>

Junio C Hamano <gitster@pobox.com> writes:

> avoid misinterpreting human-written timestamp in other formats, and
> timestamps before 1975 do not have enough number of digits in them.
>
> Here is a two-patch series that may improve the situation.

Doing this just makes me wonder how important exactly the 1970-1975
range is.  Is there a notable software history from that era that can be
recovered?

(Your [1/2] does not seem to parse negative offsets from the unix epoch,
so anything before 1970 is still out.)

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
