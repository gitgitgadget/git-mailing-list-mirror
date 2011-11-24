From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 10/13] credentials: add "cache" helper
Date: Thu, 24 Nov 2011 09:36:43 -0500
Message-ID: <CAPig+cShsteRy4=hEtJdmUk5TDPr1_vjCk5DiLfv-a2NpeVYRA@mail.gmail.com>
References: <20111124105801.GA6168@sigill.intra.peff.net>
	<20111124110710.GH8417@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 24 15:36:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RTaPy-0004nm-BX
	for gcvg-git-2@lo.gmane.org; Thu, 24 Nov 2011 15:36:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755484Ab1KXOgp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Nov 2011 09:36:45 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:49593 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753343Ab1KXOgp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Nov 2011 09:36:45 -0500
Received: by ghrr1 with SMTP id r1so2572255ghr.19
        for <git@vger.kernel.org>; Thu, 24 Nov 2011 06:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=e176x4kRe1reXHCsvzWRLkdF8jv5Hmtbn47/lPczyN0=;
        b=dPDHUHNW6Ft53fjyaBuVk/nkjHo5Sl+fm4X2cNPcBFvLqaOai4oKHOM2v4Hx3e4lcG
         1NcAQBmptC2YKjqETWykvUb2/OIqezzb57U+U3/tdDwLypG2YRujEj9ii3kynxf/Bppx
         81yhDI+Dd/K9yczp3KU7Ovz3k18jE3fpvRxgk=
Received: by 10.50.216.137 with SMTP id oq9mr33105341igc.40.1322145403993;
 Thu, 24 Nov 2011 06:36:43 -0800 (PST)
Received: by 10.231.105.1 with HTTP; Thu, 24 Nov 2011 06:36:43 -0800 (PST)
In-Reply-To: <20111124110710.GH8417@sigill.intra.peff.net>
X-Google-Sender-Auth: Mbx8ov2bs4mKz7e6A7h8AD790ok
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185915>

On Thu, Nov 24, 2011 at 6:07 AM, Jeff King <peff@peff.net> wrote:
> diff --git a/Documentation/gitcredentials.txt b/Documentation/gitcred=
entials.txt
> index 1e54117..a1592ed 100644
> --- a/Documentation/gitcredentials.txt
> +++ b/Documentation/gitcredentials.txt
> @@ -63,11 +63,18 @@ Credential helpers, on the other hand, are extern=
al programs from which git can
> =A0[snip]
> +cache::
> +
> + =A0 =A0 =A0 Cache credentials in memory for a short period of time.=
 See
> + =A0 =A0 =A0 linkgit:git-credential-cache[1] for details.
> +
> +You may may also have third-party helpers installed; search for

s/may may/may/

-- ES
