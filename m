From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/8] Makefile: add NEEDS_RESOLV to optionally add -lresolv to compile arguments
Date: Sat, 06 Jun 2009 00:29:34 -0700 (PDT)
Message-ID: <m3y6s54y8g.fsf@localhost.localdomain>
References: <7vk53vlxhz.fsf@alter.siamese.dyndns.org>
	<67hZHClrEWQHxCRdWosE25_CVQVNIYpTaeW2DKuCCDfW4h-jHQ82zlGcCNn49KcxUKsj-TSJSVQ@cipher.nrlssc.navy.mil>
	<67hZHClrEWQHxCRdWosE24eNsO0do05033zPcGsXrwIRCoU8GtXor_XD8ayKlybu-V7PGeTC_PA@cipher.nrlssc.navy.mil>
	<67hZHClrEWQHxCRdWosE21Y219yACHqb_DoUmykc1kiOxwRuziSDMczTdmGkyEob9g6DVoIraR4@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
	Brandon Casey <drafnel@gmail.com>,
	Ralf Wildenhues <Ralf.Wildenhues@gmx.de>,
	David Syzdek <david@syzdek.net>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Sat Jun 06 09:30:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCqLa-0000hV-MA
	for gcvg-git-2@gmane.org; Sat, 06 Jun 2009 09:29:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751516AbZFFH3i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jun 2009 03:29:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750860AbZFFH3h
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jun 2009 03:29:37 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:20084 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750793AbZFFH3h (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jun 2009 03:29:37 -0400
Received: by fg-out-1718.google.com with SMTP id d23so392556fga.17
        for <git@vger.kernel.org>; Sat, 06 Jun 2009 00:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=Mtp4ltBYKTD1LbKDpV08ftF1HHm14y7ZoOMzxIfM7a8=;
        b=w7u7IX4BFyq5q5obFPMT3ERF3s9DNvixa3XEM/9H5y2RJoYKwbtrQJqOWZL0BZTjlw
         skGPzX4Eh+uiEMpQG3ANt6u5hxl2unAvY8KqNoMyxoOjv9ReR5St78ryGl8pfaqJj6qX
         30jUF5qWqVzxLN3d+SbalO0S0dmg6cqbJ67Y0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=vRdcyvlXMp35XIRVqgjQa3uJr5m6RhsUVhP3YpYqVY95oZZhdyv2a2Gha3XDuQ8bs2
         A3sRhfcoqbXDBkbV0CUcv9kAhv+B426ssxbzYVcA7LsPv9jO4sOeh/g87BSd1hD3Hayh
         zZ8Itn0hMVbj51MSZb7kHAebEGmPRuQQy+1IQ=
Received: by 10.86.68.1 with SMTP id q1mr4755560fga.34.1244273377041;
        Sat, 06 Jun 2009 00:29:37 -0700 (PDT)
Received: from localhost.localdomain (abwo21.neoplus.adsl.tpnet.pl [83.8.238.21])
        by mx.google.com with ESMTPS id d4sm1554535fga.24.2009.06.06.00.29.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 06 Jun 2009 00:29:34 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n567TQvA030614;
	Sat, 6 Jun 2009 09:29:28 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n567SmVt030597;
	Sat, 6 Jun 2009 09:28:48 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <67hZHClrEWQHxCRdWosE21Y219yACHqb_DoUmykc1kiOxwRuziSDMczTdmGkyEob9g6DVoIraR4@cipher.nrlssc.navy.mil>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120878>

Brandon Casey <casey@nrlssc.navy.mil> writes:

> From: Brandon Casey <drafnel@gmail.com>
> 
> This library is required on Solaris when compiling with NO_IPV6 since
> hstrerror resides in libresolv.  Additionally, Solaris 7 will need it,
> since inet_ntop and inet_pton reside there too.
> 
> Signed-off-by: Brandon Casey <drafnel@gmail.com>
> ---
>  Makefile |   11 ++++++++++-
>  1 files changed, 10 insertions(+), 1 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index baa05f5..40642f7 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -95,6 +95,10 @@ all::
>  # Define NEEDS_SOCKET if linking with libc is not enough (SunOS,
>  # Patrick Mauritz).
>  #
> +# Define NEEDS_RESOLV if linking with -lnsl and/or -lsocket is not enough.
> +# Notably on Solaris hstrerror resides in libresolv and on Solaris 7
> +# inet_ntop and inet_pton additionally reside there.
> +#
>  # Define NO_MMAP if you want to avoid mmap.
>  #
>  # Define NO_PTHREADS if you do not have or do not want to use Pthreads.

Could you please add this build configuration variable to configure.ac
and config.mak.in, to be able to autodetect this situation?

CC-ed Ralf Wildenhues and David Syzdek (who hopefully can produce
autoconf patch to squash with this one).
-- 
Jakub Narebski
Poland
ShadeHawk on #git
