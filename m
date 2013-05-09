From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 3/4] {fast-export,transport-helper}: style cleanups
Date: Thu, 9 May 2013 05:18:25 -0500
Message-ID: <CAMP44s3JE0wPJJy+PN2tzfAabrYb3oGHUkhCRnY52O8T77TGAg@mail.gmail.com>
References: <1368062218-22440-1-git-send-email-felipe.contreras@gmail.com>
	<1368062218-22440-4-git-send-email-felipe.contreras@gmail.com>
	<CAEBDL5XZhEo14WKiz2m3KFRX+NsTFhmcz3adSti33RATMd897w@mail.gmail.com>
	<CAMP44s1R4YmyCFEQVRwSH6x-nDO-1=vDcA02C7F86GJk0zkS6g@mail.gmail.com>
	<CAEBDL5Vu+gi_1CcJio0igNS2HmMrZNVUvWp3zeqjAgT6C7xZ0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: John Szakmeister <john@szakmeister.net>
X-From: git-owner@vger.kernel.org Thu May 09 12:18:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaNvp-0008SG-1t
	for gcvg-git-2@plane.gmane.org; Thu, 09 May 2013 12:18:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753482Ab3EIKSa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 May 2013 06:18:30 -0400
Received: from mail-la0-f41.google.com ([209.85.215.41]:64903 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751522Ab3EIKSa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 May 2013 06:18:30 -0400
Received: by mail-la0-f41.google.com with SMTP id lx15so214304lab.0
        for <git@vger.kernel.org>; Thu, 09 May 2013 03:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=qH5YTYDSuf8hxVGGOQGTlIIcf7kcz9hTfzknOPqxBwo=;
        b=0YupXUh+Ch9aDXouoQ7wDyncMRs26zQihQdzFdExPMcIZMM9A1QsMycrtU1XCo7wN6
         w0VrkC4GXD5WlbWAxaU+h245pVFp5xBNY3l+4tCgv4Yelncvf5oI3Ld91c3gRInFyiX/
         0g2RmU6Xb1+AEK7RKtl2PsPzDMrr3M0crlrr2OwNojruccZmA3YPvBnINtVSC0Vwdb1/
         s3pFTo5se2Z6v9iqfaXdxnSIILsvem4gC7bU9iPwt+8POjA2AFqBkZGCg/qtqeut5YVO
         H5O8tqQW5oOZxfwYkROY5laeuIQ6UUQNoHPWyAFw2eDm7zUx2BU/g7LGUFnJ/AehC3nO
         LrSA==
X-Received: by 10.112.1.166 with SMTP id 6mr5044238lbn.135.1368094705539; Thu,
 09 May 2013 03:18:25 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Thu, 9 May 2013 03:18:25 -0700 (PDT)
In-Reply-To: <CAEBDL5Vu+gi_1CcJio0igNS2HmMrZNVUvWp3zeqjAgT6C7xZ0A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223724>

On Thu, May 9, 2013 at 4:30 AM, John Szakmeister <john@szakmeister.net> wrote:
> On Thu, May 9, 2013 at 4:50 AM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> On Thu, May 9, 2013 at 3:46 AM, John Szakmeister <john@szakmeister.net> wrote:
>>> On Wed, May 8, 2013 at 9:16 PM, Felipe Contreras
> [snip]
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
>> AFAIK neither the git or the Linux code-style specify how multiple
>> lines with open parenthesis should align.
>
> True, but I'm sure you know well that the Linux coding style tends to
> follow the GNU coding style--with modifications--which lines up args
> with the first character inside the paren
> (http://www.gnu.org/prep/standards/html_node/Formatting.html#Formatting-Your-Source-Code),
> and it's clear that's what the previous author had done.

No, I don't. I don't see how the GNU style has anything to do with the
Linux style.

-- 
Felipe Contreras
