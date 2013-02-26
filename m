From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH] pkt-line: Fix sparse errors and warnings
Date: Tue, 26 Feb 2013 18:52:36 +0000
Message-ID: <512D0474.7040508@ramsay1.demon.co.uk>
References: <51290DF4.4040309@ramsay1.demon.co.uk> <20130223223134.GA2504@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 26 20:08:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UAPst-0004CI-MZ
	for gcvg-git-2@plane.gmane.org; Tue, 26 Feb 2013 20:08:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758700Ab3BZTHl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2013 14:07:41 -0500
Received: from mdfmta009.mxout.tbr.inty.net ([91.221.168.50]:46515 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758136Ab3BZTHj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2013 14:07:39 -0500
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id 5B6CF384084;
	Tue, 26 Feb 2013 19:07:37 +0000 (GMT)
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id B071E384081;	Tue, 26 Feb 2013 19:07:36 +0000 (GMT)
Received: from [193.237.126.196] (unknown [193.237.126.196])	by mdfmta009.tbr.inty.net (Postfix) with ESMTP;	Tue, 26 Feb 2013 19:07:35 +0000 (GMT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
In-Reply-To: <20130223223134.GA2504@sigill.intra.peff.net>
X-MDF-HostID: 4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217161>

Jeff King wrote:
> Thanks for the report. Clearly I should start running "make sparse" more
> often (the reason I don't is that it produces dozens of complaints about
> constants in /usr/include/bits/xopen_lim.h, which I could obviously care
> less about; I should look into suppressing that).

Hmm, I'm guessing you are on an 64bit system; if so, and you are running
the release version of sparse (v0.4.4 Nov 2011), I would clone the sparse
repo [1] and build from source. There have been many improvements to the
64bit support since the last release (I hear it was unusable). [Note: I
can't confirm that - I'm currently stuck on 32bits!]

ATB,
Ramsay Jones

[1] git://git.kernel.org/pub/scm/devel/sparse/sparse.git (which had been
dormant for quite some time, but sprang to life again last week).
