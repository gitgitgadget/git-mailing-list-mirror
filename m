From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: [PATCH] Authentication support for pserver
Date: Wed, 19 Dec 2007 09:39:20 +1300
Message-ID: <46a038f90712181239g3c6fe69bs822fd689d4628b5@mail.gmail.com>
References: <87wsrhex4c.fsf@cpan.org>
	 <7vd4t9x2lw.fsf@gitster.siamese.dyndns.org> <87mysdepeh.fsf@cpan.org>
	 <7vir31u210.fsf@gitster.siamese.dyndns.org> <877ijhm1b5.fsf@cpan.org>
	 <46a038f90712180141x2f27e6cei5ef53339fd3f90dc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org,
	martyn@catalyst.net.nz, martin@catalyst.net.nz
To: "=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?=" <avar@cpan.org>
X-From: git-owner@vger.kernel.org Tue Dec 18 21:39:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4jE8-0000XW-PF
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 21:39:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752744AbXLRUjW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 15:39:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752768AbXLRUjV
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 15:39:21 -0500
Received: from an-out-0708.google.com ([209.85.132.247]:2785 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751740AbXLRUjV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 15:39:21 -0500
Received: by an-out-0708.google.com with SMTP id d31so671721and.103
        for <git@vger.kernel.org>; Tue, 18 Dec 2007 12:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=em/fYxsDXP3lNBLlVbA3ixj5pI0Eh+/aio6M9zWB3SE=;
        b=LdCnEXJu+ELaEi6y71c2tKrE4UVLT0jVtrWWvZ9jd1A+uBEIZL9Ym7IrIdrwVa6WP8TamUXwdeFQ+RjzqBauusb5eJMEEa07/xRfkEhs+g+otUdaaNMadNXG6uiMb064j8UqCIvOAZdTgpTl4SD2YgkgnnM7qcFy9i30gQIkQL8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VctoSEkPkUQzADz8ML0MnAVBMFxMf/PvMGGy6kSFKcRUoNQMZbu/EXlDkoPMX5LYTfxlNfS6zZZO29T6q8OjuoTs3wla1YITVulTMtoiAx/axGDeaZk0dBHTBBHubf3HOO3ZiteQ4CWZrlaZp2MezpZuJk7NmHIHrsy7r6/uzTo=
Received: by 10.100.205.9 with SMTP id c9mr18500633ang.17.1198010360291;
        Tue, 18 Dec 2007 12:39:20 -0800 (PST)
Received: by 10.100.172.20 with HTTP; Tue, 18 Dec 2007 12:39:20 -0800 (PST)
In-Reply-To: <46a038f90712180141x2f27e6cei5ef53339fd3f90dc@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68807>

On Dec 18, 2007 10:41 PM, Martin Langhoff <martin.langhoff@gmail.com> wrote:
>  - git/config is very likely to be readable if the site is served via
> other means, like dumb http protocol, or git+ssh. So even if the
> password scrambling is mickey-mouse. it might make sense to force the
> password data to live elsewhere.

On this aspect, I see no reason why we wouldn't have the passwords
crypt()ed or SHA1'd. Perl includes crypt() in the default
distribution, so it wouldn't add any dependency.

The protocol may be ROT13'ing the passwords, but we don't have to
double-ROT13 them in our storage format ;-)

cheers,


martin
