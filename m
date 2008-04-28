From: "David Symonds" <dsymonds@gmail.com>
Subject: Re: [PATCH] Use perl instead of tac
Date: Mon, 28 Apr 2008 23:12:43 +1000
Message-ID: <ee77f5c20804280612o3db1fb86nf089e2201f688d2f@mail.gmail.com>
References: <8D73338C-4EC3-4078-8A34-51DAC1842C2B@silverinsanity.com>
	 <20080427064250.GA5455@sigill.intra.peff.net>
	 <739FA851-F7F5-4CF9-B384-25AA7022B0C2@silverinsanity.com>
	 <slrng1be8l.25r.joerg@alea.gnuu.de>
	 <86k5iib0g9.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "=?ISO-8859-1?Q?J=F6rg_Sommer?=" <joerg@alea.gnuu.de>,
	git@vger.kernel.org
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
X-From: git-owner@vger.kernel.org Mon Apr 28 15:13:35 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqTAk-0000l9-1Z
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 15:13:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932452AbYD1NMp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Apr 2008 09:12:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932440AbYD1NMp
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 09:12:45 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:10734 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763140AbYD1NMo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Apr 2008 09:12:44 -0400
Received: by fg-out-1718.google.com with SMTP id l27so4942292fgb.17
        for <git@vger.kernel.org>; Mon, 28 Apr 2008 06:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=qmH7WjjGPHy5q3+lTRsWrekhySa4u6hdJoQ/GgEVESg=;
        b=GqDeGAD3Y4/Z6TIfneMuUHywjqyNVJpd5pS9TT/mvqYyM707skO09eABNGcyCYuHWMsztWCHLpFQ4OQYEUwR4wMeyWETVJOWzfF4KaJ1AVxEHZx32+DZdno0madgPvo6rHrTEUvy+P9GG/19ZGuaLw62t/QXzsn1g/pN8ZczkIo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EWPHQDE34KYXnjLy+xdk6BMcsSxd+56ghsals+cLzwjRZ8KtTAZSAJd4GQlXdhNqsqc1cwIPFamWuK0a4ZaiT7LITxmG0C2SfPhvv7BZ/kOZf6cf9wHHln+yeWLfCJI11vyk6yrTjsx1kUQrSNnOUs6JJuexKkMkJU6+YAsPYn0=
Received: by 10.86.78.4 with SMTP id a4mr7188428fgb.73.1209388363361;
        Mon, 28 Apr 2008 06:12:43 -0700 (PDT)
Received: by 10.86.96.12 with HTTP; Mon, 28 Apr 2008 06:12:43 -0700 (PDT)
In-Reply-To: <86k5iib0g9.fsf@blue.stonehenge.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80531>

On Mon, Apr 28, 2008 at 10:58 PM, Randal L. Schwartz
<merlyn@stonehenge.com> wrote:
> >>>>> "J=F6rg" =3D=3D J=F6rg Sommer <joerg@alea.gnuu.de> writes:
>
>  J=F6rg> What about using a shell function and a *big* variable or an=
 intermediate
>  J=F6rg> file?
>
>  What makes you think that's any more faster or efficient than callin=
g Perl
>  at this point?

I doubt J=F6rg suggested it for its speed, but it removes the dependenc=
y on Perl.

Bit ugly, still.


Dave.
