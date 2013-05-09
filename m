From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 3/4] {fast-export,transport-helper}: style cleanups
Date: Thu, 9 May 2013 03:50:23 -0500
Message-ID: <CAMP44s1R4YmyCFEQVRwSH6x-nDO-1=vDcA02C7F86GJk0zkS6g@mail.gmail.com>
References: <1368062218-22440-1-git-send-email-felipe.contreras@gmail.com>
	<1368062218-22440-4-git-send-email-felipe.contreras@gmail.com>
	<CAEBDL5XZhEo14WKiz2m3KFRX+NsTFhmcz3adSti33RATMd897w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: John Szakmeister <john@szakmeister.net>
X-From: git-owner@vger.kernel.org Thu May 09 10:50:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaMYa-0003T2-82
	for gcvg-git-2@plane.gmane.org; Thu, 09 May 2013 10:50:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752127Ab3EIIu0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 May 2013 04:50:26 -0400
Received: from mail-lb0-f173.google.com ([209.85.217.173]:59973 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751305Ab3EIIuZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 May 2013 04:50:25 -0400
Received: by mail-lb0-f173.google.com with SMTP id 10so278271lbf.18
        for <git@vger.kernel.org>; Thu, 09 May 2013 01:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=m4zRDyx8SrCYhLH6oGkxInw9c6cwcH2ZXCEgjRaLxmM=;
        b=L/fOqmbB0xhJNgmIjznUQmVbZdE/eDfOeVrSJz2f8b6181di5HFJ4frxkJq6BzcEZR
         4JT4qZtZ54pgXDrRSO8chK9qgrHQ4PZEyZnHjhi8I0YEBVDZemIA9JH91ec1uktqnG4f
         /6wyqZFdHuVsf+w389hUceEab0ZekJfANgRMmMTnWQVSeveTIcy8e/g3SdJ1bfS5zqH7
         4NQGn8NeFBy+UKyZ99uWtxboHDIrgJbxYP9U/Jt7+4jHuoFZQPKJhlpp3NnaL3L3o3H8
         4tp0cgDcu4epsDZD2nA+xSty6O00yVdCe+exTV+gnX09FeD/gzMCKsS8bM6pnqIX7lH4
         /bcg==
X-Received: by 10.152.22.168 with SMTP id e8mr4922500laf.20.1368089423782;
 Thu, 09 May 2013 01:50:23 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Thu, 9 May 2013 01:50:23 -0700 (PDT)
In-Reply-To: <CAEBDL5XZhEo14WKiz2m3KFRX+NsTFhmcz3adSti33RATMd897w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223716>

On Thu, May 9, 2013 at 3:46 AM, John Szakmeister <john@szakmeister.net> wrote:
> On Wed, May 8, 2013 at 9:16 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>> ---
>>  builtin/fast-export.c | 24 ++++++++++++------------
>>  1 file changed, 12 insertions(+), 12 deletions(-)
>>
>> diff --git a/builtin/fast-export.c b/builtin/fast-export.c
>> index d60d675..8091354 100644
>> --- a/builtin/fast-export.c
>> +++ b/builtin/fast-export.c
>> @@ -135,7 +135,7 @@ static void export_blob(const unsigned char *sha1)
> [snip]
>> @@ -289,13 +289,13 @@ static void handle_commit(struct commit *commit, struct rev_info *rev)
>>         parse_commit(commit);
>>         author = strstr(commit->buffer, "\nauthor ");
>>         if (!author)
>> -               die ("Could not find author in commit %s",
>> +               die("Could not find author in commit %s",
>>                      sha1_to_hex(commit->object.sha1));
>
> It looks like your simple replace didn't account for calls with
> multiple lines.  Now the remaining lines don't line up.
> :-)  There's several more places like this in the patch.

AFAIK neither the git or the Linux code-style specify how multiple
lines with open parenthesis should align.

-- 
Felipe Contreras
