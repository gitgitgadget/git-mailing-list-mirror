From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/2] t0303: resurrect commit message as test documentation
Date: Mon, 12 Mar 2012 15:43:40 -0500
Message-ID: <20120312204340.GA10661@burratino>
References: <1331553907-19576-1-git-send-email-zbyszek@in.waw.pl>
 <1331553907-19576-3-git-send-email-zbyszek@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com, Jeff King <peff@peff.net>
To: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Mon Mar 12 21:44:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7C63-00012F-Bx
	for gcvg-git-2@plane.gmane.org; Mon, 12 Mar 2012 21:43:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932103Ab2CLUnz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Mar 2012 16:43:55 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:36930 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932089Ab2CLUny convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Mar 2012 16:43:54 -0400
Received: by iagz16 with SMTP id z16so7349304iag.19
        for <git@vger.kernel.org>; Mon, 12 Mar 2012 13:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=pUFIaaAFx7Bz8ul1OB0J7rjH0Mtpxv5AbFxNWLrXpD8=;
        b=VRETI54XochR5spKYyd4ZcAf9WoF/0/lvwGQAlL4GkACfQYGnPYgqewwtfn4jbXfZw
         XWy0RbOAh9fURs47igux5qpwtYOorf6DaB8scANF8PBPTA/6kQUIB21xvAHRsoDa8Ypa
         3M7m0iFKOQZ1mOa644N2khkOvmo4wY5pTHp5o/Rbu00letLtc8w7n54IEwuLdA5HhPcj
         aKnS+h8bXZVx1MUO4Twpjsp9Jk+OYN/eBGYU9Ep4a9UDfHot0cPhbKsMRyGRSUXZY/J0
         aE8oMyZTjpR21CmTEMhYl4runKo2GVTrX6gMZ0zMkJ68uEONapX4jt5Vct5e2N1ssd24
         tBBQ==
Received: by 10.50.179.40 with SMTP id dd8mr742505igc.29.1331585034050;
        Mon, 12 Mar 2012 13:43:54 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id dl10sm13387022igb.9.2012.03.12.13.43.52
        (version=SSLv3 cipher=OTHER);
        Mon, 12 Mar 2012 13:43:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1331553907-19576-3-git-send-email-zbyszek@in.waw.pl>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192943>

Hi,

Zbigniew J=C4=99drzejewski-Szmek wrote:

> --- a/t/t0303-credential-external.sh
> +++ b/t/t0303-credential-external.sh
> @@ -1,5 +1,23 @@
>  #!/bin/sh
> =20
> +# Test harness for external credential helpers
> +#
> +# This is a tool for authors of external helper tools to sanity-chec=
k
> +# their helpers. If you have written the "git-credential-foo" helper=
,
> +# you check it with:
> +#
> +# GIT_TEST_CREDENTIAL_HELPER=3Dfoo make t0303-credential-external.sh
> +#
> +# This assumes that your helper is capable of both storing and
> +# retrieving credentials (some helpers may be read-only, and
> +# they will fail these tests).
> +#
> +# If your helper supports time-based expiration with a
> +# configurable timeout, you can test that feature with:
> +#
> +#  GIT_TEST_CREDENTIAL_HELPER_TIMEOUT=3D"foo --timeout=3D1" \
> +#      make t0303-credential-external.sh
> +
>  test_description=3D'external credential helper tests'

Nice idea, but shouldn't this description be in test_description so I
can view it by running "sh t0303-credential-external.sh --help"?

Thanks,
Jonathan
