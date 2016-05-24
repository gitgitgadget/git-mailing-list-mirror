From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Opinion gathering] Git remote whitelist/blacklist
Date: Tue, 24 May 2016 09:07:53 -0700
Message-ID: <CAPc5daURo8SkbeGf0MEsp0sLzdzFfUOxptgusFr58UG9SKmDAA@mail.gmail.com>
References: <1040142021.5607762.1463753271105.JavaMail.zimbra@ensimag.grenoble-inp.fr>
 <584027154.5608416.1463754104066.JavaMail.zimbra@ensimag.grenoble-inp.fr>
 <001001d1b2a3$06d7bbb0$14873310$@nexbridge.com> <1929221963.5686879.1464007899902.JavaMail.zimbra@ensimag.grenoble-inp.fr>
 <1884904685.12056.1464084750628.JavaMail.zimbra@ensimag.grenoble-inp.fr>
 <84BDC4A4-FBE1-4542-868C-FA77A25469F3@gmail.com> <vpq37p74nu1.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Lars Schneider <larsxschneider@gmail.com>,
	Francois Beutin <beutinf@ensimag.grenoble-inp.fr>,
	"Randall S. Becker" <rsbecker@nexbridge.com>,
	Git Mailing List <git@vger.kernel.org>,
	simon rabourg <simon.rabourg@ensimag.grenoble-inp.fr>,
	wiliam duclot <wiliam.duclot@ensimag.grenoble-inp.fr>,
	antoine queru <antoine.queru@ensimag.grenoble-inp.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue May 24 18:08:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5EsU-0001BS-Rr
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 18:08:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751820AbcEXQIO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 12:08:14 -0400
Received: from mail-yw0-f180.google.com ([209.85.161.180]:36608 "EHLO
	mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751425AbcEXQIN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 12:08:13 -0400
Received: by mail-yw0-f180.google.com with SMTP id x189so20436326ywe.3
        for <git@vger.kernel.org>; Tue, 24 May 2016 09:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=Pw4V57Nsdi1zOtLIwMjTKXS/ggWx3rMx3U0PWgDxdN8=;
        b=uzDtuusow7tC5wniEUrlSvvMEM6fiXzlVw7HsQQzEVstATqwUTEcka867EJEnCPOmc
         1k3znq07bVZlAa7RkMTFqhClwUpQ+Jxs9P9/bMt9aDm0bKB0Key8lmlk3dfCt1PwO59c
         qXOlPR2dO0z7iukRMr89wAqHsQOjlfLiwGfVQp20ARfCiVvQosSauG6MTwTwIXFr/gDZ
         wdQlfaJJVaRI6JilthT/IejXcyY+LcX4QwVWCUBu7Lquqav0QCTF3l2oc1XwIOsUkoPZ
         SfVikgcZgoBhTDO8gleIh0SKAVNRdOzBBlj4ZWVtq+7pNxEWN38T4jyNzw1aPBi9s1kF
         KCSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=Pw4V57Nsdi1zOtLIwMjTKXS/ggWx3rMx3U0PWgDxdN8=;
        b=JLaPyj2R5QGtdCo1Ezxj9u2Z/JQJ84I4uwblbleohC9EyfPD+0LZdMqKYwbqlOpiMj
         MI1/WL6+ZcQPhIMDws0UbzDoAxNq878rHUKlSzm5RyoGW+pIqush4mgwoWVpQQvV12jv
         /kLS/FwjGz0vr5ZjDfb9EMcksrn1Vqa+R4p+LBn/cF8D8jOBZ36zRr6oenzEK7EI59Gq
         MUK+SZY6OmtOjY2toDUMe9toALGEjnCRxn/KEsDYtWl4Z8D2WYMyDTAK1IEHZ0qld1dL
         a11gd28NouesukybJHLk61M+oXwArEzITp4YAjRvxOKLKNo/KojHNG4/iZP3UE1yHW5W
         lc5g==
X-Gm-Message-State: ALyK8tJBNxcjD8dHKTaa01Nuk1pmGLPXUSsaBHchlhvBQg2PoNMuILqsDUvBxOCFCHKhdU2KU9yKC0Rvw9pZqQ==
X-Received: by 10.13.215.136 with SMTP id z130mr1886845ywd.278.1464106092945;
 Tue, 24 May 2016 09:08:12 -0700 (PDT)
Received: by 10.13.251.71 with HTTP; Tue, 24 May 2016 09:07:53 -0700 (PDT)
In-Reply-To: <vpq37p74nu1.fsf@anie.imag.fr>
X-Google-Sender-Auth: z0byAmwna2ct_QatYVaDt29_7ts
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295498>

On Tue, May 24, 2016 at 5:55 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> So, when trying a forbidden push, Git would deny it and the only way to
> force the push would be to remove the blacklist from the config, right?
>
> Probably the sanest way to go. I thought about adding a "git push
> --force-even-if-in-blacklist" or so, but I don't think the feature
> deserves one specific option (hence add some noise in `git push -h`).

Yeah, I agree --even-if-in-blacklist is a road to madness, but I wonder
how this is different from setting pushURL to /dev/null or something
illegal and replace that phony configuration value when you really need
to push?
