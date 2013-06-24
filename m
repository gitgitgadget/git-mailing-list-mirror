From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 4/6] t/t5528-push-default: generalize test_push_*
Date: Mon, 24 Jun 2013 10:33:10 +0200
Message-ID: <CALKQrge4Nac4nk1RSnOFwE4-BNtHRNDSZHh9ihPY7ERd5jQ2Ng@mail.gmail.com>
References: <1372048388-16742-1-git-send-email-gitster@pobox.com>
	<1372048388-16742-5-git-send-email-gitster@pobox.com>
	<CALKQrgeSbY3spjTp_m7kgt4TkFi8B5pNpLQ8wvDD+qkCYa+Mww@mail.gmail.com>
	<7v7ghkdl2p.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 24 10:33:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ur2DB-000244-GS
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 10:33:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753183Ab3FXIdR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 04:33:17 -0400
Received: from mail10.copyleft.no ([188.94.218.231]:60824 "EHLO
	mail10.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751916Ab3FXIdQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 04:33:16 -0400
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail10.copyleft.no with esmtp (Exim 4.66 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1Ur2D4-000Mew-FU
	for git@vger.kernel.org; Mon, 24 Jun 2013 10:33:14 +0200
Received: from mail-ob0-f179.google.com ([209.85.214.179])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1Ur16R-000BDw-Kb
	for git@vger.kernel.org; Mon, 24 Jun 2013 09:22:19 +0200
Received: by mail-ob0-f179.google.com with SMTP id xk17so10557365obc.10
        for <git@vger.kernel.org>; Mon, 24 Jun 2013 01:33:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=JQOn5xrrnKwAZ666Q3U1B/wic+Gf+ZO3lDOcij8Ou2U=;
        b=Lrj5NyUYN0Mk41AUEp7S2mNGKrEHLoS01uhK5zQNsRgwS3FUrwqRPL9YZzvb0pVnWT
         5of4B5T+AsWXqIG7JgnUY6IksNmG7mOn762EW157gE/kN2xNXOBRbzMlLGpjBhO/OOf1
         cC4dodyKBInb7eZ/GFK9SubqcPYLBp/OYiVbN4RdzzEq3xDUsctCqDT1SCgVoerGpLSC
         /skMfdc78GoCpsGwxtgTdYp+wbwVDSnIHGN0Jk9P5NK3BzQ5VdheolfuX1l7k93nhVcI
         +50QVVfVct2lHJ/pw6J+vcSGxgvIVeArAsY6tGApbloNwY9yEF/a+Qb1rRdmgMhO5A9o
         UQKw==
X-Received: by 10.60.143.41 with SMTP id sb9mr10276324oeb.102.1372062790853;
 Mon, 24 Jun 2013 01:33:10 -0700 (PDT)
Received: by 10.182.102.5 with HTTP; Mon, 24 Jun 2013 01:33:10 -0700 (PDT)
In-Reply-To: <7v7ghkdl2p.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228795>

On Mon, Jun 24, 2013 at 9:28 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Johan Herland <johan@herland.net> writes:
>
>>> +       git --git-dir="${3:-repo1}" log -1 --format='%h %s' "$2" >actual &&
>>
>> Isn't  ${3:-repo1} a bashism?
>
> I do not think so.  But now I looked at it again, I think I would
> use ${3-repo1} form in this case myself.  No caller passes an empty
> string to the third place.

Ok, I have to admit that I'm not at all sure where the line between sh
and bash goes when it comes to ${magic}... Is there any good
documentation on what is in sh and what is not?

...Johan



-- 
Johan Herland, <johan@herland.net>
www.herland.net
c
