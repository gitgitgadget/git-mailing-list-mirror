From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] git-daemon: have --no-syslog
Date: Sun, 23 Jun 2013 05:16:45 -0400
Message-ID: <CAPig+cSjEJDYVjnx1kzUuP3=1-tc3criw=H=bN03ZAQg+dhpfQ@mail.gmail.com>
References: <20130622174122.GA6496@inner.h.apk.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: Andreas Krey <a.krey@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jun 23 11:16:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UqgPl-00066w-D9
	for gcvg-git-2@plane.gmane.org; Sun, 23 Jun 2013 11:16:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750902Ab3FWJQs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Jun 2013 05:16:48 -0400
Received: from mail-la0-f53.google.com ([209.85.215.53]:60818 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750811Ab3FWJQr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Jun 2013 05:16:47 -0400
Received: by mail-la0-f53.google.com with SMTP id fs12so9136781lab.12
        for <git@vger.kernel.org>; Sun, 23 Jun 2013 02:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=fOwtXXBY245WFWFKD3tqhlIwraET69cEFm7muKGQyVc=;
        b=DmYNAZh46AU6Dntmn6LowN4JRl66DHsmSUPW3ygeMN1dXL/DyYuzLmJSEU2j1bZ4bC
         ctNwPCVorbejZ0BmRnCyCwjRI1bbied+5Tk/n5aI0M3lvEQNwakuhODdCEIYK6osQMVI
         +0PYk4mk+7DG55myI8yhsPSK80/pTB6RfgDK9RuMQHzEpWnomm+JORQ+CPP+jSUBDNfw
         VlQDmPycj9WdnQ+sdYzEpUORIIyRE1nINWffkN9foc7umhs9H0thN+C7iP1Rf8fhL4k0
         J8EJqnqxnF4wYL4Jf0wbOBzPZdgAPZ2PBkcILCENlgGL2Djo2nd3vzFe1ZBivnjtMR4Z
         Zotg==
X-Received: by 10.152.120.105 with SMTP id lb9mr9250740lab.20.1371979005856;
 Sun, 23 Jun 2013 02:16:45 -0700 (PDT)
Received: by 10.114.161.5 with HTTP; Sun, 23 Jun 2013 02:16:45 -0700 (PDT)
In-Reply-To: <20130622174122.GA6496@inner.h.apk.li>
X-Google-Sender-Auth: w4lQ19c1BNdWMaFBgeA5TNgqhOo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228735>

On Sat, Jun 22, 2013 at 1:41 PM, Andreas Krey <a.krey@gmx.de> wrote:
> diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
> index 223f731..007d3fc 100644
> --- a/Documentation/git-daemon.txt
> +++ b/Documentation/git-daemon.txt
> @@ -113,6 +113,10 @@ OPTIONS
>         Log to syslog instead of stderr. Note that this option does not imply
>         --verbose, thus by default only error conditions will be logged.
>
> +--no-syslog::
> +       Disable the implicit --syslog of --inetd and --deatch, thus keeping

s/deatch/detach/

> +       error output on stderr.
> +
>  --user-path::
>  --user-path=<path>::
>         Allow {tilde}user notation to be used in requests.  When
