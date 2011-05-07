From: Mikael Magnusson <mikachu@gmail.com>
Subject: Re: [RFC/largely untested/PATCH] sha1_name: interpret ~n as HEAD~n
Date: Sat, 7 May 2011 04:24:04 +0200
Message-ID: <BANLkTinsWpXYN+Zejph6toidZWFAkprcYw@mail.gmail.com>
References: <6c53916752bf79178113157291fd675ead0804c9.1304092338.git.git@drmicha.warpmail.net>
	<20110429223433.GA3434@sigill.intra.peff.net>
	<BANLkTi=7_-TF63Y9MRHZ_XirSUD6RAC9kw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 07 04:24:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QIXBv-0008CK-2v
	for gcvg-git-2@lo.gmane.org; Sat, 07 May 2011 04:24:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754775Ab1EGCYH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2011 22:24:07 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:48897 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754726Ab1EGCYF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2011 22:24:05 -0400
Received: by vxi39 with SMTP id 39so4002922vxi.19
        for <git@vger.kernel.org>; Fri, 06 May 2011 19:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=W5Nmtp4vepZlWhhXBTwz0GIQ5IgZJhNqfmsAMJ4DlV0=;
        b=PLIhVTmRVkx0RNcRwMiYzV/NxRnbqMKjVRsSb3VXWImrlAxwCCYhlMRMTSGschU9WX
         qHxC5GXdk/BJhr7AEjqKA1crqaTsCY7hEcVpDnKtNWIxhnxeunBVgefv5yWpL1O5KGeV
         TAdVYaJFSyYzmncEMeyTsMZcIzUgZ4pwePLVw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=nLXbjVyUGWDI3cou3Gw0PoblnVAyfeEJwlJoD9jp8sQgSJRwYgZWFS91et5Xlkdkwf
         NKPVVu8Hka9r6yMWKwA+B7DrafxY9eIDetKyqU3RsO+prekFhJTSdCgaacV1P/n+T3U4
         SuOofz7dIyzDTwmaFhJ6iuHGFhoabdsaC3U+k=
Received: by 10.52.185.104 with SMTP id fb8mr5344623vdc.309.1304735044109;
 Fri, 06 May 2011 19:24:04 -0700 (PDT)
Received: by 10.52.169.129 with HTTP; Fri, 6 May 2011 19:24:04 -0700 (PDT)
In-Reply-To: <BANLkTi=7_-TF63Y9MRHZ_XirSUD6RAC9kw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173032>

On 30 April 2011 01:23, Sverre Rabbelier <srabbelier@gmail.com> wrote:
> Heya,
>
> On Sat, Apr 30, 2011 at 00:34, Jeff King <peff@peff.net> wrote:
>> So there really isn't a lot of consistency, I guess.  It also conflicts
>> a little with the shell's "~user" syntax, though presumably you don't
>> have users named "1" and "2".
>
> FWIW, I like the patch, mainly because I dislike typing HEAD~n (I
> usually mispel it as HEA~n) and agree with peff's analysis, we're such
> a long way from being any form of consistent that I don't see this
> breaking any user expectations.

Something I always set up in the skeleton dir
($prefix/share/git-core/templates) after installing git is
echo 'ref: HEAD' > h
it makes life so much easier :).

-- 
Mikael Magnusson
