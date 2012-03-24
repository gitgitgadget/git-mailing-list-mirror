From: chaitanyaa nalla <nallachaitu@gmail.com>
Subject: Re: GSoC idea: adding JavaScript library / framework in gitweb
Date: Sat, 24 Mar 2012 21:39:28 +0530
Message-ID: <CACeyoge7_=aigOnJiXvp=SfVaBVO+4Or_x7Jcnmw-3pj8+VtoA@mail.gmail.com>
References: <CACeyogcFJoUyAiTReDJK_nCMGBp+23OjcS407A1X=fqFR+aGag@mail.gmail.com>
	<201203241417.10478.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 24 17:10:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SBTXW-0000By-FX
	for gcvg-git-2@plane.gmane.org; Sat, 24 Mar 2012 17:10:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754174Ab2CXQJa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 Mar 2012 12:09:30 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:62087 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753903Ab2CXQJ3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Mar 2012 12:09:29 -0400
Received: by obbeh20 with SMTP id eh20so3404425obb.19
        for <git@vger.kernel.org>; Sat, 24 Mar 2012 09:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=kpK7a7Dhw8LnMGlr1DElUlGzJXHDGJAU2PNXbgvwIiI=;
        b=g27ynAhZVp3SUdT/JSjsmQ/ryxJg9wnrGT0/GIiwRndzVsp/ZglTId09/hTTfkTXKN
         qtJLcy+6h18uTpWA55sIN2uehcRlSrLSgr+XMa6F7z5dswSdoJaWKbFJkhOhtm8N7zAH
         6+7FgQ0R2tSv5mLhEY6T/dEGVaw3UnfrwymD5o+pU04NDxo0bcZ/8d0jRwtSJNAu0Qxv
         c346Kze7OXf8HQEqXOyTDYlDk6bLLE5sip1NrnDM/xxHomcIHSjfFTiZJ3B0duWf7S/0
         UY/HP5gby7eLEg/gmASB/eYUAICSOPxV0T2VSVdcihLEFG0fh/2XrBiUKqNLhbhysCEx
         Y/Xg==
Received: by 10.60.4.170 with SMTP id l10mr19571138oel.67.1332605368568; Sat,
 24 Mar 2012 09:09:28 -0700 (PDT)
Received: by 10.182.39.234 with HTTP; Sat, 24 Mar 2012 09:09:28 -0700 (PDT)
In-Reply-To: <201203241417.10478.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193829>

Dear Jakub ,

 could you please suggest any other ideas or features so that i can
think upon them and come up with further good ideas.

On Sat, Mar 24, 2012 at 6:47 PM, Jakub Narebski <jnareb@gmail.com> wrot=
e:
> On Sat, 24 Mar 2012, Chaitanyaa Nalla wrote:
>
>> Hello everyone,
>>
>> =A0I am Chaitanya Nalla, a final year undergraduate student from Ind=
ia and I
>> am pretty much interested in doing the project "Adding javascript li=
brary /
>> framework in gitweb" suggested by respected Jakub. =A0I have good ex=
perience
>> in javascript libraries like jQuery, Dojo etc. As per the goals of t=
he
>> project I will use the efficient, concise, cross browser compatible
>> frameworks where ever needed.
>
> JavaScript library / framework is required not only to cover differen=
ces
> between web browsers in DOM manipulation, event handling and Ajax wit=
h
> XmlHttpRequest, but also add features which are still[1] lacking from
> JavaScript such as handling cookies, formatting strings, date manipul=
ation,
> etc.
>
> Currently gitweb uses hand-crafted micro-library in `gitweb/static/js=
/lib/`
> Using existing JavaScript library, be it jQuery (most popular), Dojo,
> MooTools or YUI (probably too much for gitweb) will give us, as you s=
aid,
> well tested code, and new abilities like client-side sorting of table=
s
> which we would be able to use in further work.
>
> [1] http://www.nczonline.net/blog/2011/10/03/when-web-standards-fail-=
us/
>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Also =
I am planning to create a local library
>> version with support for configuration and a good documentation.
>
> I don't quite understand what you mean here. =A0The JavaScript code s=
pecific
> to gitweb would have to be modified to use chosen JavaScript library,=
 but
> I wouldn't say it is "local library". =A0I'd rather we use stock Java=
Script
> library, which would allow us to leverage existing CDNs like (for jQu=
ery)
>
> =A0http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js
> =A0http://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.7.2.min.js
> =A0http://code.jquery.com/jquery-1.7.2.min.js
>
> We probably would ultimately need to be able to serve local fallback =
copy
> (but this might be out of scope of GSoC project).
>
> This gitweb-specific JavaScript code (files in `gitweb/static/js/`)
> is IMVHO quite well documented using JSDoc.
>
>> Using the DOM features of JavaScript and traversing the whole docume=
nt
>> object is quite cubersome and error prone, so I want to replace them=
 using
>> well tested libraries that are cross browser compatible.
>
> I think there is missing "using hand-crafted code" in this sentence
> to make it sense.
>
>>
>> Emulating onprogress in XMLHttpRequest :
>>
>> jQuery and YUI provide only statuses success and error.
>
> Right.
>
>> Even MooTools provide progress but are constrained to some browers
>> only.
>
> To be more exact MooTools support 'onprogress' event handler only if
> web browser supports it. =A0Not all do (e.g. older browsers), that is=
 why
> there is need for emulation using timers.
>
>> It can be handled by using $.ajax Transport utility .
>
> You mean in jQuery here, isn't it? =A0It would be a bit different, I =
think,
> in MooTools or YUI.
>
> C.f. http://stackoverflow.com/questions/5652229/javascript-framework-=
with-or-easily-extendable-with-support-for-xmlhttprequest
>
>> I will also take care progressive enhancement, by carefully implemen=
ting the
>> basic functionality of the gitweb so that what ever may be the brows=
er
>> version and type, internet connection the basic functionality will n=
ot
>> disrupted.
>
> Errr... "progressive enhancement" is about using client-side scriptin=
g
> in such way, that even if web browser doesn't support JavaScript
> (e.g. text browsers such as lynx, elinks or w3m), or has JavaScript
> turned off or blocked, we would get a basic functionality.
>
> Note also that "progressive enhancement" part applies only to writing
> new features, and this is strictly 'as time permits' part, I think.
> But I thin that you would need to lay more complete proposal, i.e.
> what features are you planning to add.
>
> --
> Jakub Narebski
> Poland
