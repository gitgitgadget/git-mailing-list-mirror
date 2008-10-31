From: "Peter Harris" <git@peter.is-a-geek.org>
Subject: Re: [PATCH] Use find instead of perl in t5000 to get file modification time
Date: Fri, 31 Oct 2008 08:59:38 -0400
Message-ID: <eaa105840810310559l29addd80i7a22c21e37231bb1@mail.gmail.com>
References: <81b0412b0810290338j1beaa25bx9fb373a69f5dfe7@mail.gmail.com>
	 <1225344554.10803.17.camel@maia.lan>
	 <20081031070003.GA4458@blimp.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Sam Vilain" <sam@vilain.net>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>, "Jeff King" <peff@peff.net>,
	"=?ISO-8859-1?Q?Ren=E9_Scharfe?=" <rene.scharfe@lsrfire.ath.cx>
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 31 14:00:54 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvtcU-0001Hb-Fx
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 14:00:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751151AbYJaM7k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 08:59:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751092AbYJaM7k
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 08:59:40 -0400
Received: from rv-out-0506.google.com ([209.85.198.239]:42158 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751147AbYJaM7j (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 08:59:39 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1219595rvb.1
        for <git@vger.kernel.org>; Fri, 31 Oct 2008 05:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=JJwfO8BMpXVk8Chc3lWfxCGhgDaG/nyPT+3Mxae4MEU=;
        b=DIYkr+qRaaVVdIcZ0u1tI0l8PfEPGDhWSebJNDrxZD2LqDNW0Rnhz/cucLRt1aGWsg
         fqChqAoyfy3uMu7sz4T0MJbirzXb1W+ZVve9Jmjr2L4zv4s6IXLbT3Fn67SL2ELvuJk1
         SjP+1AHfVD2fvlddLhSzLflGX65iKKmW58664=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=Lboxu6HftdA/e2WJO7sT8plhRT8GafKK0Ti+YLLAXbDn/scx8QfNA1sIgp4xXerIXh
         ofiIsHL93Ucmo2HQDX1KHP3iLssZbXy4VUQEJt9vUxZ2Z4rf1j6ocWPpIpvoN8gwiuzZ
         HJrYURPPqWO61D3DjyiKrUX192wbFHkv4i7as=
Received: by 10.141.170.10 with SMTP id x10mr6613153rvo.221.1225457978877;
        Fri, 31 Oct 2008 05:59:38 -0700 (PDT)
Received: by 10.141.97.15 with HTTP; Fri, 31 Oct 2008 05:59:38 -0700 (PDT)
In-Reply-To: <20081031070003.GA4458@blimp.localdomain>
Content-Disposition: inline
X-Google-Sender-Auth: 7772209f96199996
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99586>

On Fri, Oct 31, 2008 at 3:00 AM, Alex Riesen wrote:
> Sam Vilain, Thu, Oct 30, 2008 06:29:14 +0100:
>> On Wed, 2008-10-29 at 11:38 +0100, Alex Riesen wrote:
>> > I could not find what exactly does the ActiveState's Perl use for its stat
>> > implementation (and honestly, have no motivation to look harder).
>> > It seems to honor TZ, but the produced time does not seem to be either
>> > local or GMT.
>>
>> See, the difference is that the perl is portable and your patch isn't.
>
> ActiveState Perl on Windows is portable? To another windows, maybe.

Quite aside from missing the point (which is that Vanilla Perl runs
everywhere, including Windows[1]), this is also factually incorrect. A
quick check of the ActiveState website would reveal ActivePerl
downloads for AIX, Linux (x86 and x86-64), Solaris (x86, SPARC, and
SPARC64), MacOSX (x86 and PPC), and source code, in addition to
Windows.

Looks pretty portable to me.

Peter Harris

[1] http://vanillaperl.com/
