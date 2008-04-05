From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: [PATCH] merge, pull: introduce '--diffstat' option
Date: Sat, 5 Apr 2008 18:35:53 +0300
Message-ID: <200804051835.54097.tlikonen@iki.fi>
References: <20080403103056.GD6673@coredump.intra.peff.net> <1207406935-22144-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: SZEDER =?utf-8?q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 05 17:36:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JiARf-0004V7-Ie
	for gcvg-git-2@gmane.org; Sat, 05 Apr 2008 17:36:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752294AbYDEPf7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 Apr 2008 11:35:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752326AbYDEPf7
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Apr 2008 11:35:59 -0400
Received: from pne-smtpout4-sn2.hy.skanova.net ([81.228.8.154]:56911 "EHLO
	pne-smtpout4-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752294AbYDEPf6 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Apr 2008 11:35:58 -0400
Received: from [192.168.0.2] (80.220.180.181) by pne-smtpout4-sn2.hy.skanova.net (7.3.129)
        id 478BE6630048947E; Sat, 5 Apr 2008 17:35:57 +0200
User-Agent: KMail/1.9.5
In-Reply-To: <1207406935-22144-1-git-send-email-szeder@ira.uka.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78848>

SZEDER G=C3=A1bor kirjoitti:

> At present, the 'merge --summary' command line option and
> 'merge.diffstat' config variable are controlling the same thing:
> whether to show a diffstat at the end of the merge or not.  This is
> inconsistent and confusing.

> But there is still a conflict between the 'merge.summary' config
> variable and the now not advertised '--summary' option, that should
> be resolved.

I very much agree with you: --summary/--no-summary are logical and=20
intuitive equivalents of merge.summary, as are --diffstat/--no-diffstat=
=20
to merge.diffstat.

How about this: Officially and explicitly deprecate --(no-)summary and=20
advertise --(no-)diffstat as replacement. Also advertise that in some=20
future release --(no-)summary will have different meaning (i.e.=20
equivalent to merge.summary). There would be a reasonable (?) period=20
before changing the meaning of --(no-)summary.

This is a bit hassle but I think in long term this would be a gain for=20
Git's user interface. I believe these are not the kind of options that=20
many scripts vitally depend on, so the change would be pretty safe I=20
think.
