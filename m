From: =?UTF-8?B?IkphbiBILiBTY2jDtm5oZXJyIg==?= <schnhrr@cs.tu-berlin.de>
Subject: Re: [PATCH 0/5] Cure some format-patch wrapping and encoding issues
Date: Wed, 10 Oct 2012 12:49:44 +0200
Message-ID: <507552C8.2020402@cs.tu-berlin.de>
References: <1349717609-4770-1-git-send-email-schnhrr@cs.tu-berlin.de> <7vfw5nfoq9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 10 12:50:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLtrg-0007OH-Cq
	for gcvg-git-2@plane.gmane.org; Wed, 10 Oct 2012 12:50:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755501Ab2JJKuB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Oct 2012 06:50:01 -0400
Received: from mail.eecsit.tu-berlin.de ([130.149.17.13]:49154 "EHLO
	mail.cs.tu-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752509Ab2JJKuB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2012 06:50:01 -0400
Received: from localhost (localhost [127.0.0.1])
	by localhost-12225.cs.tu-berlin.de (Postfix) with ESMTP id 7DBE06E78
	for <git@vger.kernel.org>; Wed, 10 Oct 2012 12:49:59 +0200 (CEST)
X-Virus-Scanned: amavisd-new at cs.tu-berlin.de (including SpamAssassin)
Received: from mailhost.cs.tu-berlin.de ([127.0.0.1])
	by localhost (mail.cs.tu-berlin.de [127.0.0.1]) (amavisd-new, port 12224)
	with ESMTP id TAyYH9IkmJtV 03732-03;
	Wed, 10 Oct 2012 12:49:49 +0200 (CEST) 13718
Received: from [130.149.91.59] (asahi.kbs.tu-berlin.de [130.149.91.59])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: schnhrr)
	by mailhost.cs.tu-berlin.de (Postfix) with ESMTPSA;
	Wed, 10 Oct 2012 12:49:49 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.7) Gecko/20120919 Thunderbird/10.0.7
In-Reply-To: <7vfw5nfoq9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207399>

Am 09.10.2012 21:07, schrieb Junio C Hamano:
> Jan H. Sch=C3=B6nherr <schnhrr@cs.tu-berlin.de> writes:
>=20
>> During the creation of this series, I came across the strbuf=20
>> wrapping functions, and I wonder if there is an off-by-one issue.
>>
>> Consider the following excerpt from t4202:
=2E..
>=20
> Yeah, that does sound like an off-by-one bug.  When we as end users
> say %w(72), we do expect some lines fill to the 72nd column, not
> stopping at the 71st.  I suspect that dates back to the very first
> implementation of %w() but I think we should fix it (perhaps as a
> separate patch either the earliest or the last in the series).

I will include a fix for that, then.

(But I won't be able the send out the next round of this series
before next week.)

Regards
Jan
