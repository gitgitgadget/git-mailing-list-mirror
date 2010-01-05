From: "H.J. Lu" <hjl.tools@gmail.com>
Subject: Re: How to exclude files from "git diff"
Date: Tue, 5 Jan 2010 06:20:15 -0800
Message-ID: <6dc9ffc81001050620q55c23072p93f58c8685d77f9d@mail.gmail.com>
References: <6dc9ffc80912180909q2e9cbe30r7c802a2152c5954@mail.gmail.com>
	 <20100105064509.GC19025@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 05 15:24:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSAGq-0003MO-M7
	for gcvg-git-2@lo.gmane.org; Tue, 05 Jan 2010 15:20:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754525Ab0AEOUU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Jan 2010 09:20:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754520Ab0AEOUS
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jan 2010 09:20:18 -0500
Received: from ey-out-2122.google.com ([74.125.78.26]:37820 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754292Ab0AEOUR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Jan 2010 09:20:17 -0500
Received: by ey-out-2122.google.com with SMTP id 22so410193eye.19
        for <git@vger.kernel.org>; Tue, 05 Jan 2010 06:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=RsyLLrbtHTpNpUSHCJm342sTOViuKKjUgADaCQiAE4o=;
        b=ffN3goWKX8Q+vC7zdRvbdIIaCOqeuW+Ym24MFZGEy5HUSOR85JU5THuDmKIXJ4Qlmo
         Q63b1oH+4MyEnOtpujwjmqRcYxg9lzktL9bbu+DuM9GzLsagg1Qyhxao3c5eUeiPXbhn
         dcnMCOphy+r3cMQQZnYWOwVCRHFQ4hea+hYME=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=x/yUAwI0RfXR32OaDgU4w9+aXwUcRWjUceFj3DAN54PFFXGZwxF+81fHKqTIkdd7bx
         enWgtSPWIwW96MzYGOz/IpGxklj9SN/DBX9mfzih87pvlBszsuB9dbsekhmYNsC1nTeR
         pRfumuuo5vqQaep36oLRI5wQjkKvETZ0MTxwY=
Received: by 10.216.86.83 with SMTP id v61mr4169381wee.80.1262701215613; Tue, 
	05 Jan 2010 06:20:15 -0800 (PST)
In-Reply-To: <20100105064509.GC19025@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136190>

On Mon, Jan 4, 2010 at 10:45 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Dec 18, 2009 at 09:09:15AM -0800, H.J. Lu wrote:
>
>> I have some bookkeeping files in my git repository. =A0How do I
>> exclude them from "git diff"? Does "git diff" support
>>
>> # git diff --exclude=3D"foo.*.bar*"
>
> No, I don't believe there is a way to do that. You would have to do
> something like:
>
> =A0git diff $(git ls-files | grep -v whatever)
>
> The usual concept of "exclusion" for git is not to track files at all
> via the .gitignore mechanism. =A0Are these files that have content yo=
u
> really _want_ in the repository, but you just don't want to see them
> when doing some diffs? Or are they files that could not be in the
> repository at all?

Yes, I want those files in repository. They are for my personal use onl=
y.

Thanks.

--=20
H.J.
