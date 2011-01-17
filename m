From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: Git Rebase blows away GIT_AUTHOR_NAME
Date: Mon, 17 Jan 2011 23:29:53 +0100
Message-ID: <AANLkTinyteSHE6DpBi6mXLW7HpgXkEZL8HBeSuFyw+v2@mail.gmail.com>
References: <AANLkTikqfX3jhSdP5xhFj=VktqW2S6AeGL_MF18g8ZA_@mail.gmail.com>
 <AANLkTimf2rwKqyWwQbdj7cjS8YcQwCXYGRCvQbZ5HZ19@mail.gmail.com>
 <AANLkTik15iV9SOv6rRL5+DQkAZ4JwBGTS+gqS3nXy2hN@mail.gmail.com>
 <AANLkTikk7Xdiey76Dmy848_B4qNX2-Vbis7p=E8vtNL9@mail.gmail.com>
 <AANLkTimONqL4=E4Unrsj9PU5u57KGXrmO6xWUOCLorgs@mail.gmail.com>
 <AANLkTi=PTgmOSC7pRLjujO5fi9Wdp69Jmj4zCkhGSYSz@mail.gmail.com>
 <AANLkTiksAZSi-Yo8yJv5ca9XWWvB3iVQhZOJtTs-F8gk@mail.gmail.com>
 <AANLkTi=Z6Dx6m68zi7Q1eRVxX3DXOyKj+Ff177UCQrAj@mail.gmail.com>
 <AANLkTimZF+r2aNzrXsUuHVZR65N5wpOYLutFgGAGoci_@mail.gmail.com>
 <20110114162144.GA867@sigill.intra.peff.net> <20110117222128.GA30869@sigill.intra.peff.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: JT Olds <jtolds@xnet5.com>, Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Tor Arntsen <tor@spacetec.no>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jan 17 23:30:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pexae-0000oZ-UH
	for gcvg-git-2@lo.gmane.org; Mon, 17 Jan 2011 23:30:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752972Ab1AQWaQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Jan 2011 17:30:16 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:41547 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752630Ab1AQWaP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Jan 2011 17:30:15 -0500
Received: by fxm20 with SMTP id 20so6554057fxm.19
        for <git@vger.kernel.org>; Mon, 17 Jan 2011 14:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=+RJ6gCfq5I2kN8IUrLwMd1jMIms9qax+u+lPFejGAok=;
        b=gm0nf0G4yw1LkzgT6eYMqffyZKbCYY5Vzci/eG0sUKpRzXz05rDp+fioimvy/CDCPE
         hiScaoOIkHEDxyRF8QYEmBK33k/ol20NwHJmO8YQlE2+gh0f/FJqTT3UhMWON7t9SQST
         4UAXzh8T9FjisV9XHBN5VJgVEM4yXXaVWyt+Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=AVd4bdI+m0PJN1bc6Evkl21pz3vdwT2ICwfxlyEDdgOvKKXu0ABxBmbpzi49iPBYXI
         Inwk9yGRWxyygjySwpVx0SJOw6Yqq7hAkc/RIBhs/FtiqO1Dmvl943mBcfdV4D8odsSi
         T4W+MwzdGKEFjfdCiEeiu3TKlQgGEUOcf0Ogo=
Received: by 10.223.118.136 with SMTP id v8mr1615844faq.90.1295303413538; Mon,
 17 Jan 2011 14:30:13 -0800 (PST)
Received: by 10.223.79.3 with HTTP; Mon, 17 Jan 2011 14:29:53 -0800 (PST)
In-Reply-To: <20110117222128.GA30869@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165187>

On Mon, Jan 17, 2011 at 11:21 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Jan 14, 2011 at 11:21:45AM -0500, Jeff King wrote:
>
>> So we should probably do one or both of:
>>
>> =A0 1. Make an --allow-any-name option to mailinfo, and use it when =
we
>> =A0 =A0 =A0invoke mailinfo internally for rebasing. That still doesn=
't solve
>> =A0 =A0 =A0the emailed patch problem, but at least keeps purely inte=
rnal
>> =A0 =A0 =A0operations sane.
>
> So I wrote up a nice tidy patch series with mailinfo changes and test=
s,
> and then am/rebase changes and tests on top of that. And guess what I
> noticed? My rebase tests didn't actually fail with stock git.
>
> I bisected to 43c2325 (am: use get_author_ident_from_commit instead o=
f
> mailinfo when rebasing, 2010-06-16), which was written to handle exac=
tly
> this sort of thing.
>

Heh, same story bro :(

Just for reference, my patch can be found at
http://repo.or.cz/w/git/kusma.git work/rebase-keep-name
