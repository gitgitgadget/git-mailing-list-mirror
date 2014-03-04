From: Faiz Kothari <faiz.off93@gmail.com>
Subject: Re: [PATCH] implemented strbuf_write_or_die()
Date: Tue, 4 Mar 2014 22:31:19 +0530
Message-ID: <CAFbjVcnnUeYwB=3R8JWuCnSRTRkKtkPMpqmgSXtoa4ut-OO__Q@mail.gmail.com>
References: <1393672871-28281-1-git-send-email-faiz.off93@gmail.com>
	<CAJr59C0e22OuDWU5Xc0A=cc+zY32nfum6SXTDU3wLCPyFPF70A@mail.gmail.com>
	<CAPig+cRgc4UtmJMieS9Mdrz7vjUNiu7QFu1PSBppKo22Ln5G-A@mail.gmail.com>
	<xmqqvbvvqglc.fsf@gitster.dls.corp.google.com>
	<53159A81.4050905@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	He Sun <sunheehnus@gmail.com>, git <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Mar 04 18:01:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKsic-0006gA-M9
	for gcvg-git-2@plane.gmane.org; Tue, 04 Mar 2014 18:01:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753269AbaCDRBW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2014 12:01:22 -0500
Received: from mail-lb0-f172.google.com ([209.85.217.172]:36313 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751820AbaCDRBV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2014 12:01:21 -0500
Received: by mail-lb0-f172.google.com with SMTP id c11so5835927lbj.31
        for <git@vger.kernel.org>; Tue, 04 Mar 2014 09:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=e1oI+T3gThU1B/tjhMYKL6J4nySTbngKhTrN6vKKJCY=;
        b=eNS9Qgigw2XltrtF3iGZvBDTl4c+JkdJFCg13wmHwT4xhhmdQK5gHa3+7RSu8nowWo
         aEG6O9gNvg4scUhcgp0MUvlxPZQ5U0FHUXSywwnLpyeQJAbJq8WsMAf7EnN/YruLp4ev
         YEf0mJ8+cJmvrvQMehSHbA5l4ZejmHGoORXhOBLzMnf37Hw0r0YjUsNNKx+vMSB+RSyi
         C166S+3Ck67u+3Nat3+HuO95zIrBMXCSI/pUoeolPEzbc9aOoOleHHMBfzYc4xH5p6mN
         mEFs1gMYeq9QJM7dSpdYdArs81S430F7WNh2EreB5bemVjz9VKgICAWjuEZcV47j27Eq
         fCMQ==
X-Received: by 10.112.13.133 with SMTP id h5mr191646lbc.67.1393952479684; Tue,
 04 Mar 2014 09:01:19 -0800 (PST)
Received: by 10.114.186.35 with HTTP; Tue, 4 Mar 2014 09:01:19 -0800 (PST)
In-Reply-To: <53159A81.4050905@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243359>

> I'm the guilty one.  I like the change (obviously, since I suggested
> it).  Writing strbufs comes up frequently and will hopefully increase in
> usage and I think it is a positive thing to encourage the use of strbufs
> by making them increasingly first-class citizens.
>
> But I can see your points too, and I humbly defer to the wisdom of the
> list.  I will remove this suggestion from the list of microprojects.
>
> Faiz, this is the way things go on the Git mailing list.  It would be
> boring if everybody agreed all the time :-)
>
> Michael

Hi,
Thank you all. Even I like the strbuf_write_or_die() but again its a
code churn as pointed out. But if we want to use strbuf instead of
static buffers we might need this function very often (Its just my
opinion).
Anyways, implementing it was an exercise and I enjoyed it. I agree
with Michael Haggerty that it would be boring if everybody agreed all
the time :D
I enjoyed it and learnt from the exercise, so I don't think it was a
waste or a bad exercise. At least it exposed me to practices of good
software design and importance of layers in software.

Thanks a lot.

-Faiz
