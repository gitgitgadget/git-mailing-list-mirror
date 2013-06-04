From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH] diff: add --ignore-blank-lines option
Date: Tue, 4 Jun 2013 21:08:03 +0200
Message-ID: <CALWbr2zJCxbW8Qug0i=oGvKZV5-vcAugextxMuQp9jaoaZYpyg@mail.gmail.com>
References: <1369591098-11267-1-git-send-email-apelisse@gmail.com>
	<7vzjv57mwx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 04 21:08:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ujwaa-0006qR-Sh
	for gcvg-git-2@plane.gmane.org; Tue, 04 Jun 2013 21:08:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750929Ab3FDTIG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jun 2013 15:08:06 -0400
Received: from mail-qa0-f47.google.com ([209.85.216.47]:60362 "EHLO
	mail-qa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750890Ab3FDTIF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jun 2013 15:08:05 -0400
Received: by mail-qa0-f47.google.com with SMTP id hv16so456256qab.6
        for <git@vger.kernel.org>; Tue, 04 Jun 2013 12:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=bWBUf1Y8N3HhAeY/erzczTj23EC0PRCuS5qH29HxvYs=;
        b=UnrhYYwTpujfjO97lDaotVf9Q0Gemm5CbOFy26esJIDU6mbgbSgTOTMhM59+OjL1gl
         pU/a7D3kXH9PKvY2/tyvUg1JloyvbVvDekc2+acHn390Htjd6aT5oBfnGU786bH0IdjM
         VjgY6QMxmg8BPgdtuAhkO+dDaB1OlzClH8zZ2d/eFN4bRHfrxf7vyynlJVqk2NRlwPBq
         67SgL0egc64XQR7kjME2OWLJb1+cHJczf43Iiln27I+g3GudeoaZpwmLFfeEMN2PE8Xs
         Y6pRRdeH3FsuQOnrB5kULEa9m2NXGiG6veEnlukBV04b4ltOmq/jYb+XxIUgdqY7H2Os
         ASIg==
X-Received: by 10.229.73.72 with SMTP id p8mr2492761qcj.53.1370372883870; Tue,
 04 Jun 2013 12:08:03 -0700 (PDT)
Received: by 10.49.108.105 with HTTP; Tue, 4 Jun 2013 12:08:03 -0700 (PDT)
In-Reply-To: <7vzjv57mwx.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226394>

On Tue, Jun 4, 2013 at 8:26 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Antoine Pelisse <apelisse@gmail.com> writes:
>
>> +xdchange_t *xdl_get_hunk(xdchange_t **xscr, xdemitconf_t const *xecfg) {
>>       xdchange_t *xch, *xchp;
>>       long max_common = 2 * xecfg->ctxlen + xecfg->interhunkctxlen;
>> +     long ignorable_context = max_common / 2 - 1;
>
> Could you explain how this math works?

I think it doesn't, mostly because I misinterpreted the "interhunkctxlen".
I will try to think about that and provide a reroll.

Thanks for the review and analysis.
Antoine,
