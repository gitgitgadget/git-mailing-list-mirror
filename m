From: Lars Hjemli <hjemli@gmail.com>
Subject: Re: CGIT 0.8.3.1 "chokes" on some bare repos
Date: Tue, 3 Aug 2010 18:49:07 +0200
Message-ID: <AANLkTimEbrapnihtp=6J5KTn67WqQk+726a3uCZaLwum@mail.gmail.com>
References: <AANLkTikcnv2dzY25dSgvKoTfLJ416gcaeDZA5HGa_tue@mail.gmail.com>
	<AANLkTinab6BkUqZnUE3yxmgY_lKyp0TbYUPYbKkoUKMA@mail.gmail.com>
	<AANLkTi==+q28cS7ssz-E3vQ7xqoQxBM4Tj1Jf_SvuK0G@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 03 18:49:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgKg0-0008SN-Rb
	for gcvg-git-2@lo.gmane.org; Tue, 03 Aug 2010 18:49:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932399Ab0HCQtK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Aug 2010 12:49:10 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:37647 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932396Ab0HCQtJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Aug 2010 12:49:09 -0400
Received: by fxm14 with SMTP id 14so2074792fxm.19
        for <git@vger.kernel.org>; Tue, 03 Aug 2010 09:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=Y8mNRqLXD/ywG8+IjE9aV3Ir4FUeBDw3/K6/pTLYgoA=;
        b=GO+JhgppdwcNzmELebjj1YBiRgtPDYAZfN5ugpQQQNPE2mCt+SQSLsXq+ruT95TDJ8
         CQQdABQyM6UkJF1bl4Iv0mc9Iz2rQrDDMQtVPhqx3U4LTqoeMQyfd3QJFMgkTpZ4xN0H
         GNyOXRPSgnKDCIQQLMJtX+9zOZeDz5rmgiE/8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=c9Vbaxegu9/FPZh7SqglNuAmaGCHmGTOMgRQJUXy1LvvPgbEhThpicPpKOjJiy2fjw
         VycuuGrJn31nxW5G5I3qtKKlYCZduJWS2Et53Jt1gji+34IROUKWxRCcr2jSQMdIPxS3
         I38oR4sbgmeM1w+AtyT5lDb2t/SD/EDU1hN58=
Received: by 10.239.174.74 with SMTP id i10mr421144hbf.32.1280854147820; Tue, 
	03 Aug 2010 09:49:07 -0700 (PDT)
Received: by 10.239.165.79 with HTTP; Tue, 3 Aug 2010 09:49:07 -0700 (PDT)
In-Reply-To: <AANLkTi==+q28cS7ssz-E3vQ7xqoQxBM4Tj1Jf_SvuK0G@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152526>

On Tue, Aug 3, 2010 at 17:57, Eugene Sajine <euguess@gmail.com> wrote:
> Everything works extremely well with an exception of few repositories
> that when opened are not showing the tags or last commits.
> I.e. when I'm looking at the source of the page i see that the HTML is
> not fully generated.

This sounds like a premature exit() - does `git for-each-ref
--format="%(refname)" | xargs -L 1 git rev-parse --verify` produce any
errormessages?

Also: if you could provide me with a clone-url for one of the
troublesome repositories, I can try to debug the issue.

--
larsh
