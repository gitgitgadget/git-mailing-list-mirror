From: Alexander Gallego <gallego.alexx@gmail.com>
Subject: Re: git branch case insensitivity (Possible bug)
Date: Wed, 9 Jan 2013 12:03:15 -0500
Message-ID: <CAL+iW2-eTtMnn65HN9zeFBFXubgkCA7RwVRZjkq7+tRpPk1TGg@mail.gmail.com>
References: <CAL+iW28LdnNiho4KksLX_S_-+bKX+77GPJ0zqQfkz4JpBJRskw@mail.gmail.com>
 <50ED925B.2060402@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Wed Jan 09 18:03:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tsz4H-0002SB-HM
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jan 2013 18:03:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932205Ab3AIRDi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2013 12:03:38 -0500
Received: from mail-wg0-f52.google.com ([74.125.82.52]:45271 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932123Ab3AIRDh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2013 12:03:37 -0500
Received: by mail-wg0-f52.google.com with SMTP id 12so1098875wgh.31
        for <git@vger.kernel.org>; Wed, 09 Jan 2013 09:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=woXMJEBGa8r1QAy5YfgyWOdaxvvFdrBdqj2hogrkSy4=;
        b=nJvUQQOGQrrmCS4REPbe28t6qcD885hWPBixaQJgqf2eq0Kz29/AQfH9V+0K/XtKyx
         QDR5ZHLIxR9OfKzuIx6NqgjfCM2ylDE2Vkdtn9yITIaMZSABJXWytQl/L6CZ9Oqqh/A6
         cnc3W55HN/FM1cOd4J8PrkDrJxAspBGjArWM/COFgbu+inNahSuX8G17XSSGxB4Is3QJ
         dsIkhTd4eYQIqCQfBpiyMBdFLXNcPI6OrQgu21C/7fDt5l90axf20lJ5fOzEagdyGoxO
         Ayj4frZtdmKtSOUDIn3V//NSJCPs6L9eHgEO2TugSuORLmIBMhmOESjUFsnStScwsXXc
         sKkw==
Received: by 10.194.174.196 with SMTP id bu4mr109251742wjc.35.1357751016259;
 Wed, 09 Jan 2013 09:03:36 -0800 (PST)
Received: by 10.194.242.69 with HTTP; Wed, 9 Jan 2013 09:03:15 -0800 (PST)
In-Reply-To: <50ED925B.2060402@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213069>

On Wed, Jan 9, 2013 at 10:52 AM, Andreas Ericsson <ae@op5.se> wrote:
> On 01/09/2013 04:46 PM, Alexander Gallego wrote:
>> Hello,
>>
>> Here is a pastebin where I've reproduced the steps on a clean git repo.
>>
>> http://pastebin.com/0vQZEat0
>>
>>
>>
>> Brief description of the problem:
>>
>>
>>
>> 1.Basically one creates a local branch call it 'imp_fix' (branch off
>> master --> this doesn't matter)
>> 2.One does work, commit, etc
>> 3.One rebases imp_fix with master via: (inside imp_fix) git rebase master
>> 4.One checks out master via: git checkout master
>> 5.One merges an incorrect name "imp_Fix" (notice the capital F)
>> 6.The expected output is that git would say, silly you --> that branch
>> does not exist.
>> 7. Instead it merges (what I think is incorrectly) imp_fix.
>>
>>
>> Kindly let me know if I can provide more details.
>>
>
> Are you using Mac OSX?

Yes

> Are you using the HFS+ filesystem shipped with it?

Likely. I have not touched the fs settings.

> Did you use the filesystem's default settings rather than reinstall your
> system with sensible settings?

Yup. I use whatever was shipped with it.

> If you said "yes" to all of the above, this is a filesystem "feature",
> courtesy of (cr)Apple, and you're screwed.
>
> You can work around it by running "git pack-refs" every time you create
> a branch or a tag though.

Thanks for the tips. I'll be sure to use this.


> --
> Andreas Ericsson                   andreas.ericsson@op5.se
> OP5 AB                             www.op5.se
> Tel: +46 8-230225                  Fax: +46 8-230231
>
> Considering the successes of the wars on alcohol, poverty, drugs and
> terror, I think we should give some serious thought to declaring war
> on peace.
