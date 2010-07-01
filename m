From: Peter Harris <git@peter.is-a-geek.org>
Subject: Re: [PATCH 4/4] Makefile: Don't pass $(ALL_CFLAGS) to the linker
Date: Thu, 1 Jul 2010 17:27:21 -0400
Message-ID: <AANLkTin_JLmLaN20TuuORpN56qj94njQo3sJHJhRDvvM@mail.gmail.com>
References: <4C226520.5080009@ramsay1.demon.co.uk>
	<AANLkTinmGOSwNzLBngXHOU-pxNTbHFJQyCLIHQWFW6Eo@mail.gmail.com>
	<4C251062.8040507@ramsay1.demon.co.uk>
	<AANLkTilvV9Lty6jciIvASrRrzZ5rf9s2zmgulxuyM1hE@mail.gmail.com>
	<4C2BA085.3060601@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Thu Jul 01 23:27:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OURIL-0007jU-Cw
	for gcvg-git-2@lo.gmane.org; Thu, 01 Jul 2010 23:27:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933201Ab0GAV11 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Jul 2010 17:27:27 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:43937 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933173Ab0GAV1X (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jul 2010 17:27:23 -0400
Received: by fxm14 with SMTP id 14so1742520fxm.19
        for <git@vger.kernel.org>; Thu, 01 Jul 2010 14:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:sender:received
         :in-reply-to:references:date:x-google-sender-auth:message-id:subject
         :from:to:cc:content-type;
        bh=OL1aZ1azT90yoqBzcguuthclJB0IMVNVKkYEoCASJDQ=;
        b=aR8IwHXg1xzCZRFI/J+8taYJ6Pj++ECcznEdy0+aH9FRMhtSkrXFKHkt7t3YF2hxU7
         p9z6/3EtHiOxf6GuzLD++kwarjb+fduxWI2x70duGvzBYdTO3C7rftx/EQpyCVt+0EOj
         bBhGWpWEZs3rJFklzaEKs196pGvXNCIWes4Cg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        b=bXMCucZJ5Eq+S+Ih1ii+pfrtl35TWkclapIlndA3FPZ7IzyaShluYrbII3O3Udz1uW
         0yZ0uEsuemvXcRncYvAiTpuve44+n3SqPRV+BWfSXvVJ2mgABzLrezS1CtKNitPhY1WH
         NUWMAO3nlg97XY42sB+sGju13JJ1VTAPUsWPk=
Received: by 10.103.95.20 with SMTP id x20mr33673mul.18.1278019641197; Thu, 01 
	Jul 2010 14:27:21 -0700 (PDT)
Received: by 10.103.241.14 with HTTP; Thu, 1 Jul 2010 14:27:21 -0700 (PDT)
In-Reply-To: <4C2BA085.3060601@ramsay1.demon.co.uk>
X-Google-Sender-Auth: 9HbhPkcdx1RFLWta0nEJ2V97yXw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150086>

On Wed, Jun 30, 2010 at 3:52 PM, Ramsay Jones wrote:
> Your patch fixes my problem, and is *much* better than my patch, so could
> you send a formal patch to the list (with W added to the the regex as well
> as Z)?

I'm currently on vacation. I'll try to remember to do that on Monday.

Peter Harris
