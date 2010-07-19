From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/2] Documentation spelling fixes.
Date: Mon, 19 Jul 2010 18:11:24 -0500
Message-ID: <20100719231123.GA1708@burratino>
References: <1279574238-16649-1-git-send-email-ville.skytta@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Ville =?iso-8859-1?Q?Skytt=E4?= <ville.skytta@iki.fi>
X-From: git-owner@vger.kernel.org Tue Jul 20 01:12:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OazVb-0006ge-1t
	for gcvg-git-2@lo.gmane.org; Tue, 20 Jul 2010 01:12:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967145Ab0GSXMW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Jul 2010 19:12:22 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:44524 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967133Ab0GSXMV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jul 2010 19:12:21 -0400
Received: by qyk35 with SMTP id 35so1950183qyk.19
        for <git@vger.kernel.org>; Mon, 19 Jul 2010 16:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=vcTon3043HKECvo5FbyEGZ3MYiQZKEW0Iybmw8K2Cfg=;
        b=AyzBO8thI0FRShDM7RRY7lB7onIgqALdmgxQcANCYrTngjHrr5C+68AgKHp7upn69Y
         IrHdjfMFCSQQFsigndpguoxmOcTTfruwptk21UPEwuFILeLF9gSjZkiwAyXRd/UnSrFT
         9UPI2ETLmBRf+Fhb+ynARLPsiyAdE54Hrd+2I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=NYitV+qFFgiZNDpA1TF/FEPB0fz1hQ4HoUm279/y08+xag/CNEO2dJneeM+CaMmo7A
         rsjmqK8s2D8RrZzRwQRjwLS+OG9aHgCW+WkxRtGG6bBVnEXZlrm7Fzpkdtjp/u/lPmJU
         B3GJAVqWzQUCvzTRKC0rhklcd2sa7yAsT3dLU=
Received: by 10.224.113.27 with SMTP id y27mr4925750qap.67.1279581140390;
        Mon, 19 Jul 2010 16:12:20 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id js14sm27280817qcb.30.2010.07.19.16.12.18
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 19 Jul 2010 16:12:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1279574238-16649-1-git-send-email-ville.skytta@iki.fi>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151290>

Hi Ville,

Ville Skytt=E4 wrote:

> ---

If this does not end up needing a re-roll, would it be okay for
Junio (or whoever else picks up the patch) to forge your sign-off?
(See "Sign your work" in Documentation/SubmittingPatches for what I
mean.)

> +++ b/Documentation/config.txt
> @@ -418,7 +418,7 @@ Common unit suffixes of 'k', 'm', or 'g' are supp=
orted.
> =20
>  core.deltaBaseCacheLimit::
>  	Maximum number of bytes to reserve for caching base objects
> -	that multiple deltafied objects reference.  By storing the
> +	that multiple deltified objects reference.  By storing the

Huh?  Maybe

	Maximum number of bytes to reserve for caching based objects
	that might be referenced by multiple deltified objects.

Or:

	Amount of memory (in bytes) to reserve for speeding up
	unpacking of deltified objects.  By storing entire
	decompressed base objects in a cache, Git can avoid
	unpacking and decompressing frequently-used base objects
	multiple times.

> @@ -1275,7 +1275,7 @@ instaweb.local::
>  	be bound to the local IP (127.0.0.1).
> =20
>  instaweb.modulepath::
> -	The module path for an apache httpd used by linkgit:git-instaweb[1]=
=2E
> +	The module path for an Apache httpd used by linkgit:git-instaweb[1]=
=2E

Maybe:

	Default module path for linkgit:git-instaweb[1] to use
	instead of /usr/lib/apache2/modules.  Only used if httpd
	is Apache.

> +++ b/Documentation/git-cvsserver.txt
> @@ -366,8 +366,8 @@ CRLF Line Ending Conversions
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> =20
>  By default the server leaves the '-k' mode blank for all files,
> -which causes the cvs client to treat them as a text files, subject
> +which causes the CVS client to treat them as a text files, subject

Should we call the cvs(1) command "the CVS client"?  Maybe
"the cvs(1) client" or something would be clearer, but I
don't see anything wrong with your choice.

> -to crlf conversion on some platforms.
> +to CRLF conversion on some platforms.

This term can be confusing, as we've seen in other contexts.
Maybe:

	subject to line-ending conversion on some platforms.

> +++ b/Documentation/git-hash-object.txt
> @@ -49,7 +49,7 @@ OPTIONS
> =20
>  --no-filters::
>  	Hash the contents as is, ignoring any input filter that would
> -	have been chosen by the attributes mechanism, including crlf
> +	have been chosen by the attributes mechanism, including CRLF
>  	conversion. If the file is read from standard input then this

It's called "end-of-line conversion" in gitattributes(5) now,
apparently.

The rest of this one looks good.  Thanks.
