From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v3 2/6] notes: replace pseudorefs with real refs
Date: Wed, 29 Jul 2015 02:56:29 +0200
Message-ID: <55B824BD.8000003@alum.mit.edu>
References: <1438107144-24293-1-git-send-email-dturner@twopensource.com>	<1438107144-24293-3-git-send-email-dturner@twopensource.com>	<xmqqpp3cds44.fsf@gitster.dls.corp.google.com>	<xmqqegjsdq3n.fsf@gitster.dls.corp.google.com>	<CALKQrgdLC_sLkM3jyH6pnDoY+RTHr9wJR_VH6iirBWmvyHYcVA@mail.gmail.com>	<xmqqpp3bc2u6.fsf@gitster.dls.corp.google.com>	<CALKQrgfxc83-yjrCWZqC+pyPhbQDgYbrpCDSaBk78YypO=BXOg@mail.gmail.com> <xmqqlhdzby5o.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: David Turner <dturner@twopensource.com>,
	Git mailing list <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Philip Oakley <philipoakley@iee.org>
To: Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Jul 29 02:56:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKFfr-0007VQ-UW
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jul 2015 02:56:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752117AbbG2A4o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 20:56:44 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:49500 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751232AbbG2A4n (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Jul 2015 20:56:43 -0400
X-AuditID: 1207440c-f79e16d000002a6e-fb-55b824c17349
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id BF.AA.10862.1C428B55; Tue, 28 Jul 2015 20:56:33 -0400 (EDT)
Received: from [192.168.69.130] (p4FC97EE8.dip0.t-ipconnect.de [79.201.126.232])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t6T0uUpr032453
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 28 Jul 2015 20:56:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.7.0
In-Reply-To: <xmqqlhdzby5o.fsf@gitster.dls.corp.google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGKsWRmVeSWpSXmKPExsUixO6iqHtQZUeowbYbihbzN51gtOi60s1k
	0dB7hdli3t1dTBadU2UtzrxpZHRg87j08jubx/Kl6xg9Ll5S9lj8wMtjwfP77B6fN8kFsEVx
	2yQllpQFZ6bn6dslcGecXzubpeAna8WeSa9YGxgfsHQxcnJICJhIfLqwlg3CFpO4cG89mC0k
	cJlR4uEpzy5GLiD7ApPEhePPGUESvALaEt8WrWYCsVkEVCXerj8AFmcT0JVY1NMMFOfgEBUI
	knj9MheiXFDi5MwnYLtEBDwlbh9qBmtlFtjLKHFzplUXIzuHsICLxKpIiE2nmSXaHnSBlXAK
	WEtsnLCLHaJcT2LH9V+sELa8xPa3c5gnMArMQrJhFpKyWUjKFjAyr2KUS8wpzdXNTczMKU5N
	1i1OTszLSy3SNdTLzSzRS00p3cQICXeeHYzf1skcYhTgYFTi4Z2wbluoEGtiWXFl7iFGSQ4m
	JVHej8I7QoX4kvJTKjMSizPii0pzUosPMUpwMCuJ8E78vz1UiDclsbIqtSgfJiXNwaIkzqu6
	RN1PSCA9sSQ1OzW1ILUIJivDwaEkwXtaGWioYFFqempFWmZOCUKaiYMTZDiXlEhxal5KalFi
	aUlGPChK44uBcQqS4gHa2wTSzltckJgLFIVoPcWoy7Hgx+21TEIsefl5qVLivAzA9CQkAFKU
	UZoHtwKW3F4xigN9LMy7GGQUDzAxwk16BbSECWiJZ88WkCUliQgpqQbGRQ92JcnbZ0VN/br+
	13SPxMfaBe8eOxk8OfmweLH5s79eLXG9rG+i1b6nbPw7Y8+bPxrq/2+Z/lpqMdHI 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274870>

Johan Herland <johan@herland.net> writes:
> Here is where we start to differ. I would say that starting a notes
> merge is completely unrelated to your worktree. Consider this:

It sounds like what a notes merge really wants is a new linked worktree
that has branch refs/notes/foo checked out:

* This would allow multiple notes merges to take place at the same time
provided they target different merge references.

* This would prevent multiple notes merges to the same notes reference
at the same time by the same mechanism that prevents the same branch
from being checked out in two linked worktrees at the same time.

It's just a thought; I have no idea whether it is practical...

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
