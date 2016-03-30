From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] MSVC: vsnprintf in Visual Studio 2015 doesn't need
 SNPRINTF_SIZE_CORR any more
Date: Wed, 30 Mar 2016 09:49:42 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1603300946410.4690@virtualbox>
References: <56FAAC78.2040304@cs-ware.de> <CAHGBnuP1Y1F-CrQJx9zNKSv1KP7gH86WSKo7tbmcYT3Vf2cQ_g@mail.gmail.com> <56FAD3DD.4060009@cs-ware.de> <CAHGBnuNkuiyk1uvJqT1_1UWOhpVTg+TxJ2QvepuMBpvOD8AyFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Sven Strickroth <sven@cs-ware.de>, Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>, blees@dcon.de
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 30 09:50:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alAtF-00035x-A1
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 09:50:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758675AbcC3HuD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2016 03:50:03 -0400
Received: from mout.gmx.net ([212.227.15.15]:58340 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754104AbcC3HuB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2016 03:50:01 -0400
Received: from virtualbox ([37.24.143.127]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MexFh-1aMnL40PrV-00OZ91; Wed, 30 Mar 2016 09:49:43
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <CAHGBnuNkuiyk1uvJqT1_1UWOhpVTg+TxJ2QvepuMBpvOD8AyFw@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:fbxNxPkJRN1qiV/x8x9ViQ7UA0XBUPzQeG3/Re3cwTWlAGGUZav
 lDfDk69BFhd78SELU/mEy2wnxPqEr3mOBUBfWErAcZGRd6RK8qy4bAd2rprQt+chtXiaPbG
 iTJo7qeR1WsqT64HeHwCzYbq4YAzlvv6c8Z+0J9ixpnrkKgSMup93QH3RTDVnNZMD8A5twd
 yGuNUwzDsnAKwMg+aj80A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9WoRgOgRwP4=:mjCTW74LGcMjXif9dlC9d2
 mW2OfEx5Sk49+PYBFHmvB8qY8LFwpaZpMHUPZMdguRrybUmX+IQyWH4b5eEGRnN9sFXnjT481
 EkGOHYtECFUyjU0cC/cAnft9Fb2EsZYTYuOaoaDFkG0kmgEU6nWjE4BazkZUGyamJC7K3nMDm
 Q05p470Cjo/FKNUU3ji8xyiEv0zWB/Ke6pYbz+isKJh8uGbgNEBIYGOsMUS3DYdqjuSVzHnHS
 zlNvClJGkaRd7zIVk9icRn3/aKd3PXpfCMECSbczQyf7+xYCp+tOFE5NJD9NxGGCl4eaCMFC6
 zmh2Jurw0Mvu5YA6VNXfRt4EtB/Vjw0d3mp8g1hEtqJOEf3hNkP03OMqZ24JmzfUfKuHsGeWX
 /WAQNHBnrz6ySoeatnfIZ0LRSvTeVlUx+GUeHR9mAzlcwldc8HgsTKcM3AcfDQLdCuy/i5GV7
 ITkUPahZLOwRnOBOMLosXX3wwqLillw1rYfKTAjoZC8Bp1E/PEJpn0/2ZIXO3Nj7aLy/LUq3I
 VnqLb+EM7Z3RNfq0oN+oAXPlkDI6Xjvbf6gebra79cqPNLWxbcQg1hfCMrfrTi9EzwxTUf538
 fMNHvqKp6HD6gIF2gvQJNTlBKd1lPi6neRq/ZBw/xYN7E49wXX3jvFk8DDo0Glz7vuKp/c9co
 64VrmeSXF8KfFBhRrFtm+x7wszPT+YHvjW2JeWUMRXVM1SnFLdlOKPjGyjVczfO+pNztORJf2
 FIyNz+Lz26gLrtEAdrqWsqHD4Cw3dvvQH2GQIi+2QK79th7/LW92ApZkp8CizgI7G+0JHU88 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290275>

Hi Sven & Sebastian,

On Tue, 29 Mar 2016, Sebastian Schuberth wrote:

> On Tue, Mar 29, 2016 at 9:13 PM, Sven Strickroth <sven@cs-ware.de> wrote:

ACK on the patch.

> > diff --git a/compat/snprintf.c b/compat/snprintf.c
> > index 42ea1ac..0b11688 100644
> > --- a/compat/snprintf.c
> > +++ b/compat/snprintf.c
> > @@ -9,7 +9,7 @@
> >   * always have room for a trailing NUL byte.
> >   */
> >  #ifndef SNPRINTF_SIZE_CORR
> > -#if defined(WIN32) && (!defined(__GNUC__) || __GNUC__ < 4)
> > +#if defined(WIN32) && (!defined(__GNUC__) || __GNUC__ < 4) && (!defined(_MSC_VER) || _MSC_VER < 1900)
> >  #define SNPRINTF_SIZE_CORR 1
> >  #else
> >  #define SNPRINTF_SIZE_CORR 0
> 
> I wonder if the logic is (and was) sensible here. We assume that every
> non-__GNUC__ and non-_MSC_VER compiler on Windows requires the
> correction. Wouldn't it make sense to not assume requiring the
> correction unless we know the compiler has this bug? That is,
> shouldn't this better say
> 
> #if defined(WIN32) && (defined(__GNUC__) && __GNUC__ < 4) ||
> (defined(_MSC_VER) && _MSC_VER < 1900))
> #define SNPRINTF_SIZE_CORR 1
> #else
> #define SNPRINTF_SIZE_CORR 0

Since the standard on Windows always was MS Visual C, it should be assumed
that compilers *other* than GCC followed Visual C's lead.

Of course, evidence speaks louder than assumptions.

Therefore I would prefer to keep the current version, at least until we
encounter a case where it is incorrect.

Thanks,
Johannes
