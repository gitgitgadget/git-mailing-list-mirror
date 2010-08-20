From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH] builtin/checkout: Fix message when switching to an
 existing branch
Date: Sat, 21 Aug 2010 01:46:13 +0800
Message-ID: <AANLkTine1mi0AiCL+ezwNpFs4_y_szSwJd+Enux5G26Y@mail.gmail.com>
References: <1282326107-2139-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 20 19:46:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmVfZ-0003jo-LB
	for gcvg-git-2@lo.gmane.org; Fri, 20 Aug 2010 19:46:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752144Ab0HTRqP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Aug 2010 13:46:15 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:54306 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751734Ab0HTRqO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Aug 2010 13:46:14 -0400
Received: by ewy23 with SMTP id 23so2314625ewy.19
        for <git@vger.kernel.org>; Fri, 20 Aug 2010 10:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=j8LbQv0JGkx4tUIeru2KO5o5/PROHcLfCdZHTqfDuAM=;
        b=o8EZrB6XMkw11cG59UmHQGYmeLtI2hXckGt6Yhim6TG2rflE60kBzVogK4T0f4BW2W
         0W8qr6mSk2jTPmcM72VSeqWJQ9KlYMS2+JofBwanfqRLDyW8BCUv5rKeJfidASfn07C2
         f0A2+6W9Txte2pF50kVqMpdooIC5x9GWsEbaA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=QVGD9zR3Vevnly9QSi1BoOwdUZE3k+AlWmtm7jFn56gFvkY53S1rSQ1Ee+1FVi9N9W
         sXePNXdL5jxdo5zai3ulmGEYVrrIY+8vlklck9SoXMkL+gjJ3idMcI4AHskg5aNjI0ti
         9SenxBm1K1HO/QKBYo5kgR5pk+aa+q766X/Ag=
Received: by 10.213.15.65 with SMTP id j1mr1645187eba.79.1282326373147; Fri,
 20 Aug 2010 10:46:13 -0700 (PDT)
Received: by 10.213.22.134 with HTTP; Fri, 20 Aug 2010 10:46:13 -0700 (PDT)
In-Reply-To: <1282326107-2139-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154061>

On Sat, Aug 21, 2010 at 1:41 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Fix "Switched to a new branch <name>" to read "Switched to branch
> <name>" when <name> corresponds to an existing branch. This bug was
> introduced in 02ac983 while introducing the `-B` switch.
>
> Cc: Tay Ray Chuan <rctay89@gmail.com>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>

Please see

  <AANLkTi=3z9gJdT8LL3NANFyppUjvOVcrszjf5J5zAKPe@mail.gmail.com>

-- 
Cheers,
Ray Chuan
