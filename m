From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH v2] diff -c -p: do not die on submodules
Date: Thu, 30 Apr 2009 07:47:57 +0200
Message-ID: <81b0412b0904292247tdcf515bs67f809b559ac2504@mail.gmail.com>
References: <gt7err$3m4$1@ger.gmane.org>
	 <7v4ow8my1u.fsf@gitster.siamese.dyndns.org>
	 <20090428211257.GA31191@pvv.org> <20090429084209.GA24064@localhost>
	 <7v8wljcmvk.fsf_-_@gitster.siamese.dyndns.org>
	 <7vy6tj8aur.fsf_-_@gitster.siamese.dyndns.org>
	 <81b0412b0904291450w3d292ed5i3b2ab5164c0ae0f4@mail.gmail.com>
	 <alpine.DEB.1.00.0904300011140.10279@pacific.mpi-cbg.de>
	 <81b0412b0904291519m41035200n408b6ab409eed127@mail.gmail.com>
	 <alpine.DEB.1.00.0904300037300.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Clemens Buchacher <drizzd@aon.at>,
	Finn Arne Gangstad <finnag@pvv.org>,
	Tim Olsen <tim@brooklynpenguin.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Apr 30 07:48:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzP8P-0001rc-24
	for gcvg-git-2@gmane.org; Thu, 30 Apr 2009 07:48:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751280AbZD3Fr7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Apr 2009 01:47:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751207AbZD3Fr7
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Apr 2009 01:47:59 -0400
Received: from mail-bw0-f163.google.com ([209.85.218.163]:59121 "EHLO
	mail-bw0-f163.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751083AbZD3Fr6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Apr 2009 01:47:58 -0400
Received: by bwz7 with SMTP id 7so1591674bwz.37
        for <git@vger.kernel.org>; Wed, 29 Apr 2009 22:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=oL5RkHcjwEDkysM6UFpmqz2ygSpaoaYhs5ydXtctheg=;
        b=TwPockfQGiNf3sGGsE+iYVxNPNxJukPv0kRvBrpfaxgZO+zWlFg80Q1pEns17vHuNu
         vR8A9l+3VRfJKIqdOMdxhVXQMHqiBO5zEkv3uCVjjuIA+KH/mknPLWk3ld7ob+3QVzQV
         0+Yel6LfAZy2lzXwmyml5E2r1Xz90sssuoOzs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=vzWEF2sE6CGL861PD0Ns9XhM179pnMKiesH8YTyvH1EyY0rBiqp1h4boclXO/xGpuU
         CP0rDrThAJVY2Fl78nGwF5JzuPA1rzB+Bt5EifrmXGLlsRDNGCMizUzFHKIWicxQvouG
         TE1AskAtnD9UfgHtGZToMaFyZTPgUseD3KhMU=
Received: by 10.204.31.74 with SMTP id x10mr1107309bkc.7.1241070477817; Wed, 
	29 Apr 2009 22:47:57 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0904300037300.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117991>

2009/4/30 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> On Thu, 30 Apr 2009, Alex Riesen wrote:
>> http://www.google.com/search?q=snprintf+negative+return+value
>>
>> First link: http://bytes.com/groups/c/590845-snprintf-return-value
>>
>> Look for "(Windows, mingw)"
>
> No, I will not.
>

"The following are the results from different systems:
gcc 3.3 (Mac OS X): 10
gcc 3.4.5 (Windows, mingw): -1
BC++ 5.5.1 (Windows): 10
MS VC++ 6.0 and 2005 (Windows, _snprintf() used): -1
DigitalMars 8.42n (Windows): -1"
