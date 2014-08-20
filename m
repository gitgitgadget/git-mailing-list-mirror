From: Nico Williams <nico@cryptonector.com>
Subject: Re: [PATCH 00/18] Signed push
Date: Wed, 20 Aug 2014 01:28:39 -0500
Message-ID: <CAK3OfOjVfaRwcuqRd6VQ1T7HkHUd9Oe1raxSa1zz5PrKuWWBmA@mail.gmail.com>
References: <1408485987-3590-1-git-send-email-gitster@pobox.com>
	<CAPc5daXKwW-T6PeYtFYdHYuBzvsDXWyYdNOYXXG867KGgHMKwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 20 08:28:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJzO4-0000bq-Kg
	for gcvg-git-2@plane.gmane.org; Wed, 20 Aug 2014 08:28:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752088AbaHTG2n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2014 02:28:43 -0400
Received: from sub4.mail.dreamhost.com ([69.163.253.135]:35661 "EHLO
	homiemail-a70.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751923AbaHTG2m (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Aug 2014 02:28:42 -0400
Received: from homiemail-a70.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a70.g.dreamhost.com (Postfix) with ESMTP id A3BB376805C
	for <git@vger.kernel.org>; Tue, 19 Aug 2014 23:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=cryptonector.com; h=
	mime-version:in-reply-to:references:date:message-id:subject:from
	:to:cc:content-type; s=cryptonector.com; bh=cuQKpOeLcquPFH3M7S/e
	C2eys5s=; b=eIYHnGPl4amxP6pSLIsq69uGWw9mkh3Ail13FFvUlUQU87V3zh0y
	mnlAeOCLEdn8S1cwMVfaxHHVruJyhjTeuc+VgaTfVzWs2A6N1ExpPBEREb8Eti4O
	oB2MV79bLfoKu+jCsy5iiv05Ptqr9NQ0XH9hbRxQRoT7ZjCW1T7TbsA=
Received: from mail-we0-f178.google.com (mail-we0-f178.google.com [74.125.82.178])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: nico@cryptonector.com)
	by homiemail-a70.g.dreamhost.com (Postfix) with ESMTPSA id 56120768059
	for <git@vger.kernel.org>; Tue, 19 Aug 2014 23:28:41 -0700 (PDT)
Received: by mail-we0-f178.google.com with SMTP id w61so7459555wes.37
        for <git@vger.kernel.org>; Tue, 19 Aug 2014 23:28:40 -0700 (PDT)
X-Received: by 10.180.37.241 with SMTP id b17mr12310535wik.70.1408516120205;
 Tue, 19 Aug 2014 23:28:40 -0700 (PDT)
Received: by 10.216.231.131 with HTTP; Tue, 19 Aug 2014 23:28:39 -0700 (PDT)
In-Reply-To: <CAPc5daXKwW-T6PeYtFYdHYuBzvsDXWyYdNOYXXG867KGgHMKwA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255553>

No code == no substance might be a stretch, but definitely fair enough.

I thought the idea was clear enough, but I can flesh it out if
desired.  The particular advantage I saw in it is that it would reuse
the existing object infrastructure, and extend to branches the
first-class treatment that [signed] tags already get.  I.e.,
generality.  Other benefits include the ability to fetch and view a
remote branch's object and its history (which would represent branch
history in detail and with metadata that would otherwise not be
available).

I'm not interested in pushing something different when you already
have code that would achieve much of what I'd wanted.  At this point
my interest is in seeing if the architecture would be "purer" (in some
sense) by reusing existing infrastructure.

Nico
--
