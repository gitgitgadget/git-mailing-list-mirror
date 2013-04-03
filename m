From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH V3 5/5] Help doc: Include --guide option description
Date: Tue, 2 Apr 2013 22:28:17 -0400
Message-ID: <CAPig+cRuz7m9CuGvhs5xDbH87+oPTt2XbchfW6EtFdTfN55rOg@mail.gmail.com>
References: <1364942392-576-1-git-send-email-philipoakley@iee.org>
	<1364942392-576-6-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: GitList <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	"W. Trevor King" <wking@tremily.us>,
	David Aguilar <davvid@gmail.com>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Wed Apr 03 04:28:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNDRR-0001jB-7B
	for gcvg-git-2@plane.gmane.org; Wed, 03 Apr 2013 04:28:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760736Ab3DCC2U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 22:28:20 -0400
Received: from mail-lb0-f170.google.com ([209.85.217.170]:47454 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757573Ab3DCC2T (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 22:28:19 -0400
Received: by mail-lb0-f170.google.com with SMTP id x11so1113869lbi.1
        for <git@vger.kernel.org>; Tue, 02 Apr 2013 19:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=CbYgwKqIKgmKUVcLPbpDsL4SxGh3dXaIOZkLRA4u3Yo=;
        b=GDZFYP24yJhvm8IcXqlGwortB7cJ5UMRJ2uL2s2nr04Nqnpgqcmyh3AIOxcTRz1PfJ
         3IswxUjCMVhhIEGXU7Cr9vmJCEzRKTkZV7UAUau6UQ70GpT15kzqoVH7XYQW8mqRSNG7
         oHMZa8AciGZ5Mn5eOt9jpmkAcpJD6PyjxgOMIA6qQ5/AHoI3MB1a7mOrRZBe+SDIGtEv
         umOEVBO9yDowIMLCI5jJ3hNuWqgtm7m0BtAfj0rI365A8e0Oi94TAylnlaF0ASHLzcA1
         buunD/EzBsLCdWdWcA0rKpj+3s8K9Ep3tUndEU0kw9vkB3UXpgVZ679qvQbiUORlbmnM
         1UtQ==
X-Received: by 10.112.146.133 with SMTP id tc5mr111878lbb.88.1364956098051;
 Tue, 02 Apr 2013 19:28:18 -0700 (PDT)
Received: by 10.114.1.43 with HTTP; Tue, 2 Apr 2013 19:28:17 -0700 (PDT)
In-Reply-To: <1364942392-576-6-git-send-email-philipoakley@iee.org>
X-Google-Sender-Auth: PdACUxUDbH49b8rll6udfl3K1Sk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219910>

On Tue, Apr 2, 2013 at 6:39 PM, Philip Oakley <philipoakley@iee.org> wrote:
>  OPTIONS
>  -------
>  -a::
>  --all::
>         Prints all the available commands on the standard output. This
> -       option supersedes any other option.
> +       option overides any given command or guide name.

s/overides/overrides/

> +
> +-g::
> +--guides::
> +       Prints a list of useful guides on the standard output. This
> +       option overides any given command or guide name.

Ditto: s/overides/overrides/
