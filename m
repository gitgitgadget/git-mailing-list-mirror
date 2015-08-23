From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: Eric Sunshine mail delivery failure
Date: Sun, 23 Aug 2015 14:57:56 -0400
Message-ID: <CAPig+cSSO3ZTauM1hgUV=govWdmde0ds-fyt7QdHQauiwSmQBw@mail.gmail.com>
References: <20150811104056.16465.58131@localhost>
	<55CBA140.7050301@web.de>
	<20150813022545.30116.44787@localhost>
	<55D8C824.6000704@web.de>
	<CAPig+cSy+c9mOGOTN9e4xfLrvPc8nv7e0T_4PDA-vB-otwrvjw@mail.gmail.com>
	<trinity-6e67d416-0a61-4e73-9779-63519dd83fdb-1440322151491@3capp-webde-bs47>
	<55D993F8.4080506@web.de>
	<20150823171622.GA28700@zorg.kyriasis.com>
	<CAPig+cR3zZK5BJmG0S2K0PLcY9p-1Ko4ynR9GzM2wLq8xjn36g@mail.gmail.com>
	<CA+EOSBmk2cdQe3owaXgkYAgTZqpUFa=J8g5FYq28-=VhDcJ4EA@mail.gmail.com>
	<CAPig+cS+sDQV0O=pZXL9sw8ww39J=asxrbNm28jG0VSFhXtmtA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
	Git List <git@vger.kernel.org>
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 23 20:58:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZTaSw-0000xd-1I
	for gcvg-git-2@plane.gmane.org; Sun, 23 Aug 2015 20:58:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752812AbbHWS55 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Aug 2015 14:57:57 -0400
Received: from mail-yk0-f177.google.com ([209.85.160.177]:35550 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752728AbbHWS54 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Aug 2015 14:57:56 -0400
Received: by ykbi184 with SMTP id i184so115406878ykb.2
        for <git@vger.kernel.org>; Sun, 23 Aug 2015 11:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=/BRxA+7mXUB9TkAUuj9ewxqg+9CLw6ON3f3FvWyRQac=;
        b=C3ve4rryCOjM4fRUCZrA6j70GILDBKP58lMzCyHPdOo4lhgShLGX6L0ZnfSzniEPSR
         L4oDdsIZ4OLtITuq6w799SUFoNJAcOW9hVdT8+Tb4TtiDzOH66KzzwCABZXbw0YNW1ZW
         lCQ0Z5nOelpCQeYwWCcERk5d/qUTl5z09pMI4lZH7TwC+B8XJi0lsdH7j1DNBsUT85wZ
         4GC61Pd/JhR0e4V5gAR+jcW4pmXWxDLtz4GkgR34j7P/4TEu0qQreKS5AMzs9Xyfnhzf
         ew7QFimelHl1dnxqT9vr4hrsDCkUCAEjifaU8+iJYvAOZYNLHh/JRdPeVNQlbXG67ljm
         L/kw==
X-Received: by 10.129.76.151 with SMTP id z145mr25681863ywa.17.1440356276384;
 Sun, 23 Aug 2015 11:57:56 -0700 (PDT)
Received: by 10.37.208.78 with HTTP; Sun, 23 Aug 2015 11:57:56 -0700 (PDT)
In-Reply-To: <CAPig+cS+sDQV0O=pZXL9sw8ww39J=asxrbNm28jG0VSFhXtmtA@mail.gmail.com>
X-Google-Sender-Auth: g5UL6hTqSTieISJaw5P1LfAYT1Y
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276422>

On Sun, Aug 23, 2015 at 2:48 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sun, Aug 23, 2015 at 2:36 PM, Elia Pinto <gitter.spiros@gmail.com> wrote:
>> Il 23/Ago/2015 20:26, "Eric Sunshine" <sunshine@sunshineco.com> ha scritto:
>>> I did change the CNAME to an A just in case, though who knows how long
>>> it will take for the change to propagate over to web.de's server.
>> Anyone can check Here https://dnschecker.org/#CNAME/Mail.sunshineco.com
>> It would fail with your change
>
> Interesting service; thanks for the pointer. However, since it's just
> querying a random set of DNS servers, it's not necessarily indicative
> of whether the change has actually propagated to the DNS server(s)
> answering web.de's mail server's queries. Local configuration (TTL's,
> etc.) on those servers or anywhere in between, as well as network
> conditions, could impact propagation to an unknown degree.

Also, the propagation time of the A record can be quite different from
the point at which the CNAME record finally expires (based upon its
TTL, which may differ dramatically from server to server), so the
above CNAME query may continue to succeed long after the A record has
propagated.
