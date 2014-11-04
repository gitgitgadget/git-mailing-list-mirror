From: Tzvetan Mikov <tmikov@gmail.com>
Subject: Re: [PATCH v2] line-log: fix crash when --first-parent is used
Date: Tue, 4 Nov 2014 13:41:54 -0800
Message-ID: <CACt9tMi24QyvdpCk-tmU5U8jbP8eYhaNm4zWu6PqcKsJQ=OsYw@mail.gmail.com>
References: <1414784636-43155-1-git-send-email-tmikov@gmail.com>
 <1415133217-7824-1-git-send-email-tmikov@gmail.com> <xmqq8ujqpsk6.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>,
	Eric Vander Weele <ericvw@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 04 22:42:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xlls4-00018Y-EV
	for gcvg-git-2@plane.gmane.org; Tue, 04 Nov 2014 22:42:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751977AbaKDVmc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Nov 2014 16:42:32 -0500
Received: from mail-qc0-f178.google.com ([209.85.216.178]:40732 "EHLO
	mail-qc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751858AbaKDVmb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Nov 2014 16:42:31 -0500
Received: by mail-qc0-f178.google.com with SMTP id b13so12943874qcw.37
        for <git@vger.kernel.org>; Tue, 04 Nov 2014 13:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=02NF5vcJoob+n+2YmG1cHm+ye7PffZHcP8l/TeUC8RI=;
        b=MRBTgk4jiz8YE06eCH8N0lqxf7C1CFoIL5hxmvq5WBjFAtasTWZdvdaqYaJX4ljo2Q
         TWaIyHztlMhB+sOiSTGXKNvVPjQMMMDFZ2+C5voZZG2U4BDtqHpx5cJsK9IUiiEjNiML
         AehM6bVN6XN5zgRNgfUrLeEi7YDd5fU5CxgEuREyQAgunSOQfxRCHDB8QV5+h8X4hIS1
         7mMVSVReRglfyOFUKNROAl0OzRQVFm7juNhvZHPJAB/pNiNjCD4RQQcObBg1bNJ+HI3t
         HxThvaTPZSvXaVhe1y4qF7QLx1iLb2BWMZ/4rvJPhREpoyqDd5+17BcC5ombt2Rwx+AZ
         URCw==
X-Received: by 10.229.53.133 with SMTP id m5mr80514468qcg.28.1415137344798;
 Tue, 04 Nov 2014 13:42:24 -0800 (PST)
Received: by 10.140.16.45 with HTTP; Tue, 4 Nov 2014 13:41:54 -0800 (PST)
In-Reply-To: <xmqq8ujqpsk6.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 4, 2014 at 1:24 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Thanks, both.  The patch looks good (modulo the indentation of
> nparents assignment, which I'll locally fix up).
>
> Will queue.

Awesome, thanks!
(I can't believe I missed that tab. Well, at least one of my two
lines was correct :-) )

regards,
Tzvetan
