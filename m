From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 00/13] remote-hg: general updates
Date: Fri, 5 Apr 2013 19:47:10 -0600
Message-ID: <CAMP44s1t=cTQiOoXdbdEKa3zLa+8pi+BUU1n1XOzo+-LqGHs2Q@mail.gmail.com>
References: <1364929382-1399-1-git-send-email-felipe.contreras@gmail.com>
	<20130402200948.GF2222@serenity.lan>
	<2670C2C0-E30F-47DA-8901-899FEE11059E@quendi.de>
	<CAMP44s3DETFBhexPhEEMP1TZGNrc91266=t16H2t_+VB_4V38w@mail.gmail.com>
	<EF2F8946-4F60-4659-9215-6C21C9641AB0@quendi.de>
	<CAMP44s3qAPJtNVsb4gvYd1PunN4c-crxpVJc0K9520eiBO8iwA@mail.gmail.com>
	<BA2657F2-708B-434E-87D2-D6371806E2D3@quendi.de>
	<7vd2u8bg7x.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Max Horn <max@quendi.de>, John Keeping <john@keeping.me.uk>,
	git@vger.kernel.org, Jeff King <peff@peff.net>,
	gitifyhg@googlegroups.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 06 19:31:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOWRj-0001b9-FB
	for gcvg-git-2@plane.gmane.org; Sat, 06 Apr 2013 18:58:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163063Ab3DFBrN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Apr 2013 21:47:13 -0400
Received: from mail-lb0-f179.google.com ([209.85.217.179]:50842 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756458Ab3DFBrM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Apr 2013 21:47:12 -0400
Received: by mail-lb0-f179.google.com with SMTP id t1so4208543lbd.24
        for <git@vger.kernel.org>; Fri, 05 Apr 2013 18:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=Y/43FCCEJfnkUFwKBKZJHa3gJ5UpCzmE1pagS0Y7A4o=;
        b=j26doM2xpCI1yQPk6zvWjZjRsML9X3DwNOGA7UUTkGBEh2XRpSF3VULHfmE2BdsFVq
         Z0EjAJLue/mnVDGdkGLtB4EUZZ5fjK8yhv0c7y9gRgvUpwxXi42kBiVxWtVBOIGOrf3M
         WR7S6vTIsLsK3d4+hQ+kmEiXQ7GFG8GqXe0SEUl2ThqLIfstUdoUGpWtNhDwaklmQ2uX
         pWzBCtrH39De6eFTDbAgb+Vddwe62P9DM+pDc5HgusGLm0NbXKQm1zAiJolgCpDhylkh
         D+cZ9epYPVWhyJ8X51TS4cuFlyY9yk5S+/7yUE3eVGFinEuCSSpkpDX2fZiR6fn7KO6C
         l0dg==
X-Received: by 10.112.143.10 with SMTP id sa10mr7316290lbb.36.1365212830522;
 Fri, 05 Apr 2013 18:47:10 -0700 (PDT)
Received: by 10.114.20.36 with HTTP; Fri, 5 Apr 2013 18:47:10 -0700 (PDT)
In-Reply-To: <7vd2u8bg7x.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220215>

On Fri, Apr 5, 2013 at 7:28 PM, Junio C Hamano <gitster@pobox.com> wrote:

> A tool that is in contrib/ follows the contrib/README rule.
>
> I do not maintain it. Maintenance is up to the person who asked to
> include it there.  I do ask the people who propose to add something
> in contrib/ to promise that they arrange it to be maintained.

That's true, but I meant that you are the gatekeeper. Ultimately you
decide which patches go in. If Max, or anybody else, wants a patch
into contrib, you can get it in, even if I disagree with it. You can
also decide that somebody from gitifyhg might be a more suitable
person as a maintainer of remote-hg.

Either way, I think if things go well, remote-hg will prove it's worth
and move out of contrib and into git's core.

-- 
Felipe Contreras
