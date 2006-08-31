From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: problem with git-cvsserver
Date: Fri, 1 Sep 2006 11:00:47 +1200
Message-ID: <46a038f90608311600p747c8a3anbe90dbac928e9923@mail.gmail.com>
References: <44F5B2A7.8070501@gmail.com>
	 <Pine.LNX.4.63.0608301904360.28360@wbgn013.biozentrum.uni-wuerzburg.de>
	 <44F5D6F8.50307@gmail.com> <7vlkp6gh6e.fsf@assigned-by-dhcp.cox.net>
	 <46a038f90608301329n14df4dd2tb1563cc48662cd14@mail.gmail.com>
	 <20060831090333.GA28445@fiberbit.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>,
	aonghus <thecolourblue@gmail.com>, git@vger.kernel.org,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Sep 01 01:00:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GIvWn-0003JN-I8
	for gcvg-git@gmane.org; Fri, 01 Sep 2006 01:00:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964806AbWHaXAu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 31 Aug 2006 19:00:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964811AbWHaXAu
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Aug 2006 19:00:50 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:14029 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S964806AbWHaXAt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Aug 2006 19:00:49 -0400
Received: by nf-out-0910.google.com with SMTP id x30so545910nfb
        for <git@vger.kernel.org>; Thu, 31 Aug 2006 16:00:48 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=l+vPlikUwCmCf4A6QkVGiZzKCYGBfm8As/1A/eJOEBY1vV2JXaSqd1UXp73+fOjXNdWOTZhfX2VIKZtVTG4V1gyJ1ZdROlHR9h49F44ZaAaMKR+qr+eOIqMWKoNFqK56hUIfMlUzmYytxOiWaloF4NfpGNl7zi/0pyJ/Hs4u82w=
Received: by 10.49.10.3 with SMTP id n3mr2210621nfi;
        Thu, 31 Aug 2006 16:00:47 -0700 (PDT)
Received: by 10.49.6.16 with HTTP; Thu, 31 Aug 2006 16:00:47 -0700 (PDT)
To: "Marco Roeland" <marco.roeland@xs4all.nl>
In-Reply-To: <20060831090333.GA28445@fiberbit.xs4all.nl>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26284>

On 8/31/06, Marco Roeland <marco.roeland@xs4all.nl> wrote:
> Yes, SQLite v2 and SQLite v3 are different and binary incompatible.
>
> However, on Debian 'etch' you can install packages for both versions
> concurrently; most packages for SQLite have either a '2' or a '3' in the
> name. Packages without the number use the "best current choice" which is
> "3" in 'etch' at the moment but was "2" not too long ago.

Thanks for the info!

I have to say though: Ouch. Do you know if there's an upgrade path for
apps? Does v3 detect you've got a v2 file and do something smart
(upgrade in place / spit out a readable error)?

...

> I'd guess that you were unfortunate enough to just install some packages
> during the transition

Problem is that we have to help with the transition for users that
started with v2 and get upgraded to v3 at the app level I suspect.

> Incidentally I'd guess that in itself SQLite2 (so version 2) would also
> function perfectly well for git-cvsserver (as would PostgreSQL or
> MySQL)

This was developed against v2. If v3 is backwards compatible, it'll
just work. If not... we'll hear about it soon ;-) Pg/MySQL aren't
really supported, though it wouldn't be that hard.



martin
