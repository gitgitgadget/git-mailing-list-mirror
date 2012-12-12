From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: Re: Python extension commands in git - request for policy change
Date: Thu, 13 Dec 2012 09:21:55 +1100
Message-ID: <CAH5451nVqnS0UFBVDW5=Xmaj_6geiw7D7J4mR7922U+074W2qQ@mail.gmail.com>
References: <20121125024451.1ADD14065F@snark.thyrsus.com> <CAMP44s18MzmWRNRiRjL6hvpK1cm=S-97fB2ep-_0RAhnfs5cvA@mail.gmail.com>
 <50B1F684.5020805@alum.mit.edu> <CACsJy8BgOpWdxgCfwBwZ=abAEDr+sbj3hnmKY2EYCFeBPRUT7w@mail.gmail.com>
 <CACh33FrGPhaeNzZ2Tj5OxScecOPN13idw8TwU8Mf6o0KsAOB9A@mail.gmail.com>
 <CAMK1S_hy8U0rVY=-u-QCqXjhn-6jwz5ofj_q_mbokVn8CGCMtw@mail.gmail.com>
 <20121212033043.GA24937@thyrsus.com> <20121212063208.GA18322@sigill.intra.peff.net>
 <7vpq2f5ffu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, "Eric S. Raymond" <esr@thyrsus.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Patrick Donnelly <batrick@batbytes.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 12 23:22:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TiuhI-0004qJ-O1
	for gcvg-git-2@plane.gmane.org; Wed, 12 Dec 2012 23:22:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755575Ab2LLWWS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2012 17:22:18 -0500
Received: from mail-qa0-f53.google.com ([209.85.216.53]:48378 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754245Ab2LLWWR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2012 17:22:17 -0500
Received: by mail-qa0-f53.google.com with SMTP id a19so1937749qad.19
        for <git@vger.kernel.org>; Wed, 12 Dec 2012 14:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=5yUug4hufvU8g1f9wiyhF+Ya6JVsPBRMpAsYmcEXjys=;
        b=o9lDXJhavCgOgA7Th5m3RP/MzgPJbUZ7PmA0DXxN2roYxmtI/JGDACgfEDPjjZUVa2
         YE5pnKguPqnUdHp2BjUhM3pHlwnZxvIDrPXmMJlZiXDLQRntFXvyfDRRWjIJjMDdXAil
         KwL7F9LAWAv6rT122gCnKlcIwmNAKj/XyRX6LINUDIZu9CiVU9oBPH250govvuf7wLtZ
         /4j6i8H1nPOBRWypjkm/fA2U29s/q1g8t4Dpz9eIq3iXdJeumqGlzH6NmfPUQy5KCmz+
         Xrj6T0PAxoqqzO11iMdiC5S6H7r3T6wo1frnA4sLmRU8LDuuQ9RxmfVkKMzT5cZgaAkH
         wkOg==
Received: by 10.224.223.80 with SMTP id ij16mr89279qab.8.1355350936489; Wed,
 12 Dec 2012 14:22:16 -0800 (PST)
Received: by 10.49.14.3 with HTTP; Wed, 12 Dec 2012 14:21:55 -0800 (PST)
In-Reply-To: <7vpq2f5ffu.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211398>

On 13 December 2012 04:49, Junio C Hamano <gitster@pobox.com> wrote:
> "bisect" with "<used-to-be, now-is> vs
> <good, bad>" issue unsettled

Would you want to see this issue resolved in-script before a porting
attempt was started?

Regards,

Andrew Ardill
