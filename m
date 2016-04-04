From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] git-format-patch.txt: don't show -s as shorthand for
 multiple options
Date: Mon, 4 Apr 2016 18:38:47 -0400
Message-ID: <CAPig+cR1mmx+2D7U8ejx8HTWbFtxbmi-85D0hgm9J48bkai6CA@mail.gmail.com>
References: <1459113967-13864-1-git-send-email-sunshine@sunshineco.com>
	<xmqqvb3x41bo.fsf@gitster.mtv.corp.google.com>
	<CAPig+cRMti0ayBMS2TTUc-Og=X-Pu2yeHxHOS74fw=X8BTsjhQ@mail.gmail.com>
	<xmqqr3el3zox.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Kevin Brodsky <corax26@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 05 00:38:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anD93-0005UI-Vn
	for gcvg-git-2@plane.gmane.org; Tue, 05 Apr 2016 00:38:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754531AbcDDWit (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2016 18:38:49 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:38432 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753043AbcDDWis (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2016 18:38:48 -0400
Received: by mail-ig0-f170.google.com with SMTP id ui10so103514281igc.1
        for <git@vger.kernel.org>; Mon, 04 Apr 2016 15:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=LBzygDHG35UGk8zGQzG8Fo/e671bnksb5jjRQbv1xog=;
        b=tLSjSk24FhwsVmRKgfMxjGa3Kvn//2xdbSaDxwupDMmQsW9wLrtVXNJL0j1mDzlqRh
         s+uT1QXZK4M6OTzWzLrJMAThe6lKG15YkrzcdnIF2tk0c//zpfKjSBQsQOPLPammgLHx
         jj2J4ERsHrylmEyYhKIwXeMIGs9fOX8eUlz4vgVYqoELRMJFqxi2Q3gHb0ZdTOjZzce3
         8fxueCjgc9jQosP2d0jgrvGfLj0s+IJMsEAiS/ehSUcFTNT3vmQq8sSHC2SDYEEV2Je8
         VpTpDHZWa/8PWqQXbU5+0ZP2gkh+wgElTXZ/krxGPohgNK8cAD42Vd90n9RIQnjRCAu8
         uQTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=LBzygDHG35UGk8zGQzG8Fo/e671bnksb5jjRQbv1xog=;
        b=ZfV+r0F76gugTu8R7HTyROCm2iM8b5TJsKhyRgZYeG2YTagLvw9lKJuWqw5h3oKMd2
         1Oy3r5WqArO7nJ4xCCQOthazge0M3YLXPbcGd2XiwfMseaDrjqM49H5xl5tetaEaUOEO
         0kOr0trux3vdgRXY07VPeXiId7ZoMal2lfnI1j2R1XMhutVefGsoPWm0b1/bJoB8IEJ+
         atntLIwcg8KJfvj3iNawWNkZn4BFak+C2362gwZ2F8yySjQ/bznr8z/MGFLxW1dTxV89
         vV0RO9Rbosqld+eZCr4V6cy7TlWXCJVqNyE5NHpvHoNGHdBDV6ufnDzarVdrJS0Yjdel
         AyXQ==
X-Gm-Message-State: AD7BkJJY+fwTPMEISVz8Cxx/+ol9D6QUe9KV3mJEbHyAhzn5ZoSkWXML75Di/ao3LYBhAHYH4+Gpwa4H5/wSSA==
X-Received: by 10.50.143.102 with SMTP id sd6mr8118986igb.73.1459809527528;
 Mon, 04 Apr 2016 15:38:47 -0700 (PDT)
Received: by 10.79.12.139 with HTTP; Mon, 4 Apr 2016 15:38:47 -0700 (PDT)
In-Reply-To: <xmqqr3el3zox.fsf@gitster.mtv.corp.google.com>
X-Google-Sender-Auth: rBItuYSMdQ24nSmlJj5mB84mQRI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290736>

On Mon, Apr 4, 2016 at 4:07 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>>> Given that the ifndef/endif block immediately before this part is
>>> also about excluding -p/-u/--patch when formatting the documentation
>>> for format-patch, perhaps the attached may be a smaller equivalent?
>>
>> Perhaps. I kept self-contained to make it easier to add new options
>> between the two if need be, but I don't feel strongly about it.
>
> I don't either, but the reason why I thought it would make sense to
> have them in the same block is because hiding --no-patch and --patch
> are about the same theme: format-patch is about presenting the diff,
> and neither disabling diff output nor explicitly asking for diff
> output makes sense.

That's reasonable. Should I re-roll, or would you like to amend it locally?
