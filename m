From: thomas <trast@student.ethz.ch>
Subject: Re: [PATCH v2 2/3] Refactor parts of in_delta_base_cache/cache_or_unpack_entry
Date: Tue, 26 Mar 2013 12:09:59 +0100
Message-ID: <87y5da8liw.fsf@linux-k42r.v.cablecom.net>
References: <cover.1364234154.git.trast@student.ethz.ch>
	<987ab8138000d0aaa7d1bb6242cced1344e4d339.1364234154.git.trast@student.ethz.ch>
	<7vtxnzul42.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>, Stefan Zager <szager@google.com>,
	Jeff King <peff@peff.net>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 26 12:10:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKRly-0000a7-4E
	for gcvg-git-2@plane.gmane.org; Tue, 26 Mar 2013 12:10:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754614Ab3CZLKD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Mar 2013 07:10:03 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:47864 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753441Ab3CZLKC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Mar 2013 07:10:02 -0400
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 26 Mar
 2013 12:09:57 +0100
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.233) by
 CAS22.d.ethz.ch (172.31.51.112) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Tue, 26 Mar 2013 12:09:59 +0100
In-Reply-To: <7vtxnzul42.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 25 Mar 2013 16:15:41 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219157>

Junio C Hamano <gitster@pobox.com> writes:

> Thomas Rast <trast@student.ethz.ch> writes:
>
>> The delta base cache lookup and test were shared.  Refactor them;
>> we'll need both parts again.  Also, we'll use the clearing routine
>> later.
>>
>> Signed-off-by: Thomas Rast <trast@student.ethz.ch>
>> ---
>
> Looks like a very straight-forward rewrite.
>
> The only little concern I may have is this cmp_* function tells us
> "I found it!" by returning true, which is counter-intuitive to the
> readers of the caller (not the callee).
>
> I think it makes sense to compare delta-base-cache entries only for
> equality, so eq-delta-base-cache-entry might be a better name for
> it, perhaps?

True.  I'll resend.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
