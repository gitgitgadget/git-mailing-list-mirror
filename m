From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] t/Makefile: always test all lint targets when running tests
Date: Tue, 8 Jul 2014 22:42:57 -0700
Message-ID: <CAPc5daUXZNB=2X8zsrhs9=Z-nV1o1v7KWGydAj6UmBk23UBEEw@mail.gmail.com>
References: <53B5D6FE.2090700@web.de> <53B5D76D.1090509@web.de>
 <xmqq38eddolk.fsf@gitster.dls.corp.google.com> <53BC4569.3020907@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Jul 09 07:43:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4kf5-0000T2-7n
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jul 2014 07:43:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751610AbaGIFnT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2014 01:43:19 -0400
Received: from mail-lb0-f177.google.com ([209.85.217.177]:58550 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751294AbaGIFnT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2014 01:43:19 -0400
Received: by mail-lb0-f177.google.com with SMTP id u10so4654887lbd.36
        for <git@vger.kernel.org>; Tue, 08 Jul 2014 22:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=z8evwWyJJR6nR6Xqg7EN4o56KULf02QEeojvx6JAiEk=;
        b=gkEBhBXlusq2aeLwCmDjWUIp03Z76EU9t8nmIgkurRGqeyV6hA3ZJ5kR0kf6xKk9us
         I4+YjG1BLeyaDqriWBNQtaFDyxjFJ++CX6SLKrBgD8kNPXl7k8dgb2hQBXyRle2m9CvJ
         RRbtDxN5rCYftb+GjQUMoozHNjIqMJ/5fI3cXZIZmvx1/K1WzR+8PmyQaj1Rt9F1s8HA
         j+iIRed4MYHnjQ9ivJ3l+hKykuMTl+wrqk3AiLwOPTw/ZKKXtQYdV0r2BIiZFZ5v8tP9
         cneFGhXrCN92VVWdWXS18Pey3QtK+AuyvwTpbwnSYeWUjCP6XwAkUOVY2dZF3KNajyQ2
         lvOg==
X-Received: by 10.152.120.3 with SMTP id ky3mr252424lab.69.1404884597525; Tue,
 08 Jul 2014 22:43:17 -0700 (PDT)
Received: by 10.112.26.212 with HTTP; Tue, 8 Jul 2014 22:42:57 -0700 (PDT)
In-Reply-To: <53BC4569.3020907@web.de>
X-Google-Sender-Auth: AzjJD1mtiQX_MQJkUnzuBoIBgUU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253066>

On Tue, Jul 8, 2014 at 12:24 PM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
>
> Am 07.07.2014 20:13, schrieb Junio C Hamano:
> >
> > So I am not very enthusiastic to see this change myself.
>
> Ok, I understand we do not want to lightly risk false positives. I
> just noticed that I accidentally forgot to sign off this series, so
> I'd resend just the first patch with a proper SOB, ok?


Nah, let's do both and how it plays out. My not being very enthusiastic
myself does not necessarily mean that it is bad for the project. Maybe
most people like it and if I cannot bear with it I can always turn it off
myself for my environment.

I just have a strange feeling that we may be seeing some twisted shell
script updates and when the author gets asked why it was written in
such a strange way, the answer might turn out to be "just to work around
the false positive from the test-lint", which I would not want to see.
