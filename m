From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 3/4] {fast-export,transport-helper}: style cleanups
Date: Thu, 9 May 2013 18:12:49 -0500
Message-ID: <CAMP44s1HDp+ojGK0UhKHF=1iDu5_E9Z0VrK-JtMked1mtH_2gQ@mail.gmail.com>
References: <1368062218-22440-1-git-send-email-felipe.contreras@gmail.com>
	<1368062218-22440-4-git-send-email-felipe.contreras@gmail.com>
	<CAEBDL5XZhEo14WKiz2m3KFRX+NsTFhmcz3adSti33RATMd897w@mail.gmail.com>
	<7v7gj77nt9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: John Szakmeister <john@szakmeister.net>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 10 01:13:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uaa1O-0003NG-Fw
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 01:13:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932580Ab3EIXMx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 May 2013 19:12:53 -0400
Received: from mail-lb0-f173.google.com ([209.85.217.173]:52338 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756048Ab3EIXMu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 May 2013 19:12:50 -0400
Received: by mail-lb0-f173.google.com with SMTP id 10so1129888lbf.18
        for <git@vger.kernel.org>; Thu, 09 May 2013 16:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=CUC/VzEXLnXeFfCjouD7DB9+q6Mretra+uyiCWhk4ko=;
        b=K+rH6c+0D7nF20T55Uzkxa4RxXQ5q4UvjmqK+k7p4VOvcsMw45BCpSVn9h1c6UZ9sb
         t+FX9J0pvwRkDapIZmvLOGg4k7rU81jTT6gUHQ86XsqBdfBcV/juBzj1Lt0GGf4YLNZ4
         kLdS74ukGSpzZFgW+FWRM8IU0sR4/2cW3fUWfWZ+/h25yF7+T8WbAh6SEiZ5w0iNY7wt
         MSFRY2I89elbnhPh35cNZR8Q+7LHfDewGFdkhVZilqzBLsXmPJvJUQvr8+VfqAQZqPeQ
         KuvRGphbutPHq+46/VUaKfjDfuRKg3f4R4quul+k/yYmfT7+/IHoSCZSoBpiz1lgDAbg
         SbaQ==
X-Received: by 10.112.166.101 with SMTP id zf5mr6323065lbb.59.1368141169092;
 Thu, 09 May 2013 16:12:49 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Thu, 9 May 2013 16:12:49 -0700 (PDT)
In-Reply-To: <7v7gj77nt9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223801>

On Thu, May 9, 2013 at 6:09 PM, Junio C Hamano <gitster@pobox.com> wrote:
> John Szakmeister <john@szakmeister.net> writes:
>
>> On Wed, May 8, 2013 at 9:16 PM, Felipe Contreras
>> <felipe.contreras@gmail.com> wrote:
>>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>>> ---
>>>  builtin/fast-export.c | 24 ++++++++++++------------
>>>  1 file changed, 12 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/builtin/fast-export.c b/builtin/fast-export.c
>>> index d60d675..8091354 100644
>>> --- a/builtin/fast-export.c
>>> +++ b/builtin/fast-export.c
>>> @@ -135,7 +135,7 @@ static void export_blob(const unsigned char *sha1)
>> [snip]
>>> @@ -289,13 +289,13 @@ static void handle_commit(struct commit *commit, struct rev_info *rev)
>>>         parse_commit(commit);
>>>         author = strstr(commit->buffer, "\nauthor ");
>>>         if (!author)
>>> -               die ("Could not find author in commit %s",
>>> +               die("Could not find author in commit %s",
>>>                      sha1_to_hex(commit->object.sha1));
>>
>> It looks like your simple replace didn't account for calls with
>> multiple lines.  Now the remaining lines don't line up.
>> :-)  There's several more places like this in the patch.
>
> Good eyes.
>
> Matching the coding-style to have no SP between function name and
> its argument list is just as important as matching the indentation
> style used in the project; trading one breakage with another does
> not make much sense.

Where exactly in Documentation/CodingGuidelines is the "indentation
style" used in the project specified that is being violated?

-- 
Felipe Contreras
