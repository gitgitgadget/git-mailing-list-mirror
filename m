From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v8 00/10] refs backend pre-vtable
Date: Fri, 20 Nov 2015 07:34:29 +0100
Message-ID: <2052F710-EEFB-4A62-B8E2-AD19E4CE75E4@alum.mit.edu>
References: <cover.1447154711.git.mhagger@alum.mit.edu> <1447699868.5082.0.camel@twopensource.com> <20151119145848.GA11484@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Lukas Fleischer <lfleischer@lfos.de>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>, David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Nov 20 07:35:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZzfHd-0000kV-6J
	for gcvg-git-2@plane.gmane.org; Fri, 20 Nov 2015 07:35:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934781AbbKTGer (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Nov 2015 01:34:47 -0500
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:55039 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759376AbbKTGeq (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Nov 2015 01:34:46 -0500
X-AuditID: 12074414-f794f6d000007852-12-564ebefd035b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 59.3C.30802.DFEBE465; Fri, 20 Nov 2015 01:34:37 -0500 (EST)
Received: from michael-htc-one.fritz.box (p4FC96582.dip0.t-ipconnect.de [79.201.101.130])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id tAK6YVZP032636
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 20 Nov 2015 01:34:33 -0500
User-Agent: K-9 Mail for Android
In-Reply-To: <20151119145848.GA11484@sigill.intra.peff.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCKsWRmVeSWpSXmKPExsUixO6iqPt3n1+YwY4WLov5m04wWnRd6Way
	aOi9wmwxacpNJosfLT3MFjOvWlv09n1idWD32DnrLrvH2YOZHs969zB6XLyk7LF/6TY2jwXP
	77N7fN4kF8AexW2TlFhSFpyZnqdvl8Cd8WPpG/aCWSwVv07VNDCuYe5i5OSQEDCRuPT6MjuE
	LSZx4d56ti5GLg4hgcuMEi39D5kgnJtMEp39U8E6RAUUJOZNnsgIYnMKWEv8ffKNGaJoIqPE
	sV+nWEASvAKCEidnPgGzmQXkJZq3zmaGsDUlrh3fArZOWMBU4tX8FWA1bAK6Eot6mplAbBYB
	VYlF3/+D2SICbhInLr5gBFnALHCaUaJz1QVWiAX2EnsP7GeawCgwC8m+WUj2zUKybwEj8ypG
	ucSc0lzd3MTMnOLUZN3i5MS8vNQiXQu93MwSvdSU0k2MkFgQ2cF45KTcIUYBDkYlHt4Gcb8w
	IdbEsuLK3EOMkhxMSqK85puAQnxJ+SmVGYnFGfFFpTmpxYcYJTiYlUR4l/oB5XhTEiurUovy
	YVLSHCxK4rzfFqv7CQmkJ5akZqemFqQWwWRlODiUJHi5gTEvJFiUmp5akZaZU4KQZuLgBBnO
	JSVSnJqXklqUWFqSEQ+K1vhiYLyCpHiA9i7aC7K3uCAxFygK0XqKUZdjwY/ba5mEWPLy81Kl
	xHnTQIoEQIoySvPgVsAS3ytGcaCPhXkPglTxAJMm3KRXQEuYgJb8rvEFWVKSiJCSamA0qDFU
	WnQ3Vq/f0tBAbsVU7vTalH2KM5nb/m2Ywv8qg2niZUOhaZvyDuQt0naPj7n7zEt/ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281498>

On November 19, 2015 3:58:48 PM GMT+01:00, Jeff King <peff@peff.net> wrote:
> [...]
>Thanks. Looks like patch 7 didn't make it to the list due to its size.
>I picked it up from Michael's GitHub fork.

Oh, thanks. I hadn't noticed the problem.

>Just so I'm sure, this is replacing all of what Junio had queued in
>dt/refs-backend-pre-vtable, right?

That is correct.

Michael

Sent from a cellphone. Sorry for any screwed-up formatting. See below.
-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
