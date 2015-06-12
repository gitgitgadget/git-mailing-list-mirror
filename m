From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] git-rebase--interactive.sh: add config option for custom instruction format
Date: Fri, 12 Jun 2015 15:36:54 -0700
Message-ID: <xmqqeglgblkp.fsf@gitster.dls.corp.google.com>
References: <1434075808-43453-1-git-send-email-rappazzo@gmail.com>
	<1434075808-43453-2-git-send-email-rappazzo@gmail.com>
	<xmqqa8w4d4sc.fsf@gitster.dls.corp.google.com>
	<CANoM8SW-N6_yJ0kgGDuGWB+RS-0d54D4FtaRbKqhsf0_fSeMdw@mail.gmail.com>
	<xmqqzj44bn1l.fsf@gitster.dls.corp.google.com>
	<CANoM8SXQq_zbRui7SHDDAnrgf2VUdCkkJJ7_RHLu355JUzdNxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Git List <git@vger.kernel.org>
To: Mike Rappazzo <rappazzo@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 13 00:37:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z3XZN-0000IM-MZ
	for gcvg-git-2@plane.gmane.org; Sat, 13 Jun 2015 00:37:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751198AbbFLWg5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2015 18:36:57 -0400
Received: from mail-ig0-f178.google.com ([209.85.213.178]:36895 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753609AbbFLWg4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2015 18:36:56 -0400
Received: by igbsb11 with SMTP id sb11so19335066igb.0
        for <git@vger.kernel.org>; Fri, 12 Jun 2015 15:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=1gsLFq7behBOp8tc0MS8o3wQovmy1cecukZG3bKV/wQ=;
        b=SBfdimlZAm6lGvq2PF63qq7RJizTUbFX4+y5vahUAKd1e8bJFGumzJ1N9yKaDUb3y3
         sjrICpbWY7VpeneuTcLYaPtn/lXkOCTEEJrB/iE77089WqEQZqDS3tHmzObwakTCyUwN
         fib2fYxDp/F8eCSWaazFbaf7XCZSKjMk2rAvhySpcl1AVDON+mt2KGy82rQQxZ6I8D+f
         hQL+WLgRUYiKKGVrBPQNwJCOHHycBQ8w3oxXBwX/IvVFj98+VLL6P2KwbUUqMSDiSkzQ
         Ag9XTvxQxtX9A5TxOqBaqUUi6fKWuVLEbUSZu/Q+c6r5Sr2mPT2BEdh+9zM8Bkop74H3
         WOpg==
X-Received: by 10.107.8.208 with SMTP id h77mr21065724ioi.51.1434148616150;
        Fri, 12 Jun 2015 15:36:56 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:a12d:7c00:b954:bc66])
        by mx.google.com with ESMTPSA id x4sm3380115iod.26.2015.06.12.15.36.55
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 12 Jun 2015 15:36:55 -0700 (PDT)
In-Reply-To: <CANoM8SXQq_zbRui7SHDDAnrgf2VUdCkkJJ7_RHLu355JUzdNxA@mail.gmail.com>
	(Mike Rappazzo's message of "Fri, 12 Jun 2015 18:15:44 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271542>

Mike Rappazzo <rappazzo@gmail.com> writes:

> In the second loop, I changed it to recalculate the presented message
> when the re-ordered commit is added:
>
> +       if test -n "${format}"
> +       then
> +            msg_content=$(git log -n 1 --format="${format}" ${squash})
>
> That is the "$rest".

Ahh, yeah, I missed that --format=${format} thing.

Thanks.
