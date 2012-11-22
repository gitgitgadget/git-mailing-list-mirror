From: Adam Spiers <git@adamspiers.org>
Subject: Re: Duplicate test numbers in pu.
Date: Thu, 22 Nov 2012 10:35:51 +0000
Message-ID: <CAOkDyE8txOzmZ7JFwzjhQ17Xv5pQ1mmoXSYei7MJdXKBsM19nA@mail.gmail.com>
References: <50AD27FA.3010006@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	GIT Mailing-list <git@vger.kernel.org>,
	felipe.contreras@gmail.com
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Thu Nov 22 20:39:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tbcc1-0007Em-RH
	for gcvg-git-2@plane.gmane.org; Thu, 22 Nov 2012 20:39:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757211Ab2KVTit (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2012 14:38:49 -0500
Received: from mail-qa0-f53.google.com ([209.85.216.53]:61984 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757156Ab2KVTin (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2012 14:38:43 -0500
Received: by mail-qa0-f53.google.com with SMTP id k31so1148685qat.19
        for <git@vger.kernel.org>; Thu, 22 Nov 2012 11:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=fGEgF/nEsDUU9LmG6Iu4LaLGQRSLXWUOqQ2vFNGuQ3c=;
        b=ajfyA95SaLgumrRIxIeA5MH7KVvASJlvuwxDGYBfm9MWFfmDWKcprb4AXKESDOeb8m
         9hShtZqKQGljUF9tI2/dS9PqVCoG/9ovfZy0xEZ+3YyjA3mRVXqpUo7XS6g8sk/Vz1Dx
         0jq1UC5Vda8O3Ea9hoygrqw8ilqan4DtoZ5B2F1PneYgWqiBP1nMFOV8LHckFTJAkiT/
         /Ib92XDT/DPhRe0Q51l0pi4qfNTd2sGB2pr/3gMDmsUqdQjGEysGeoGE43We1zWA19fX
         7lPDpNUKKoh7LSgAdtDmwFymNqPqd9TAMMHyGu6FPl6tzQQGKXYO3zC7ZxX/nDu+tBOr
         owGw==
Received: by 10.229.234.151 with SMTP id kc23mr21562qcb.41.1353580551590; Thu,
 22 Nov 2012 02:35:51 -0800 (PST)
Received: by 10.49.118.135 with HTTP; Thu, 22 Nov 2012 02:35:51 -0800 (PST)
In-Reply-To: <50AD27FA.3010006@ramsay1.demon.co.uk>
X-Google-Sender-Auth: s3haxnvQ91j5EMtyQSi3GyGRzAw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210197>

On Wed, Nov 21, 2012 at 7:14 PM, Ramsay Jones
<ramsay@ramsay1.demon.co.uk> wrote:
> I noticed that the pu branch has two tests with number t0007, viz:
>
>     $ cd t
>     $ make test-lint-duplicates
>     duplicate test numbers: t0007
>     make: *** [test-lint-duplicates] Error 1
>     $
>
> In particular, t/t0007-git-var.sh is added by branch 'jk/send-email-\
> sender-prompt', while t/t0007-ignores.sh is added by branch 'as/check-ignore'.

Thanks; I can renumber t0007-ignores.sh in the next re-roll.
