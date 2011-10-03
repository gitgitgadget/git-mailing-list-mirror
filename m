From: Hilco Wijbenga <hilco.wijbenga@gmail.com>
Subject: Re: Branches & directories
Date: Mon, 3 Oct 2011 10:20:11 -0700
Message-ID: <CAE1pOi1QvcoO9GVwH4-z_gvNVNBQi78JP5mmmwNaRkJOH=W-SQ@mail.gmail.com>
References: <CAMOZ1Bu5pPeviyZD-e6aHbv-+tSaBDyyKb5vHA132K_3=1gD-g@mail.gmail.com>
	<CAE1pOi0dL2qNMksuY_=gyGSRsfr6e9AmzgJUNB=jEz85sjuiUw@mail.gmail.com>
	<CAGZ=bqK7H3zc8LK7EP8+uV8DpWW+czK2POfceGtcBF8Vmkhkow@mail.gmail.com>
	<CAE1pOi1J5DKtnyUQzu1K7G1+HLsWWCN7thCf6W8MwSzt4_vtOw@mail.gmail.com>
	<CAGZ=bqLZoLoyMcvnppg6SyFtJU8phSquQeBZ7uhwP=+ZL3DADw@mail.gmail.com>
	<CAE1pOi0Er1ZgftpNeCr85Zu27xR2127V_KdAtvKc1NOKmDUvzQ@mail.gmail.com>
	<CAGZ=bqLyS9tcpqztwGWFOXtDJRhugu+JYvz7wTnc0PTmECWX2g@mail.gmail.com>
	<CAE1pOi1axNmGaPVXqBH02x0N=Z6tgO9R00RTokuJm50eY-OoNg@mail.gmail.com>
	<4E889813.8070205@gmail.com>
	<CAE1pOi3bm72Rk+UYygS_bC9eh0VTPr-VQSdtBGqjgDpEzkutZw@mail.gmail.com>
	<20111003030723.GA24523@sigill.intra.peff.net>
	<CAE1pOi2xmVHrVJcC85wvCv=anhn_kYizyUMpUVZF4EE33RoGmg@mail.gmail.com>
	<4E89CDCA.9030802@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Kyle Moffett <kyle@moffetthome.net>,
	Michael Witten <mfwitten@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Evan Shelhamer <shelhamer@imaginarynumber.net>,
	Git Mailing List <git@vger.kernel.org>
To: Robin Rosenberg <robin.rosenberg@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 03 19:20:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAmBe-0001Rv-5s
	for gcvg-git-2@lo.gmane.org; Mon, 03 Oct 2011 19:20:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757020Ab1JCRUO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Oct 2011 13:20:14 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:50222 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755372Ab1JCRUM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Oct 2011 13:20:12 -0400
Received: by qyk7 with SMTP id 7so3874569qyk.19
        for <git@vger.kernel.org>; Mon, 03 Oct 2011 10:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=Y2O05DGv+ZMOoUTyC+SmlETxW4Y7OS7x0jfjGdU708g=;
        b=ZiRKA4qZfJa9Ixg9Q/q5C06VanK9SNS5e/WWYgRoTb+aQOEr0Z5iMyhXR3cMCsS1Op
         EUoO4XCnwOBbfGAZPFfXSDUr2ka6A29xVxuIuVybd6kMKPXrw2upUek3LgXV0ax1ayrM
         eYWRfKUUdMHgMWPhpnBdKUvraih6palGBNX0g=
Received: by 10.229.72.87 with SMTP id l23mr168455qcj.163.1317662411715; Mon,
 03 Oct 2011 10:20:11 -0700 (PDT)
Received: by 10.229.87.134 with HTTP; Mon, 3 Oct 2011 10:20:11 -0700 (PDT)
In-Reply-To: <4E89CDCA.9030802@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182675>

On 3 October 2011 07:59, Robin Rosenberg <robin.rosenberg@gmail.com> wr=
ote:
> Hilco Wijbenga skrev 2011-10-03 09.15:
>>
>> On 2 October 2011 20:07, Jeff King<peff@peff.net> =C2=A0wrote:
>> <snip/>
>>>
>>> Or did you really mean your example literally, as in you run two
>>> checkouts back to back, without running anything in between, and th=
e
>>> second checkout restores the state before the first one. In that ca=
se,
>>> yes, it would be correct to keep the old timestamps. But this is an
>>> optimization that can only apply in a few very specific cases. And
>>> moreoever, how can git know when it is OK to apply that optimizatio=
n? It
>>> has no idea what commands you might have run since the last time we=
 were
>>> at "master".
>>
>> Yes, I meant it literally. And, no, Git could not possibly know so i=
t
>> would have to be optional behaviour. But it's probably a lot of work
>> for (for most people) little gain.
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.h=
tml
>>
> I wouldn't use stash for that. Just regular commit/amend and your
> timestamps should be fine. Alternative submit a patch for either
> the save or create subcommands of stash. That would not be very
> hard (technically) =C2=A0and no one needs to mess with the timestamps=
;
> they will just survive.

By "that" you mean jump to another branch? I don't see how doing an
explicit commit changes anything. Stashing is essentially committing
(i.e. a "dummy" commit is created to store the stash, IIUC), isn't it?

As I mentioned before, I'm quite happy with git-new-workdir. It allows
me to work exactly the way I want. I may have some philosophical
reservations about Git's timestamp handling but practically speaking
I'm a happy little camper. :-)
