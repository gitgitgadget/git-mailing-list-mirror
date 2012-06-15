From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/2] i18n: Add extra -- to seperate gettext and message
Date: Fri, 15 Jun 2012 12:41:49 -0500
Message-ID: <20120615174149.GG10752@burratino>
References: <1338764967-30103-1-git-send-email-worldhello.net@gmail.com>
 <1338764967-30103-2-git-send-email-worldhello.net@gmail.com>
 <CACBZZX5EGvJm0aqG5iVn7wnoqFATUqP4gbS-2tnAiLqeFQZifg@mail.gmail.com>
 <CANYiYbFx=Z7TTYUbAhzgHFYB6O_grROWoWHbtuhuABeXdFk4-Q@mail.gmail.com>
 <7vpq9ft3ls.fsf@alter.siamese.dyndns.org>
 <CANYiYbGnoZDMkOq-goaPO98L4Ar1HzMVS-JjjBz7rNHVgv4ywQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Git List <git@vger.kernel.org>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 15 19:42:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SfaXa-0006jW-KL
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jun 2012 19:42:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756702Ab2FORm0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Jun 2012 13:42:26 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:38218 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756660Ab2FORmY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Jun 2012 13:42:24 -0400
Received: by yhmm54 with SMTP id m54so2692764yhm.19
        for <git@vger.kernel.org>; Fri, 15 Jun 2012 10:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=qi9ABaON/BfNfpPEALogQOsWIpag4vMlNqrKCyusYmQ=;
        b=FqNwtWYprnR+FEfeoz4IS0/mR/I8yyxMk2Eq0KGsSSD+H2QBTfWoYm/VELwNwdPbNv
         Ru6CynLXYUa+H9/NHhpd8+/0vaFzeoE1dnl/bMFNoAOi26QX3OtPj2583xeH+4P9JKfb
         GohtXYazAfvPV/y0E/fovn1OHUuF3+ETJ9q5bH3hxoxf3OSbRoDHRDFOfwan6bBTUrJF
         +sWOtC9ZLrGj1huicvRNjja4KOnzDmc2BOCuJyNjnk+LKdfHKjvHM9SHd7qrbBB2Yn5I
         eiticuXkQhJFTGNa3LUqM9zioUdCPaIO/NI8vrx8Obun3Nf/o0PnIMCgvzpSBLPBnEJc
         LENg==
Received: by 10.50.41.226 with SMTP id i2mr2950900igl.4.1339782143711;
        Fri, 15 Jun 2012 10:42:23 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id uy3sm1800830igc.14.2012.06.15.10.42.22
        (version=SSLv3 cipher=OTHER);
        Fri, 15 Jun 2012 10:42:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANYiYbGnoZDMkOq-goaPO98L4Ar1HzMVS-JjjBz7rNHVgv4ywQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200069>

Jiang Xin wrote:

> I saw =C3=86var's bug report on xgettext to the GNU gettext list:
>
>  * http://git.661346.n2.nabble.com/GETTEXT-BUG-xgettext-1-can-t-extra=
ct-quot-gettext-foo-quot-td7560744.html
>
> May be post to a more official mailing list, such as bug-gnu-utils at
> https://lists.gnu.org/mailman/listinfo/bug-gnu-utils will get some re=
sponse,

I think bug-gettext is the right place:
http://lists.gnu.org/archive/html/bug-gettext/2012-06/msg00003.html

> but I doubt there won't be a clear resolution in xgettext.

The double negative is leaving me confused. :)  Are you saying you
doubt that anyone will come up with a patch to fix xgettext, or that
you doubt that the result will be satisfactory?

[...]
> Write a wrapper for gettext  and extract messages using
> 'xgettext --keyword=3D<gettext-wrapper>' is a reasonable solution.

=46or what it's worth that does seem to me like the most sensible
workaround in the short term. :/

	gittext () {	# or sane_gettext or literal_gettext or something
		gettext -- "$1"
	}

	gittextln () {
		gettext -- "$1"
		echo
	}

Thanks,
Jonathan
