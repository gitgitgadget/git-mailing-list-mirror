From: John Szakmeister <john@szakmeister.net>
Subject: Re: [PATCH 3/4] {fast-export,transport-helper}: style cleanups
Date: Thu, 9 May 2013 05:30:51 -0400
Message-ID: <CAEBDL5Vu+gi_1CcJio0igNS2HmMrZNVUvWp3zeqjAgT6C7xZ0A@mail.gmail.com>
References: <1368062218-22440-1-git-send-email-felipe.contreras@gmail.com>
	<1368062218-22440-4-git-send-email-felipe.contreras@gmail.com>
	<CAEBDL5XZhEo14WKiz2m3KFRX+NsTFhmcz3adSti33RATMd897w@mail.gmail.com>
	<CAMP44s1R4YmyCFEQVRwSH6x-nDO-1=vDcA02C7F86GJk0zkS6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 09 11:30:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaNBi-0005rt-GD
	for gcvg-git-2@plane.gmane.org; Thu, 09 May 2013 11:30:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753439Ab3EIJax (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 May 2013 05:30:53 -0400
Received: from mail-wi0-f176.google.com ([209.85.212.176]:33693 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752956Ab3EIJaw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 May 2013 05:30:52 -0400
Received: by mail-wi0-f176.google.com with SMTP id hr14so72392wib.3
        for <git@vger.kernel.org>; Thu, 09 May 2013 02:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=jDqQ+84Ah8funErDM/sLljqXcdxLXDaYE+Wb1LQGrR8=;
        b=X6nC63iHLFmrC68C4SXe63jvAgWGZz7ZTj5JMtgpyyTmXoyUI6uM7WWCx493s+0T+v
         LD/4XBUO4QEv0A70+7UjhdfsUJfmlTsTMetnNKXVq2/x0yzPlvbjEKYzOj77rmEeh1KY
         vGSevct41S+XDSRmh/QfVWGXUrBAjKO2K/uKH3jonBhRBb6l0c/hXE09cdg3+ABNe1r4
         9xsIcD6wBX4Yf7g0yZXaiMWyxl3Tp5lNWyqCDDybvzsLcbKOoX6fv2TFL8Aj74I04+0O
         SrpsJRab6DDMPV0ykVqPWR1eYqEDCgW2S3WMVS/IW8t94cZYpjDY/CXIwG2YB04nD3eQ
         5Jlg==
X-Received: by 10.194.90.108 with SMTP id bv12mr16758803wjb.4.1368091851411;
 Thu, 09 May 2013 02:30:51 -0700 (PDT)
Received: by 10.180.78.69 with HTTP; Thu, 9 May 2013 02:30:51 -0700 (PDT)
In-Reply-To: <CAMP44s1R4YmyCFEQVRwSH6x-nDO-1=vDcA02C7F86GJk0zkS6g@mail.gmail.com>
X-Google-Sender-Auth: w6cBCNCNv7_na_W7xjXNekmWOfM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223723>

On Thu, May 9, 2013 at 4:50 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Thu, May 9, 2013 at 3:46 AM, John Szakmeister <john@szakmeister.net> wrote:
>> On Wed, May 8, 2013 at 9:16 PM, Felipe Contreras
[snip]
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
> AFAIK neither the git or the Linux code-style specify how multiple
> lines with open parenthesis should align.

True, but I'm sure you know well that the Linux coding style tends to
follow the GNU coding style--with modifications--which lines up args
with the first character inside the paren
(http://www.gnu.org/prep/standards/html_node/Formatting.html#Formatting-Your-Source-Code),
and it's clear that's what the previous author had done.

The hope was that you let your search and replace run awry, and I was
just pointing out that it did, so it could fixed it up.  *shrug*  I've
had little participation, so I don't consider my opinion to count for
much on the matter.

-John
