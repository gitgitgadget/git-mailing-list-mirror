From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 3/4] {fast-export,transport-helper}: style cleanups
Date: Thu, 16 May 2013 04:23:41 -0500
Message-ID: <CAMP44s3J8YpULYenDoYhyRJXSXL3b8-vpMbW2c4LcjK43Xidng@mail.gmail.com>
References: <1368062218-22440-1-git-send-email-felipe.contreras@gmail.com>
	<1368062218-22440-4-git-send-email-felipe.contreras@gmail.com>
	<CAEBDL5XZhEo14WKiz2m3KFRX+NsTFhmcz3adSti33RATMd897w@mail.gmail.com>
	<7v7gj77nt9.fsf@alter.siamese.dyndns.org>
	<CAMP44s1HDp+ojGK0UhKHF=1iDu5_E9Z0VrK-JtMked1mtH_2gQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: John Szakmeister <john@szakmeister.net>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 16 11:23:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcuPc-0002GO-7m
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 11:23:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751269Ab3EPJXo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 05:23:44 -0400
Received: from mail-la0-f48.google.com ([209.85.215.48]:49894 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751190Ab3EPJXn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 05:23:43 -0400
Received: by mail-la0-f48.google.com with SMTP id fs12so2743142lab.21
        for <git@vger.kernel.org>; Thu, 16 May 2013 02:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=izoOTdk5pyE/e36JozzaSyzydemvAnpROeEtHZxuEOU=;
        b=EfR4gQKwsW7iAKhaBv59W+3rT/nUZQEBeIbH2YBUlJj7UkLDSxdyPLoic/SmMjOxmC
         gPW3EVpr1p7Fw0f89IhSGA5uH26Yz+cd319PV2J9PT21yiKgOnNpIsonHtFXT0IAz+hM
         EPcvXP6vOsOVys8369upvhVkuzVLkNAN1/fI8JdvhSR2uglsWXPPtGGjNVABxGMRMMNN
         +KyKa3VWoOBVIsd8Yf8AE3Idp4wbJwWNKbxYr8G8JU7A/M2WKw4wN0dCnvyc+u9fCiG6
         U7FZ/AL2N41Z7kE/FE16HSh0sBRLJFhmLvBB6U2I9qvfrjALfz2T/rO1FfiucaCLZPtx
         hojA==
X-Received: by 10.112.135.70 with SMTP id pq6mr19699876lbb.82.1368696221081;
 Thu, 16 May 2013 02:23:41 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Thu, 16 May 2013 02:23:41 -0700 (PDT)
In-Reply-To: <CAMP44s1HDp+ojGK0UhKHF=1iDu5_E9Z0VrK-JtMked1mtH_2gQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224521>

On Thu, May 9, 2013 at 6:12 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Thu, May 9, 2013 at 6:09 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> John Szakmeister <john@szakmeister.net> writes:
>>
>>> On Wed, May 8, 2013 at 9:16 PM, Felipe Contreras
>>> <felipe.contreras@gmail.com> wrote:
>>>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>>>> ---
>>>>  builtin/fast-export.c | 24 ++++++++++++------------
>>>>  1 file changed, 12 insertions(+), 12 deletions(-)
>>>>
>>>> diff --git a/builtin/fast-export.c b/builtin/fast-export.c
>>>> index d60d675..8091354 100644
>>>> --- a/builtin/fast-export.c
>>>> +++ b/builtin/fast-export.c
>>>> @@ -135,7 +135,7 @@ static void export_blob(const unsigned char *sha1)
>>> [snip]
>>>> @@ -289,13 +289,13 @@ static void handle_commit(struct commit *commit, struct rev_info *rev)
>>>>         parse_commit(commit);
>>>>         author = strstr(commit->buffer, "\nauthor ");
>>>>         if (!author)
>>>> -               die ("Could not find author in commit %s",
>>>> +               die("Could not find author in commit %s",
>>>>                      sha1_to_hex(commit->object.sha1));
>>>
>>> It looks like your simple replace didn't account for calls with
>>> multiple lines.  Now the remaining lines don't line up.
>>> :-)  There's several more places like this in the patch.
>>
>> Good eyes.
>>
>> Matching the coding-style to have no SP between function name and
>> its argument list is just as important as matching the indentation
>> style used in the project; trading one breakage with another does
>> not make much sense.
>
> Where exactly in Documentation/CodingGuidelines is the "indentation
> style" used in the project specified that is being violated?

I find it extremely annoying that an obviously correct patch is not
merged because it's not conforming to a non-existing coding-style
guideline that not even the Linux project follows. I've sent many
patches where I change the alignment from cino=(0, to cino=(2s, and
the get applied because if it's not mentioned in
Documentation/CodingStyle, it cannot be used as a reason for
rejection.

I fixed the style so it conforms to Documentation/CodingGuidelines,
and nowhere in there is the open parenthesis alignment mentioned, so
using that as a reason to reject this patch is a mistake in my
opinion.

If you prefer the code to not follow Documentation/CodingGuidelines,
so be it. I'm not going to work on this patch any more.

-- 
Felipe Contreras
