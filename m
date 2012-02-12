From: Junio C Hamano <gitster@pobox.com>
Subject: Re: 1.7.9, libcharset missing from EXTLIBS
Date: Sun, 12 Feb 2012 02:30:43 -0800
Message-ID: <7vfwegl4x8.fsf@alter.siamese.dyndns.org>
References: <4F3472F4.4060605@aegee.org>
 <7v1uq3toyq.fsf@alter.siamese.dyndns.org>
 <CACBZZX45=mr=FMqFF+Pw4KPaDAtvs-ePLbFATpyFA93vSfZatw@mail.gmail.com>
 <4F34EF9D.8030509@aegee.org> <7vipjer0yn.fsf@alter.siamese.dyndns.org>
 <7vd39mph9x.fsf@alter.siamese.dyndns.org> <4F370DE5.70400@aegee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?iso-2022-jp?B?GyRCJyUnWiddJ3EnXxsoQiAbJEInMSdRJ10nUSdlJ1knYCdTGyhC?= 
	<dilyan.palauzov@aegee.org>
X-From: git-owner@vger.kernel.org Sun Feb 12 11:31:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RwWht-0006km-9I
	for gcvg-git-2@plane.gmane.org; Sun, 12 Feb 2012 11:30:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751940Ab2BLKat convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 Feb 2012 05:30:49 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62983 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751866Ab2BLKaq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Feb 2012 05:30:46 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 04B8528C7;
	Sun, 12 Feb 2012 05:30:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=GyeTLhj7CExB
	fCvlqjNP587s3qk=; b=rq/nwnOV5GWIHey+bHb7qRw8O7Y5t3ZPteqa49ya0Brl
	3JrVPa8JHmQI9sTnKEVHq4bWkFRFNmeXgZMT6uNpAv9rNqfpyqcx5Au4yruzODMK
	BlymzgT2TmI7t5dZpZ07T4k5ISQHGCpBBQWph/rRvsMpKGR526+ll/De9SqZ0dk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=aNx7Br
	KBfIm56k3xmh3eETw85Wk4INQmnr9XMCzTn7Ge/rcz/aof1vUJTqRC9VzPFRS7Nx
	dVnQ7G2S3g8t/B1kkb18F8IXlAQO7hM5tLlg8c/AlrmEo4rKHZfq+bRqMsYXyJeL
	Rf9IR9dFlMMpW8Q4QjlVV50FRQ24VyIUw+Mnc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F04D628C6;
	Sun, 12 Feb 2012 05:30:45 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 769C228C5; Sun, 12 Feb 2012
 05:30:45 -0500 (EST)
In-Reply-To: <4F370DE5.70400@aegee.org> (=?iso-2022-jp?B?IhskQiclJ1obKEI=?=
 =?iso-2022-jp?B?GyRCJ10ncSdfGyhCIBskQicxJ1EnXSdRJ2UnWSdgJ1MbKEIiJ3M=?=
 message of "Sun, 12 Feb 2012 01:55:01 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9F442672-5564-11E1-A4A5-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190565>

=D0=94=D0=B8=D0=BB=D1=8F=D0=BD =D0=9F=D0=B0=D0=BB=D0=B0=D1=83=D0=B7=D0=BE=
=D0=B2  <dilyan.palauzov@aegee.org> writes:

> diff -u git-1.7.9.orig/config.mak.in git-1.7.9/config.mak.in
> --- git-1.7.9.orig/config.mak.in        2012-01-27 20:51:04.000000000=
 +0000
> +++ git-1.7.9/config.mak.in     2012-02-12 00:52:41.457968080 +0000
> @@ -74,3 +74,4 @@
>  NO_PTHREADS=3D@NO_PTHREADS@
>  PTHREAD_CFLAGS=3D@PTHREAD_CFLAGS@
>  PTHREAD_LIBS=3D@PTHREAD_LIBS@
> +LINK_CHARSET=3D@LINK_CHARSET@
> diff -u git-1.7.9.orig/configure.ac git-1.7.9/configure.ac
> --- git-1.7.9.orig/configure.ac 2012-01-27 20:51:04.000000000 +0000
> +++ git-1.7.9/configure.ac      2012-02-12 00:44:29.222967868 +0000
> @@ -836,6 +836,18 @@
>  [HAVE_LIBCHARSET_H=3DYesPlease],
>  [HAVE_LIBCHARSET_H=3D])
>  AC_SUBST(HAVE_LIBCHARSET_H)
> +# Define LINK_LIBCHARSET if libiconv does not export the

Because the use of configure is optional in our build infrastructure, I
wouldn't have objected if this comment were missing from configure.ac, =
but
the new variable *must* be described in Makefile (see the top 250 lines=
 or
so of that file).

I also need to point out that LINK_LIBCHARSET does not sit very well wi=
th
the way how existing Makefile variables are named. Perhaps make the new
variable contain the necessary string ("-lcharset" in your case), and n=
ame
it CHARSET_LIB or something?  By doing so, when we find a platform that
has the necessary locale_charset() not in libcharset.{a,so} but somewhe=
re
else, e.g. libxyzzy.a, we can accomodate it with "CHARSET_LIB =3D -lxyz=
zy".

Thanks.  Also as =C3=86var pointed out, please do not forget to sign of=
f your
patch.
