From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: [PATCH] de.po: Fixup one translation
Date: Tue, 23 Sep 2014 12:42:46 +0200
Message-ID: <CAN0XMO+D7dDh_Xpcgekg3fsDA9Zhh+i7Asi46G3aBpnknivNjA@mail.gmail.com>
References: <1411457847-10419-1-git-send-email-stefanbeller@gmail.com>
	<CAPig+cTFW7gEEezkEbRTu-N88Er26OEm6FE47M8c1XSh8Q_a7g@mail.gmail.com>
	<542132AB.9030305@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Ralf Thielow <ralf.thielow@googlemail.com>,
	Git List <git@vger.kernel.org>
To: Stefan Beller <stefanbeller@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 23 12:42:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XWNYa-0006eg-IO
	for gcvg-git-2@plane.gmane.org; Tue, 23 Sep 2014 12:42:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754980AbaIWKms (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2014 06:42:48 -0400
Received: from mail-wg0-f46.google.com ([74.125.82.46]:54489 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754381AbaIWKmr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2014 06:42:47 -0400
Received: by mail-wg0-f46.google.com with SMTP id a1so4088469wgh.5
        for <git@vger.kernel.org>; Tue, 23 Sep 2014 03:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=yBxXMAJSmec56miL0W6i9/X7Hmy2Y9chvnOxnfXnq6M=;
        b=nCK+pDHVuVkYicwu/Zk9evsF/fIamk8fEFTIpoehzzir8G/xWH0OvOub0ksChvEeDe
         yeApU/TPGNJzmDx2ypg27aAzP9AxRSlLecvKRCmFUUyycRqykc+T/X29qAPiWyhfMgAh
         0AryHqMJHJaIEVSTQxhoEccAJlY9H4d0of9FoYxq03ci383Jirui5oMFTPbThEnJqANm
         rPEXDzKG2Joy0eFM7xame6a5f6gIB98W42XXPV1kYn80/cyQ6Ln4MILO7vgEEBHJTPUi
         K8cs1AnikEGyNMT0WUxjtwq3RIh19ZvokpOQCW9/pa4z7fwbIBu22edHEzHMbpOJrvvh
         BaQg==
X-Received: by 10.194.134.100 with SMTP id pj4mr27883580wjb.72.1411468966550;
 Tue, 23 Sep 2014 03:42:46 -0700 (PDT)
Received: by 10.194.173.167 with HTTP; Tue, 23 Sep 2014 03:42:46 -0700 (PDT)
In-Reply-To: <542132AB.9030305@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257410>

2014-09-23 10:43 GMT+02:00 Stefan Beller <stefanbeller@gmail.com>:
> On 23.09.2014 10:06, Eric Sunshine wrote:
>> On Tue, Sep 23, 2014 at 3:37 AM, Stefan Beller <stefanbeller@gmail.com> wrote:
>>> English grammar with German words doesn't make it a German translation. ;)
>>> We also need to fix the
>>
>> Sentence fragment.
>
> Yeah, originally I intended to just fix the singular form and let the
> plural form slip. But then I did both singular and plural form and
> forgot about the already started commit message.
>
> Anyways I'd assume Ralf will incorporate this patch in a larger patch
> for the German translation, so the commit message for this particular
> patch is of minor relevance.
>

I'd prefer to pick the patch, but with no or another commit message. ;)

Thanks

> Thanks,
> Stefan
>
>>
>>> Signed-off-by: Stefan Beller <stefanbeller@gmail.com>
>>> ---
>>>  po/de.po | 8 ++++----
>>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/po/de.po b/po/de.po
>>> index e5d2b25..bae3723 100644
>>> --- a/po/de.po
>>> +++ b/po/de.po
>>> @@ -3463,13 +3463,13 @@ msgid_plural ""
>>>  "\n"
>>>  "%s\n"
>>>  msgstr[0] ""
>>> -"Warnung: Sie sind um %d Commit hinterher, nicht verbunden zu\n"
>>> -"einem Ihrer Branches:\n"
>>> +"Warnung: Sie sind um %d Commit hinterher, folgende Commits sind in\n"
>>> +"keinem Ihrer Branches enthalten: \n"
>>>  "\n"
>>>  "%s\n"
>>>  msgstr[1] ""
>>> -"Warnung: Sie sind um %d Commits hinterher, nicht verbunden zu\n"
>>> -"einem Ihrer Branches:\n"
>>> +"Warnung: Sie sind um %d Commits hinterher, folgende Commits sind in\n"
>>> +"keinem Ihrer Branches enthalten: \n"
>>>  "\n"
>>>  "%s\n"
>>>
>>> --
>>> 2.1.0.238.gce1d3a9
>
