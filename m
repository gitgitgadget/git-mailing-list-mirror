From: Tarmigan <tarmigan+git@gmail.com>
Subject: Re: [PATCH] Typo in RelNotes.
Date: Wed, 11 Jun 2008 22:06:13 -0700
Message-ID: <905315640806112206g4df6ce11h2a98412223e13fdd@mail.gmail.com>
References: <alpine.LNX.1.00.0806120434290.5838@localhost>
	 <905315640806112059r713bf807l20a1bc1e14ce4e27@mail.gmail.com>
	 <20080612045330.GB25992@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Mikael Magnusson" <mikachu@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 12 07:07:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6f2C-0006Gp-9z
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 07:07:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751048AbYFLFGQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2008 01:06:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751195AbYFLFGQ
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 01:06:16 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:15626 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750869AbYFLFGP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2008 01:06:15 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2358850fgg.17
        for <git@vger.kernel.org>; Wed, 11 Jun 2008 22:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=9ORACpA8SasqcSwwWympV6JRKVNmPnUssGIQTiLTvkI=;
        b=KFKSCtbN78cU2g+GTSYPrbpqV8lH19JT6lt4AYkRPNYh+2kRveYlXvLhyXsIYdY7On
         mV3qHLbLtYP4BQDyfJSPQo+ATLWIeP3UkE7XmnwBKpi6nu+w+FxtUuSqIHpWmjEdMgAh
         BFLEgl9Zmhww7CNvptoCXW0XVlMEifsB01qs8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=h2O2nrsGacNxr3uoguibBK3t6xgXLnjxsMprTj8ClOtVO9MUYoOHb6OYEEK6a3RPfi
         dXXrtZO7Xxiob0phuFTAkjPi0MkCYnCpolcaWvokHXW8cygc1yrVVGqElxvQFV2PhVSW
         tuYwaDfe3hVN3Z3uboJOQOCWkuqaH701HINuM=
Received: by 10.82.153.12 with SMTP id a12mr51744bue.2.1213247173488;
        Wed, 11 Jun 2008 22:06:13 -0700 (PDT)
Received: by 10.82.157.18 with HTTP; Wed, 11 Jun 2008 22:06:13 -0700 (PDT)
In-Reply-To: <20080612045330.GB25992@sigill.intra.peff.net>
Content-Disposition: inline
X-Google-Sender-Auth: 39d3ee6649304af9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84700>

On Wed, Jun 11, 2008 at 9:53 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Jun 11, 2008 at 08:59:37PM -0700, Tarmigan wrote:
>
>> On Wed, Jun 11, 2008 at 7:38 PM, Mikael Magnusson <mikachu@gmail.com> wrote:
>> >  * "git init --bare" is a synonym for "git --bare init" now.
>> >
>> > -* "git gc --auto" honors a new pre-aut-gc hook to temporarily disable it.
>> > +* "git gc --auto" honors a new pre-auto-gc hook to temporarily disable it.
>> >
>> >  * "git log --pretty=tformat:<custom format>" gives a LF after each entry,
>> >   instead of giving a LF between each pair of entries which is how
>>
>> Any interest in fixing the typo on the next line while you're at it?
>
> Maybe I am blind, but I don't see a typo. Are you referring to tformat,
> which looks like a typo, but is actually correct?

Oops you're right.  That's what I was thinking of.  Junio's commit
message explains it well.  Should something be added to the man page
about it?

-Tarmigan
