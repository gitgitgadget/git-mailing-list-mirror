From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH v2] rev-list docs: clarify --topo-order description
Date: Thu, 16 Aug 2012 10:51:10 +0200
Message-ID: <87pq6rw77l.fsf@thomas.inf.ethz.ch>
References: <7vsjbqbfhm.fsf@alter.siamese.dyndns.org>
	<877gt16ewe.fsf@thomas.inf.ethz.ch>
	<7vzk5x8s1q.fsf@alter.siamese.dyndns.org>
	<87sjbpa5m8.fsf@thomas.inf.ethz.ch>
	<7vmx1v53fb.fsf_-_@alter.siamese.dyndns.org>
	<CAOeW2eFZNuM_8bFB2cXGVRT0FpDC86fH=XMj9kviXs-UCo1fAA@mail.gmail.com>
	<7vipcj2w9f.fsf@alter.siamese.dyndns.org>
	<7vehn72vyl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	<git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 16 10:51:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1vnY-0005fn-8g
	for gcvg-git-2@plane.gmane.org; Thu, 16 Aug 2012 10:51:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756598Ab2HPIvP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Aug 2012 04:51:15 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:9738 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756512Ab2HPIvN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2012 04:51:13 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 16 Aug
 2012 10:51:10 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 16 Aug
 2012 10:51:10 +0200
In-Reply-To: <7vehn72vyl.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 15 Aug 2012 23:26:58 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> We could remove it if you find it confusing.
>>
>> I think the original motivation that line was added was to help
>> people who see "git log" (without any frills) output for the first
>> time not to be alarmed when they see newer things first: "In
>> general, the "time" flows from bottom to top", but the "time" in
>> that sentence is not necessarily the timestamp of either committer
>> nor author field.
>
> Just to clarify, I am not defending the current wording that I did
> not touch in my patch with the above.  I am just giving historical
> background to help _other_ people (including you) to come up with a
> better wording, as I do not think of a better replacement myself.

I tend to agree with Martin, the existing header for the list

>>>  By default, the commits are shown in reverse chronological order.

is misleading.  I suppose the real problem is that the "true" ordering
is completely obvious as the one ordering that does not require
preprocessing, but ugly to specify in words.  Perhaps we can bikeshed a
little?  How about

  By default, commits are shown in an order that coincides with
  `--date-order` on well-behaved history, but is faster to compute.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
