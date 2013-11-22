From: Vicent Marti <vicent@github.com>
Subject: Re: What's cooking in git.git (Nov 2013, #05; Thu, 21)
Date: Fri, 22 Nov 2013 20:40:55 +0100
Message-ID: <CAFFjANQni7mvFBuAqJnPpTJ_68+rJKU6KmdRAWbyK_jbi0S=xA@mail.gmail.com>
References: <xmqqtxf51e5c.fsf@gitster.dls.corp.google.com> <20131122102345.GC12042@sigill.intra.peff.net>
 <87d2lsjs4q.fsf@linux-k42r.v.cablecom.net> <20131122172626.GA4881@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Rast <tr@thomasrast.ch>, Junio C Hamano <gitster@pobox.com>,
	git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 22 20:41:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VjwbR-0002gD-6o
	for gcvg-git-2@plane.gmane.org; Fri, 22 Nov 2013 20:41:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756014Ab3KVTlS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Nov 2013 14:41:18 -0500
Received: from mail-vb0-f41.google.com ([209.85.212.41]:45803 "EHLO
	mail-vb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755657Ab3KVTlQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Nov 2013 14:41:16 -0500
Received: by mail-vb0-f41.google.com with SMTP id w5so1173094vbf.14
        for <git@vger.kernel.org>; Fri, 22 Nov 2013 11:41:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=oIDiBoMg1sywo8wM5WMJOdYHbwoBov3wP5S2cNpnbOU=;
        b=pvrXKfErz/27aGEWwjE+aB9fnOr8DRhEfpg8FbBKveEstA3F0ac1xsVAdWQWBlji8F
         oVKaJ2vwXYs+k/GF3eE7O1H+qs2Xr2/AtFkE7CROm8Qn7SjKt5NFcAcTbP7XHNxql3AY
         sDgSpxkw3bLFdKs2yzXpCOtxcPEP7qjs2bjnIxcFS8y931oLbCcXqIgPfUXJ4CR2reR3
         0FMHVLXfx6+B1IjI3TO6ON8k/6dNd9F0aRXtqZnM6slYi5q/MS22sh24mxyuTX4etFiy
         cDyMup2EIT8Bic9Fq+MnP8ymYQEq1KYSgekhzyC29oYdiSoW5dhob7rPxCfve3ej68u/
         0kFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=oIDiBoMg1sywo8wM5WMJOdYHbwoBov3wP5S2cNpnbOU=;
        b=VKg0V/JwymM1pq27Zatwlm2msp5SXdlvG7QfxmsZ/u4hcCbl9A1wqdRxZl7SoCJwiX
         toUdKvNxawYMu7nipG1Mpni/5sAFIEJd6fEPiHPFr3UNJO/8OE05LHYJnfGGzHHE773E
         Mz3uUNMYZigIz+lh2K9j9C64PDcax0BkiPuIQ=
X-Received: by 10.52.103.35 with SMTP id ft3mr10932823vdb.5.1385149275498;
 Fri, 22 Nov 2013 11:41:15 -0800 (PST)
Received: by 10.220.87.142 with HTTP; Fri, 22 Nov 2013 11:40:55 -0800 (PST)
In-Reply-To: <20131122172626.GA4881@sigill.intra.peff.net>
X-Google-Sender-Auth: ea0BCIJtaTrj2ruL5LsqnRErmQA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238209>

On Fri, Nov 22, 2013 at 6:26 PM, Jeff King <peff@peff.net> wrote:
>> Granted, the way I verified this was checking whether you renamed
>> rlw_xor_run_bit() to something more fitting, so perhaps you just forgot
>> that one thing but did all the rest.
>
> I didn't touch that. Vicent, did you have a comment on the name (it
> really does look like it is a negation, and the only caller is
> ewah_not).

Yes, the name was ported straight from the original library and kept
as-is to make the translation more straightforward. These sources are
--again-- a translation, so I tried to remain as close to the original
Java implementation as possible.

I agree the name is not ideal, but it does make quite a bit of sense.
It effectively inverts the word based on the run bit, which is the
equivalent of xoring it with the bit if it's one.

Love,
vmg
