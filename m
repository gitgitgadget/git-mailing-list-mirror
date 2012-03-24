From: chaitanyaa nalla <nallachaitu@gmail.com>
Subject: Re: GSoC idea: adding JavaScript library / framework in gitweb
Date: Sat, 24 Mar 2012 22:18:03 +0530
Message-ID: <CACeyogdUg4QnHjkYM5sKXJ7Wm9rOGgmhNrhqQxnrv24N530cVg@mail.gmail.com>
References: <CACeyogcFJoUyAiTReDJK_nCMGBp+23OjcS407A1X=fqFR+aGag@mail.gmail.com>
	<201203241417.10478.jnareb@gmail.com>
	<CACeyoge7_=aigOnJiXvp=SfVaBVO+4Or_x7Jcnmw-3pj8+VtoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 24 17:48:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SBU8S-0003Jk-2k
	for gcvg-git-2@plane.gmane.org; Sat, 24 Mar 2012 17:48:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755063Ab2CXQsG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 Mar 2012 12:48:06 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:41501 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755065Ab2CXQsE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Mar 2012 12:48:04 -0400
Received: by obbeh20 with SMTP id eh20so3430956obb.19
        for <git@vger.kernel.org>; Sat, 24 Mar 2012 09:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=LAmLqG6z+JGXQN8I9B2vbIV/QOAQqP1ogw0vcqFjQgc=;
        b=hQNOnr1g6xYz0Utk5i81DeKA3rvQ5tRj1s666qh4sJ2BfyvlrmGBxX4LATeq4ZXzji
         pnriBZ/Mg6CLMIBGth08z+HGsJbUTY0MRanMlZEjczJi78H4SWt0BFtdpeFpsF/KXPhN
         R7OZGcOBrW0Z6y3ZlarphoxYL7iyK20OntxyyxNrUSrOdh55fkNu5n/lhfsdO7VfbhGo
         48L/jTG2mUTp5i3Xvh6TDbX2+3ddmGLxJ0zdrH5cth7uzl2t4x5oWEOiYck8BCTKWcZA
         XRJ+0WObWhtYOXDGfudBmUY7CyjU135TnTdrLAdIJLOVdc26GY0IlfTNAnrgHxcSBKkG
         qIPQ==
Received: by 10.182.188.38 with SMTP id fx6mr10172170obc.77.1332607683891;
 Sat, 24 Mar 2012 09:48:03 -0700 (PDT)
Received: by 10.182.39.234 with HTTP; Sat, 24 Mar 2012 09:48:03 -0700 (PDT)
In-Reply-To: <CACeyoge7_=aigOnJiXvp=SfVaBVO+4Or_x7Jcnmw-3pj8+VtoA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193832>

ok,  first i will think and come up with good ideas and then ask you
about your suggestions :)

On Sat, Mar 24, 2012 at 9:39 PM, chaitanyaa nalla <nallachaitu@gmail.co=
m> wrote:
> Dear Jakub ,
>
> =A0could you please suggest any other ideas or features so that i can
> think upon them and come up with further good ideas.
>
> On Sat, Mar 24, 2012 at 6:47 PM, Jakub Narebski <jnareb@gmail.com> wr=
ote:
>> On Sat, 24 Mar 2012, Chaitanyaa Nalla wrote:
>>
>>> Hello everyone,
>>>
>>> =A0I am Chaitanya Nalla, a final year undergraduate student from In=
dia and I
>>> am pretty much interested in doing the project "Adding javascript l=
ibrary /
>>> framework in gitweb" suggested by respected Jakub. =A0I have good e=
xperience
>>> in javascript libraries like jQuery, Dojo etc. As per the goals of =
the
>>> project I will use the efficient, concise, cross browser compatible
>>> frameworks where ever needed.
>>
>> JavaScript library / framework is required not only to cover differe=
nces
>> between web browsers in DOM manipulation, event handling and Ajax wi=
th
>> XmlHttpRequest, but also add features which are still[1] lacking fro=
m
>> JavaScript such as handling cookies, formatting strings, date manipu=
lation,
>> etc.
>>
>> Currently gitweb uses hand-crafted micro-library in `gitweb/static/j=
s/lib/`
>> Using existing JavaScript library, be it jQuery (most popular), Dojo=
,
>> MooTools or YUI (probably too much for gitweb) will give us, as you =
said,
>> well tested code, and new abilities like client-side sorting of tabl=
es
>> which we would be able to use in further work.
>>
>> [1] http://www.nczonline.net/blog/2011/10/03/when-web-standards-fail=
-us/
>>
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Also=
 I am planning to create a local library
>>> version with support for configuration and a good documentation.
>>
>> I don't quite understand what you mean here. =A0The JavaScript code =
specific
>> to gitweb would have to be modified to use chosen JavaScript library=
, but
>> I wouldn't say it is "local library". =A0I'd rather we use stock Jav=
aScript
>> library, which would allow us to leverage existing CDNs like (for jQ=
uery)
>>
>> =A0http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js
>> =A0http://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.7.2.min.js
>> =A0http://code.jquery.com/jquery-1.7.2.min.js
>>
>> We probably would ultimately need to be able to serve local fallback=
 copy
>> (but this might be out of scope of GSoC project).
>>
>> This gitweb-specific JavaScript code (files in `gitweb/static/js/`)
>> is IMVHO quite well documented using JSDoc.
>>
>>> Using the DOM features of JavaScript and traversing the whole docum=
ent
>>> object is quite cubersome and error prone, so I want to replace the=
m using
>>> well tested libraries that are cross browser compatible.
>>
>> I think there is missing "using hand-crafted code" in this sentence
>> to make it sense.
>>
>>>
>>> Emulating onprogress in XMLHttpRequest :
>>>
>>> jQuery and YUI provide only statuses success and error.
>>
>> Right.
>>
>>> Even MooTools provide progress but are constrained to some browers
>>> only.
>>
>> To be more exact MooTools support 'onprogress' event handler only if
>> web browser supports it. =A0Not all do (e.g. older browsers), that i=
s why
>> there is need for emulation using timers.
>>
>>> It can be handled by using $.ajax Transport utility .
>>
>> You mean in jQuery here, isn't it? =A0It would be a bit different, I=
 think,
>> in MooTools or YUI.
>>
>> C.f. http://stackoverflow.com/questions/5652229/javascript-framework=
-with-or-easily-extendable-with-support-for-xmlhttprequest
>>
>>> I will also take care progressive enhancement, by carefully impleme=
nting the
>>> basic functionality of the gitweb so that what ever may be the brow=
ser
>>> version and type, internet connection the basic functionality will =
not
>>> disrupted.
>>
>> Errr... "progressive enhancement" is about using client-side scripti=
ng
>> in such way, that even if web browser doesn't support JavaScript
>> (e.g. text browsers such as lynx, elinks or w3m), or has JavaScript
>> turned off or blocked, we would get a basic functionality.
>>
>> Note also that "progressive enhancement" part applies only to writin=
g
>> new features, and this is strictly 'as time permits' part, I think.
>> But I thin that you would need to lay more complete proposal, i.e.
>> what features are you planning to add.
>>
>> --
>> Jakub Narebski
>> Poland
