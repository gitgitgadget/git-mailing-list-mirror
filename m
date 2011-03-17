From: Alexei Sholik <alcosholik@gmail.com>
Subject: Re: [PATCH 2/2] Add Author and Documentation sections to git-for-each-ref.txt
Date: Thu, 17 Mar 2011 21:51:55 +0200
Message-ID: <AANLkTin35yjU-JDA8z4_aRFhV+-_hHiurWjaid8Th919@mail.gmail.com>
References: <1299590170-30799-1-git-send-email-alcosholik@gmail.com>
	<1299590170-30799-3-git-send-email-alcosholik@gmail.com>
	<4D773570.4010803@drmicha.warpmail.net>
	<AANLkTimyW7CMSkXndHOW9Gbvu124YYT5e-SdGUq3-OGu@mail.gmail.com>
	<1300371608.16335.1.camel@wpalmer.simply-domain>
	<20110317193450.GD20508@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Will Palmer <wmpalmer@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 17 20:52:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0JEp-0006O2-Ll
	for gcvg-git-2@lo.gmane.org; Thu, 17 Mar 2011 20:52:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755138Ab1CQTv7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Mar 2011 15:51:59 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:47627 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754991Ab1CQTv5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Mar 2011 15:51:57 -0400
Received: by wya21 with SMTP id 21so3149282wya.19
        for <git@vger.kernel.org>; Thu, 17 Mar 2011 12:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Zne7enlSNyJ+/TChMLlzzowVSkRw68gVtCqLeTnfDsU=;
        b=SfwB3k60KOrl8YkqABcpHpyjpJRggEGV2VKSZbzezLerJ04ummqKD7qhnHPjS0DDFv
         dWhwYoV/ODyuurikCZwtpqsbkngFDuTueZRNlfLsxhT28Qqm0xvLAgPhxlgrP8k9fsNp
         UQb/ibNteAWhtdu4GjqF6xDLrYXGPSZ9yR7OA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=lXJ0whQbynj0JsbTBXvrAVoq9ZSNjLTQ+q3umABIXRcc5HdJBDIl1c+bjHE8z82f0D
         xvkEW4NM7YFhAcji+GyR3G7N/mXJWhr5UJ1D4HwtU6QFDBv9D0OE41FS61p41Y+urXzk
         McX0xmjUYvQL16fnzItipuDQdvJkOZDoL3VTY=
Received: by 10.216.255.201 with SMTP id j51mr147278wes.94.1300391516524; Thu,
 17 Mar 2011 12:51:56 -0700 (PDT)
Received: by 10.216.1.142 with HTTP; Thu, 17 Mar 2011 12:51:55 -0700 (PDT)
In-Reply-To: <20110317193450.GD20508@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169268>

Ah, gmail has cut out the CC list. Below is my reply to a previous
message by Will Palmer.

I think, it would be nice to have a tool, which output all the
different stats about the repo, maybe even in a gui. But it definitely
doesn't belong in the Git project.

--
Best regards,
Alexei Sholik

---------- Forwarded message ----------
=46rom: Alexei Sholik <alcosholik@gmail.com>
Date: 17 March 2011 16:45
Subject: Re: [PATCH 2/2] Add Author and Documentation sections to
git-for-each-ref.txt
To: Will Palmer <wmpalmer@gmail.com>

On 17 March 2011 16:20, Will Palmer <wmpalmer@gmail.com> wrote:
> On Wed, 2011-03-09 at 14:14 +0200, Alexei Sholik wrote:
>> .................. Just ran this command
>>
>> git blame -p "$1" | awk '$1 ~ /author$/ { print substr($0,
>> length("author =C2=A0"), length($0)) }' | sort | uniq -c | sort -nr
>>
>> on the for-each-ref.c and saw that Junio had the first place by a
>> relatively large margin.
>>
>
> Wrap that up in a script and submit /that/ as a patch ;)
>
>

This script alone is not very useful. I was thinking about writing a
collection of scripts to gather different stats from the repository
history. However, it would be a different project altogether, not a
part of Git. The Future Git should be portable and shiny ;)
