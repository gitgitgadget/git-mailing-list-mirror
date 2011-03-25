X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: merge recursive and code movement
Date: Fri, 25 Mar 2011 13:32:22 -0400
Message-ID: <AANLkTimWm6eim2u-SDrot_VtMuUf=wvf_P5DuYpuV-m5@mail.gmail.com>
References: <AANLkTi=h6jUsjqXofd0QeWbNBjc9DeodJJ3FN7caW4XC@mail.gmail.com>
 <20110325093758.GA9047@sigill.intra.peff.net> <20110325101204.GB9047@sigill.intra.peff.net>
 <20110325111225.GC9047@sigill.intra.peff.net> <20110325160013.GA25851@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Fri, 25 Mar 2011 17:33:04 +0000 (UTC)
Cc: git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=hpdvgef2AvxWzvJyYjJy+3zS247LaK6KkzFsl7h6p1k=;
        b=IlADM/qpj6eXswI4SyvGhSw6tbfmb3IJvvXGjFTjURH57uld33KilpCB1CzsQ5gXV0
         J3+mGKZ3W9vmsQsUSCw2CNt8nl55z4M1uXmWrO9CCH/DrcrFAIZFptKF7+HPcfABKKFI
         kRckouBh0YwLUTlwhgXNZJxBQwD4YnBVkBgk4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Hka9qDGKEEkCsK97eshcXrALUWUIJ+wtsvHCiq4i3l6XaLbEekO+YTXOvDEufY2c8i
         8BO6ONE9NQNwkY9AhAfQGeZzT/zYmMB29ScWQTX241703V6xW75b5GwHUizBnjVVhJW2
         /PpxVb8e8bBZ/AfeqOS9WI6TpcNA6VNcDXrpc=
In-Reply-To: <20110325160013.GA25851@sigill.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170000>
Received: from vger.kernel.org ([209.132.180.67]) by lo.gmane.org with esmtp
 (Exim 4.69) (envelope-from <git-owner@vger.kernel.org>) id 1Q3Asd-0007F9-C9
 for gcvg-git-2@lo.gmane.org; Fri, 25 Mar 2011 18:32:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751967Ab1CYRcy convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Mar 2011 13:32:54 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:43517 "EHLO
 mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1751088Ab1CYRcx convert rfc822-to-8bit (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 25 Mar 2011 13:32:53 -0400
Received: by iyb14 with SMTP id 14so734231iyb.19 for <git@vger.kernel.org>;
 Fri, 25 Mar 2011 10:32:53 -0700 (PDT)
Received: by 10.42.137.198 with SMTP id z6mr1575189ict.261.1301074373084;
 Fri, 25 Mar 2011 10:32:53 -0700 (PDT)
Received: by 10.231.181.91 with HTTP; Fri, 25 Mar 2011 10:32:22 -0700 (PDT)
Sender: git-owner@vger.kernel.org

On Fri, Mar 25, 2011 at 12:00 PM, Jeff King <peff@peff.net> wrote:
>
> OK, I figured it out. I was thrown off by test failures in t3030, but=
 I
> think that test is actually wrong; it documents what happens, but not
> really what we _want_ to have happen.
>
> So this is the patch series I ended up with:
>
> =C2=A0[1/3]: t3030: fix accidental success in symlink rename
> =C2=A0[2/3]: merge: handle renames with replacement content
> =C2=A0[3/3]: merge: turn on rewrite detection

I read through all three of these and, from my superficial
understanding of the merge code, they look correct.

I'll test these out on some actual merges as soon as I can. (Probably
next week.)

Thank you for this series.

