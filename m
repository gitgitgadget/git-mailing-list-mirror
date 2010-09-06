From: Joshua Juran <jjuran@gmail.com>
Subject: Re: [PATCH] Add ERR support to smart HTTP
Date: Mon, 6 Sep 2010 02:15:01 -0700
Message-ID: <EC704F6E-3075-459C-9210-10C234523D80@gmail.com>
References: <1283707815-32038-1-git-send-email-ilari.liusvaara@elisanet.fi> <AANLkTikGiekZGNffaraHK-waBt7wH84jujM_uh3cw46y@mail.gmail.com> <AANLkTinTFWHWU1vCnDa-c3p5g+y7wnH9A8fieowQHU5z@mail.gmail.com> <201009061049.38546.jnareb@gmail.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sitaram Chamarty <sitaramc@gmail.com>,
	=?ISO-8859-1?Q?=22=C6var_Arnfj=F6r=F0_Bjarmason=22?= 
	<avarab@gmail.com>, Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Tarmigan Casebolt <tarmigan+git@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 06 11:15:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsXnQ-0002Ge-Gq
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 11:15:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752312Ab0IFJPK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Sep 2010 05:15:10 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:44815 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752274Ab0IFJPI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Sep 2010 05:15:08 -0400
Received: by pzk9 with SMTP id 9so1354597pzk.19
        for <git@vger.kernel.org>; Mon, 06 Sep 2010 02:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:cc:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:mime-version
         :subject:date:references:x-mailer;
        bh=f3C2l/4+URjnYtWq5Gt2kW9Ci1WAxW44ZRQkHcWJ4Dw=;
        b=bqBIfcUpQTfGrWyW44/JErsPb3izgxPRTrOooSNcvHaEeVmtHWP5sg1q/ZJbzX01XD
         4AqSfzWRFkPrO7xLd8fkzevu+kxPS1m9tMnUUsnllEyZBpxwGPOiDRuf+B6Dv8ioqni3
         vcvtl2QdO/liDcDPrTASLkEJ2TCY1F9hv8wV0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        b=aIpDyw5Nqyogzb7jy+Ll+v0mBUrPVxYQNT8YC9Rnwzani6zNSF3xegP2GkxxSeYmnA
         moD2QAMMEBAbFMupBmVUMC8iiwpTar1dBBzbtGy273vHfIy21DX5gIaWVZg/H3g1E3e9
         /LFzwYRRAPhjpUNAmW9O4HezCRkaiOMcVNMnI=
Received: by 10.114.39.18 with SMTP id m18mr3403273wam.196.1283764507838;
        Mon, 06 Sep 2010 02:15:07 -0700 (PDT)
Received: from zaphod.jjuran.dyndns.org (c-71-227-175-60.hsd1.wa.comcast.net [71.227.175.60])
        by mx.google.com with ESMTPS id o17sm10841169wal.9.2010.09.06.02.15.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 06 Sep 2010 02:15:03 -0700 (PDT)
In-Reply-To: <201009061049.38546.jnareb@gmail.com>
X-Mailer: Apple Mail (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155545>

On Sep 6, 2010, at 1:49 AM, Jakub Narebski wrote:

> On Mon, Sep 6, 2010, Sitaram Chamarty wrote:
>> On Mon, Sep 6, 2010 at 6:34 AM, Sitaram Chamarty =20
>> <sitaramc@gmail.com> wrote:
>>> On Mon, Sep 6, 2010 at 2:52 AM, Jakub Narebski <jnareb@gmail.com> =20
>>> wrote:
>>>> =C6var Arnfj=F6r=F0 Bjarmason <avarab@gmail.com> writes:
>>>>
>>>>> On Sun, Sep 5, 2010 at 18:49, Ilari Liusvaara
>>>>> <ilari.liusvaara@elisanet.fi> wrote:
>>>>>
>>>>>> AFAIK, HTTP errors don't have descriptions printed.
>>>>>
>>>>> I don't know if this applies here but HTTP error codes can come =20
>>>>> with
>>>>> any free-form \n-delimited string:
>>>>>
>>>>>     HTTP/1.1 402 You Must Build Additional Pylons
>>>>
>>>> And you can also send more detailed description in the *body* =20
>>>> (and not
>>>> only HTTP headers) of HTTP response, though I don't know if git =20
>>>> does
>>>> that.
>>
>> turns out all this was moot.  It was *because* I was using something
>> other than "200 OK" that the user was not seeing the message.  =20
>> Ilari's
>> patch just makes the message *look* better/cleaner, but I still have
>> to send it out with a "200 OK" status.
>>
>> That was... a surprise :-)
>
> From what I remember from smart HTTP discussion (during fleshing-out
> the protocol/exchange details), the fact that errors from git are sen=
d
> with "200 OK" HTTP status are very much conscious decision.  But I =20
> don't
> remember *why* it was chosen this way.  If I remember correctly it wa=
s
> something about transparent proxies and caches...  Is it documented
> anywhere?  Can anyone explain it?

I wasn't involved in the decision process, but I suspect it's because =20
HTTP is the transport layer to the Git application.  It's the same =20
logic as trying to log in to a Web application with bogus credentials =20
and getting back a page (HTTP 200 OK) stating that the login failed.  =20
As far as HTTP is concerned, the transaction succeeded.

Josh
