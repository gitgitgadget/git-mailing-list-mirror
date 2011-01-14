From: JT Olds <jtolds@xnet5.com>
Subject: Re: Git Rebase blows away GIT_AUTHOR_NAME
Date: Fri, 14 Jan 2011 07:51:10 -0700
Message-ID: <AANLkTin-xtAX3X0vqiSTXYZPgK3Yj_R7toX8neuNu-uD@mail.gmail.com>
References: <AANLkTinMX0yEPvSc-c=96R42SbFZTjW5Mnveuxk3ZHS=@mail.gmail.com>
	<20110112182150.GC31747@sigill.intra.peff.net>
	<AANLkTimanDRHwoqSj7i9sVCZkze1L3Qp-zFYwTwHAOHX@mail.gmail.com>
	<AANLkTimvK3p3M8kbGzLxyhchoFONiD4=FGPWxxs=i0GA@mail.gmail.com>
	<AANLkTikqfX3jhSdP5xhFj=VktqW2S6AeGL_MF18g8ZA_@mail.gmail.com>
	<AANLkTimf2rwKqyWwQbdj7cjS8YcQwCXYGRCvQbZ5HZ19@mail.gmail.com>
	<AANLkTik15iV9SOv6rRL5+DQkAZ4JwBGTS+gqS3nXy2hN@mail.gmail.com>
	<AANLkTikk7Xdiey76Dmy848_B4qNX2-Vbis7p=E8vtNL9@mail.gmail.com>
	<AANLkTimONqL4=E4Unrsj9PU5u57KGXrmO6xWUOCLorgs@mail.gmail.com>
	<AANLkTi=PTgmOSC7pRLjujO5fi9Wdp69Jmj4zCkhGSYSz@mail.gmail.com>
	<AANLkTiksAZSi-Yo8yJv5ca9XWWvB3iVQhZOJtTs-F8gk@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Tor Arntsen <tor@spacetec.no>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Fri Jan 14 15:51:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pdkzm-0007f7-1f
	for gcvg-git-2@lo.gmane.org; Fri, 14 Jan 2011 15:51:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757514Ab1ANOvM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Jan 2011 09:51:12 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:36029 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757073Ab1ANOvL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Jan 2011 09:51:11 -0500
Received: by wwa36 with SMTP id 36so3062044wwa.1
        for <git@vger.kernel.org>; Fri, 14 Jan 2011 06:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=uAV6B+9P0YTmqn3o8GmLruWjZcFoJAjfN0zgqaMw0Yk=;
        b=IBNaxFba+wCwnkqtCxB1wtTQUGBJGyO8QG6vhWSf/bTv/1ekS1B88ydZrWwkzjKQi0
         PvjzsAJcnpd0tZz5XXNlAfwTKTrv14CeuUipuzRrc+XRP6gA88x6W+FcTdrBJxLZtF5J
         8FV0zxMlo5fIWEA2gWCC/CxV9Zarl+gz96uW8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=rY+bgiVVN7n/3aXC82IfIissosZKmoYeLQ1hZ2iL6IQHl+EmLljhDnSOqiIT6ZSWpW
         vmi+Y5NriE48nS36BWxcZrReDGAZJuyoYTrX/COdlQVU4unz7ZFVzsOlkYjKAEropKXB
         EefrmCtAabZqyEVvSWCooOZBDysVOvoo2eoV4=
Received: by 10.216.139.224 with SMTP id c74mr678716wej.50.1295016670403; Fri,
 14 Jan 2011 06:51:10 -0800 (PST)
Received: by 10.216.2.194 with HTTP; Fri, 14 Jan 2011 06:51:10 -0800 (PST)
In-Reply-To: <AANLkTiksAZSi-Yo8yJv5ca9XWWvB3iVQhZOJtTs-F8gk@mail.gmail.com>
X-Google-Sender-Auth: yoDoq4AXLHkiVpaERDKug5KYtok
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165105>

On Fri, Jan 14, 2011 at 2:53 AM, Erik Faye-Lund <kusmabite@gmail.com> w=
rote:
> (CC'ed Linus, as he wrote mailinfo's sanity-checking)
>
> On Fri, Jan 14, 2011 at 10:24 AM, Tor Arntsen <tor@spacetec.no> wrote=
:
>> On Fri, Jan 14, 2011 at 09:56, Erik Faye-Lund <kusmabite@gmail.com> =
wrote:
>>> On Fri, Jan 14, 2011 at 9:45 AM, Tor Arntsen <tor@spacetec.no> wrot=
e:
>>>> I think I've mentioned this before in another thread, but first/la=
st
>>>> name isn't universal, not even within countries where it's the com=
mon
>>>> form. When I was as student there was a fellow student from anothe=
r
>>>> scandinavian country and his legal, full name consisted of a singl=
e
>>>> letter.
>>>>
>>>
>>> I'm curious, what Scandinavian country was this? Because as a
>>> Norwegian, I know a lot of people from all Scandinavian country, ye=
t
>>> I've never heard of such names. In Norway, I the shortest legal nam=
e
>>> I've ever heard of was five characters.
>>
>> Sweden (I'm Norwegian too - this guy was a Swede studying in Norway)=
=2E
>> Admittedly I have only that single example, and it was back in the
>> late seventies. His name was accepted as legal by Statens L=E5nekass=
e
>> (bank for students) and when the loans arrived his single-letter nam=
e
>> would be found at the very end of the long lists of wide listing-pap=
er
>> printouts from the bank that was stiched up on the billboard wall
>> outside the administration offices. The loans arrived a couple of
>> times per year but we always had to go looking - the rest of us were
>> just amazed that we could really find that single letter down there
>> and he wasn't bs'ing the rest of us about his name.
>>
>> I'm not sure why there's a 3-letter limit on git author names.. but =
I
>> would suggest it should be set down to 1 letter minimum.. below that
>> would, I think, be overdoing it..
>>
>
> Linus, you wrote sanity_check (from 2744b23). Do you remember if ther=
e
> were any specific reason for the minimum length of 3 of an
> author-name? It seems that in Sweden, legal names can be even a singl=
e
> letter (see Tor's comment)...
>

Thanks all.

I suppose another question, regardless of the outcome of following up
on the name limit, is how come this is silently swallowed?
