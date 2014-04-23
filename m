From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] Git v2.0.0-rc0
Date: Wed, 23 Apr 2014 09:40:35 -0700
Message-ID: <xmqqtx9k0zjw.fsf@gitster.dls.corp.google.com>
References: <xmqqk3ambf9k.fsf@gitster.dls.corp.google.com>
	<475e137b5095e45c92a87a9969f58f0@74d39fa044aa309eaea14b9f57fe79c>
	<20140422185829.GB15516@google.com>
	<xmqq4n1l3yyf.fsf@gitster.dls.corp.google.com>
	<20140422210002.GC15516@google.com>
	<xmqqy4yx2gz9.fsf@gitster.dls.corp.google.com>
	<20140422221148.GD15516@google.com>
	<20140422222519.GC144079@vauxhall.crustytoothpaste.net>
	<xmqqbnvt2d7v.fsf@gitster.dls.corp.google.com>
	<CALKQrgd0Psp0nWUsmW16aR4io4xu_gumJmRdLGU+MOSzJvBobQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"Kyle J. McKay" <mackyle@gmail.com>,
	Git mailing list <git@vger.kernel.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Apr 23 18:40:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wd0E7-0007Ke-AP
	for gcvg-git-2@plane.gmane.org; Wed, 23 Apr 2014 18:40:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756047AbaDWQkp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2014 12:40:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51265 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755959AbaDWQkk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2014 12:40:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6DB0A7DB9D;
	Wed, 23 Apr 2014 12:40:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=k4Ii301MI9YnSexAe0Fd88hI3lg=; b=dN4d0h
	uOCtUQ0GeFGlGWUmxqJu+26DlTugTRQerR+pZQu2XE+wJhZ0/S1ktLT4lGTEPexC
	EoVK+9qwy9B6hw04H4Rhz2bkmIZ1kc7geWjTvuDZ0zg2kufFEUzcZ3JFElnbxNLN
	gPwaKZ4chtpcjzdENN9TXFAWoGmcPZBdSf5Ms=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tLzWqF1u9B9Mzr5z52yflnro73Oq53zs
	uoo1zWoM80jgZpmAK41aNGXDgGFjUJJ4QbFQwQDTvZE4IIByefq35E77yzSN8fiB
	nYVATB6gyv3sr4rK6JnfwbwFHdJwTNzbMAULdUQZ4NMjM4g/2Dt+wgJVal+Xj/ug
	6MlazkxBssA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 46F957DB9C;
	Wed, 23 Apr 2014 12:40:39 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4953A7DB98;
	Wed, 23 Apr 2014 12:40:37 -0400 (EDT)
In-Reply-To: <CALKQrgd0Psp0nWUsmW16aR4io4xu_gumJmRdLGU+MOSzJvBobQ@mail.gmail.com>
	(Johan Herland's message of "Wed, 23 Apr 2014 09:33:40 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: FF85038A-CB05-11E3-95D4-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246849>

Johan Herland <johan@herland.net> writes:

> I.e. use Kyle's patch to t9117, plus something like this:
>
> diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
> index 5b3c38d..9f579e0 100644
> --- a/Documentation/git-svn.txt
> +++ b/Documentation/git-svn.txt
> @@ -91,6 +91,9 @@ COMMANDS
>  NOTE: Before Git v2.0, the default prefix was "" (no prefix). This
>  meant that SVN-tracking refs were put at "refs/remotes/*", which is
>  incompatible with how Git's own remote-tracking refs are organized.
> +If you still want the old default, you can get it by passing
> +'--prefix ""' on the command line ('--prefix=""' may not work if
> +your Perl's Getopt::Long is < v2.37).
>
>  --ignore-paths=<regex>;;
>         When passed to 'init' or 'clone' this regular expression will

Thanks, will squash in.
