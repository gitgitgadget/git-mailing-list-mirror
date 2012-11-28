From: Magnus =?iso-8859-1?Q?B=E4ck?= <baeck@google.com>
Subject: Re: Python extension commands in git - request for policy change
Date: Wed, 28 Nov 2012 10:39:56 -0500
Message-ID: <20121128153955.GA26588@google.com>
References: <20121125024451.1ADD14065F@snark.thyrsus.com>
 <CAMP44s18MzmWRNRiRjL6hvpK1cm=S-97fB2ep-_0RAhnfs5cvA@mail.gmail.com>
 <50B1F684.5020805@alum.mit.edu>
 <CAMP44s0WYiV3hTE7u28_Wd59FkGfu3o_psS0gocpnibzN4--Fg@mail.gmail.com>
 <20121127143510.GA15831@google.com>
 <CAMP44s10krOPD73dL0Ancie=kussk89jK7V5adR3hw=a73CVWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	"Eric S. Raymond" <esr@thyrsus.com>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 16:40:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdjkL-0002gV-HS
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 16:40:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754037Ab2K1PkA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Nov 2012 10:40:00 -0500
Received: from mail-lb0-f202.google.com ([209.85.217.202]:52928 "EHLO
	mail-lb0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753224Ab2K1Pj7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2012 10:39:59 -0500
Received: by mail-lb0-f202.google.com with SMTP id i15so955160lbo.1
        for <git@vger.kernel.org>; Wed, 28 Nov 2012 07:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=xt8NtjPZuje6hYuwhsm0zdbrlq0T4xDUPQ+Lk8brVMA=;
        b=HtHW/OyLaQyfPJA7YMWeyoDQjKcB5yKC+F1/mvqEA/CtXVjWTJyuuZJXTXN2+0fOxE
         +FGESXOQZF8Ei03jPyR10Zb788wtw8kZDdYjtukcNKvdIV2E0SCdoFGLxiOjMURNOpXS
         Cp7gJoh1MKQiBxNtnt0jgqUnCDfj7PEElQgh7bNYMppirZHXZq/oHciUjtpSFdduie7Y
         eTYfvVz7ODIFl8R0FZ6ESp5ygYnMJf8fDr9pEJQVBEeDXHILGgt7NQS2BEJFsKkBY2sQ
         BC/lliQHDd9U9P2pP5+SmdUmdsBfTxfKLGPm48TGiVBsbNtWGHjIL0rzQPob1fjWjv6+
         xRkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent:x-gm-message-state;
        bh=xt8NtjPZuje6hYuwhsm0zdbrlq0T4xDUPQ+Lk8brVMA=;
        b=o6Qszbxv9v+qhogjgNM5+Jg6MbJtDIEUQj6qWAxs7cJCmrfQDl5KYD+w/SaI5L4J+R
         SkGvqKmmr9TeVD5HXJjD+21X1RWe7P2VycPpy607wfTr6EkA9OBw6s5E2QaIw65/ht3o
         2NRv4/ayfaFBQUseDHlHssQaNyC2EVQ6jNXVVh6n2PQ5xi4sBPkDreAS1DAolzreZMVN
         HEpQFTO8Gey2u+FVylqyhAH+r1y8q142tWCqY9Nyjrb3tceHA+BYaJEhB42UKCRfwreq
         /p/HmPNzOoqU+wmsw6sP8Hlyx4b2oUe8/fRlNahcyF89wxIm7VVppvrIW3RbtCv7RuAE
         RDNQ==
Received: by 10.14.0.196 with SMTP id 44mr215279eeb.6.1354117197457;
        Wed, 28 Nov 2012 07:39:57 -0800 (PST)
Received: from hpza10.eem.corp.google.com ([74.125.121.33])
        by gmr-mx.google.com with ESMTPS id u8si5272480een.1.2012.11.28.07.39.57
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Wed, 28 Nov 2012 07:39:57 -0800 (PST)
Received: from valle.nyc.corp.google.com (valle.nyc.corp.google.com [172.26.78.170])
	by hpza10.eem.corp.google.com (Postfix) with ESMTP id 2CD92200057;
	Wed, 28 Nov 2012 07:39:57 -0800 (PST)
Received: by valle.nyc.corp.google.com (Postfix, from userid 159662)
	id 728AE60FFE; Wed, 28 Nov 2012 10:39:56 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <CAMP44s10krOPD73dL0Ancie=kussk89jK7V5adR3hw=a73CVWw@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Gm-Message-State: ALoCoQm2eedoUjTvUb+eHcsDRsKnC3ffLyjZp1j+AW4x/dyqWvYQrNk6PGRhIv/JsaqyDhVXvoQ5UYQ3fcibaP8QwJC1nT9fOt7rFYYUj1V4ol4ZgQiNspTfV5H+pAzM991tzbDBPmcrVncRNgEiIRPe1jgFKTQHoh9Cv3wQJGdua0w/i1bah6T/aaqxOR1kRdmwyLpKpP9b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210737>

On Tuesday, November 27, 2012 at 19:10 EST,
     Felipe Contreras <felipe.contreras@gmail.com> wrote:

> On Tue, Nov 27, 2012 at 3:35 PM, Magnus B=E4ck <baeck@google.com> wro=
te:
>
> > While "constant traffic" probably overstates the issue, these are
> > not theoretical problems. I recall at least three cases in the last
> > year or so where Git has seen breakage with Solaris or Mac OS X
> > because of sed or tr incompatibilities, and I don't even read this
> > list that thoroughly.
>
> Most of the *constant* traffic is about *theoretical*
> incompatibilities, how much of that are real incompatibilities, it's
> not known. _Some_ of the traffic is about real incompatibilities,
> sure, but you could count only three cases *in a year*. It's not a
> huge amount. And then, how man this year?
>
> Also, I would like references to those incompatibilities.

I don't remember the details of the Mac OS X problem, but just searchin=
g
the archives for "xpg4" revealed the following Solaris problems since
April:

http://article.gmane.org/gmane.comp.version-control.git/195010
http://article.gmane.org/gmane.comp.version-control.git/195966
http://article.gmane.org/gmane.comp.version-control.git/207944

--=20
Magnus B=E4ck
baeck@google.com
