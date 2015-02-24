From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 1/2] clone: add disassociate alias to dissociate option
Date: Tue, 24 Feb 2015 23:00:34 +0100
Message-ID: <54ECF482.3010303@alum.mit.edu>
References: <1424459423-11727-1-git-send-email-mattwhiteley@gmail.com>	<1424459423-11727-2-git-send-email-mattwhiteley@gmail.com>	<20150221062754.GC29665@peff.net>	<xmqqzj87wxck.fsf@gitster.dls.corp.google.com>	<20150221073509.GA32548@peff.net>	<xmqqvbitx0eh.fsf@gitster.dls.corp.google.com>	<54EC3EF8.7040302@alum.mit.edu> <xmqqbnkjqdko.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: Jeff King <peff@peff.net>, Matt Whiteley <mattwhiteley@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 24 23:00:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQNX5-0004ws-DX
	for gcvg-git-2@plane.gmane.org; Tue, 24 Feb 2015 23:00:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752897AbbBXWAn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2015 17:00:43 -0500
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:44034 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751973AbbBXWAm (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Feb 2015 17:00:42 -0500
X-AuditID: 1207440d-f79976d000005643-65-54ecf4848ef9
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id EE.23.22083.484FCE45; Tue, 24 Feb 2015 17:00:36 -0500 (EST)
Received: from [192.168.69.130] (p5DDB21CD.dip0.t-ipconnect.de [93.219.33.205])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t1OM0Ykp030476
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 24 Feb 2015 17:00:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.4.0
In-Reply-To: <xmqqbnkjqdko.fsf@gitster.dls.corp.google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDKsWRmVeSWpSXmKPExsUixO6iqNvy5U2IwbE75hZdV7qZLBp6rzBb
	vDy+mNXiR0sPswOLx85Zd9k9nvXuYfS4eEnZ4/MmuQCWKG6bpMSSsuDM9Dx9uwTujHPLTzAV
	/OKs2DbxHGsDYyNHFyMnh4SAicTRc9NZIWwxiQv31rN1MXJxCAlcZpTouPaQGcI5zyTR9God
	C0gVr4C2xNGPC5hAbBYBVYkv334wgthsAroSi3qaweKiAkESh04/hqoXlDg58wmYLSKgJjGx
	7RCYzSyQLNE++yBYvbCAt0TniYXsEMs+MUk8mfEY7CROAWuJaXfvMUI06EnsuP6LFcKWl2je
	Opt5AqPALCQ7ZiEpm4WkbAEj8ypGucSc0lzd3MTMnOLUZN3i5MS8vNQiXSO93MwSvdSU0k2M
	kJDm3cH4f53MIUYBDkYlHt4DMm9ChFgTy4orcw8xSnIwKYnyut4ACvEl5adUZiQWZ8QXleak
	Fh9ilOBgVhLh/fMRKMebklhZlVqUD5OS5mBREudVW6LuJySQnliSmp2aWpBaBJOV4eBQkuA1
	/wzUKFiUmp5akZaZU4KQZuLgBBnOJSVSnJqXklqUWFqSEQ+K1vhiYLyCpHiA9s4GaectLkjM
	BYpCtJ5iVJQS500HSQiAJDJK8+DGwhLVK0ZxoC+FefVAqniASQ6u+xXQYCagwXsevwIZXJKI
	kJJqYOyMENF6buInr6/Zmmb4ZvELn+PlV0IcXB/V1h27f2COzt62a7Ps/P/8nT1XjUN7Xwhr
	nHXx09QT1suDK99dfXRturrGwdhNNe+Dfh64eOJ12PLNW6c0nqtpnpHQt1f0WGTx 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264352>

On 02/24/2015 09:06 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
>> By the way, once we have stopped thinking about this feature as
>> "--reference" and then "--dissociate", it becomes obvious that a nice
>> generalization would be to allow *any* repository (including remote
>> ones) to serve as the object donor.
> 
> As I do not think of a workable approach to implement such a
> mechanism, I'd refrain from being irresponsible and say "Yeah,
> that's a neat idea", which would make me sound like clueless "me
> too, why doesn't Git do that?" crowd.

I think this would be done by effectively creating a clone of the nearby
repository then a fetch of the distant one, with some reference
shuffling between the steps. If the nearby repository contains far more
objects than the user really wants, then the initial clone will be
wasteful. But since the use case will probably be that the nearby
repository is (1) a mirror of the distant repo, and (depending on how
old it is) contains approximately a subset of the objects in the distant
repository, and (2) much faster to work with than the distant repo, I
think even this crude approach would often be a win.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
