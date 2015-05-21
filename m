From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: [PATCH 1/3] l10: de.po: grammar fix
Date: Thu, 21 May 2015 22:27:53 +0200
Message-ID: <CAN0XMOL8vPBpJi=LuQBDsDjm68mjvMJXOGr8aTqemcCaB4FY1Q@mail.gmail.com>
References: <cover.1432025365.git.git@drmicha.warpmail.net>
	<2b4460dbf6abb15c4cd94d4c5c335cc9e8059ee7.1432025365.git.git@drmicha.warpmail.net>
	<CAGZ79kYPhTK=tymEcB_YsYdNZvt0=sA4-Hon1SLwujV39W7fmA@mail.gmail.com>
	<555C4C14.4040305@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Ralf Thielow <ralf.thielow@googlemail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu May 21 22:28:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvX4U-0001En-9n
	for gcvg-git-2@plane.gmane.org; Thu, 21 May 2015 22:28:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932258AbbEUU15 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2015 16:27:57 -0400
Received: from mail-wi0-f181.google.com ([209.85.212.181]:36452 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932124AbbEUU1y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 16:27:54 -0400
Received: by wizk4 with SMTP id k4so27230613wiz.1
        for <git@vger.kernel.org>; Thu, 21 May 2015 13:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=1/j/a4yMT2/qlPnvbFlP43GLgCyP6tUkRHur4a9undE=;
        b=xaSbMEk4X9bUDKdL9lKBC+b7DRdz8koD2GyHMRqjRzk2Ei9JDtzlASzDbYrQSX5yW/
         OvFmqtNFeO9pnq0Vzx48vP0Z6lZ8NTlrSrM1CIKCI9UxLv4YCZfOnUL4pcFx7TUSwIiZ
         SHxRGbDjUtnrvbOkMi1iPIyxll6kWUnFzvvnGf5C9wNL47pV3x+xbw9Z1wNzaPLe3t+I
         +BhXHWzAgquRrvwh6iBfUXdoSn+rZfbgZ6vMl83Fr+KOLKGb4nF6rcG1/6QvhnuGKwMF
         Q75/99tTTEXQzsjrfmw2ZRIdNNGIqIJwGMwrMNfKBHs/c2py/DoBFFZ78hZJRb3VyLyN
         y5+w==
X-Received: by 10.195.18.1 with SMTP id gi1mr8685064wjd.0.1432240073784; Thu,
 21 May 2015 13:27:53 -0700 (PDT)
Received: by 10.194.72.6 with HTTP; Thu, 21 May 2015 13:27:53 -0700 (PDT)
In-Reply-To: <555C4C14.4040305@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269657>

2015-05-20 10:55 GMT+02:00 Michael J Gruber <git@drmicha.warpmail.net>:
> Stefan Beller venit, vidit, dixit 19.05.2015 23:46:
>> On Tue, May 19, 2015 at 1:51 AM, Michael J Gruber
>> <git@drmicha.warpmail.net> wrote:
>>> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
>>> ---
>>>  po/de.po | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/po/de.po b/po/de.po
>>> index 2feaec1..25258e3 100644
>>> --- a/po/de.po
>>> +++ b/po/de.po
>>> @@ -10478,7 +10478,7 @@ msgstr ""
>>>  #: git-am.sh:142
>>>  msgid "Using index info to reconstruct a base tree..."
>>>  msgstr ""
>>> -"Verwende Informationen aus der Staging-Area, um einen Basisverzeichnis "
>>> +"Verwende Informationen aus der Staging-Area, um ein Basisverzeichnis "
>>>  "nachzustellen"
>>
>> Waere es sinnvoll Staging-Area in Staging-Bereich umzubenennen?
>> "Staging" ist wohl ein eher fester Term mit dem man den index/staging area
>> assoziert, aber "Area" 'doesn't ring a bell for me'.
>
> Staging-Bereich would be Denglish - half German and halb Englisch.
>
> In any case, the term staging area is highly confusing in this context:
> It really is the index, and in this case the user has not "staged
> anything for commit" in the index. The index is used for storing
> information during the 3way merge. This is why we refused to replace
> "index/cache" by "staging area" in the original git documentation.
>
> The de l10n team decided to use "Staging-Area" as the translation for
> "index" (as far as I can see), and therefore I kept this term: It is
> important to translate the same concept in the same way consistently in
> all places. Changing the translation of "index" would be a major
> decision and a major patch. (I'd vote for "Index".)
>

The initial version of the glossary of git.git's de.po has been developed in
thread [1], where "Index" was part of, initially. We ended up only using
"Staging-Area" for "index", because people might understand "Index"
as a book's index or database's index [2].

Git itself uses the term "staging area" *very* rarely. "index" would be a
Git term we don't translate, but there's also the German word "Index"
and hence we might confuse users. However, I still think it may only be
confusing for absolute newbies, but give a benefit for users who knows
about git's index. I'll send a patch for this change.

Thanks

[1]
http://thread.gmane.org/gmane.comp.version-control.git/224132/
[2]
http://article.gmane.org/gmane.comp.version-control.git/224974

> Michael
