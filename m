From: =?UTF-8?Q?Beno=C3=AEt_Person?= <benoit.person@ensimag.fr>
Subject: Re: [PATCH V3 1/4] git-mw: Introduction of GitMediawiki.pm
Date: Mon, 17 Jun 2013 01:41:22 +0200
Message-ID: <CAETqRChcu+N-2uNzL9_J6abR5fnduT5UVRif5NTQYOoxPTiRTw@mail.gmail.com>
References: <1371349893-7789-1-git-send-email-benoit.person@ensimag.fr>
	<1371349893-7789-2-git-send-email-benoit.person@ensimag.fr>
	<vpqobb5g679.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Celestin Matte <celestin.matte@ensimag.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jun 17 01:41:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UoMZc-0007vd-0d
	for gcvg-git-2@plane.gmane.org; Mon, 17 Jun 2013 01:41:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755559Ab3FPXlY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Jun 2013 19:41:24 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:59187 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755550Ab3FPXlX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Jun 2013 19:41:23 -0400
Received: by mail-ie0-f179.google.com with SMTP id c10so5494505ieb.10
        for <git@vger.kernel.org>; Sun, 16 Jun 2013 16:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=BF654Dn9JpxWjRVXnNUOSMpYQsx8G3zhYvK8eUZvu2Q=;
        b=v4F+FfuynhUSdOpRKoQhaCuqDeIJKD+00YxG4QJ97pvCY5IeDMJv5gdVnr+wasaMRW
         q09fatKcXR1reOEqT+VvWFQIcx37euWQpodQ29aTsg/VWbwXfehMUWXupFEc9LpNLloY
         x47RfADhwy8b77fveRxYLGJX3VXavMi84/g4yOJXFncKoXL6ErZPrJ/lsWqrywnyk5hc
         nWfmHgRLrgOnevBUHr9KhlGGGC5GmP6dhSUGEhwQkWafO30vvW/FL6oJ9VD1gm+b3cVR
         AyAxume/8kQ/41ukDOi7cu7z8c/HM53VdSjN1UnksvOJsPjiXzhaBnFVLrXsU7xJ73P3
         jlaA==
X-Received: by 10.50.101.4 with SMTP id fc4mr3664956igb.10.1371426083019; Sun,
 16 Jun 2013 16:41:23 -0700 (PDT)
Received: by 10.42.210.20 with HTTP; Sun, 16 Jun 2013 16:41:22 -0700 (PDT)
In-Reply-To: <vpqobb5g679.fsf@anie.imag.fr>
X-Google-Sender-Auth: 48aNJ1CX-s7lKocDUlF5wFkE0sE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228030>

On 16 June 2013 22:18, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> wrote:
> benoit.person@ensimag.fr writes:
>
>> changes from the V2:
>>   - Add a way to test, without installation, code that uses GitMediawiki.pm.
>
> This still needs to be documented, even very quickly, somewhere in the
> code (e.g a comment in the Makefile).
Well, I think I will have to re-read some docs (and some earlier
reviews) about what to write in commit messages, in the emails, in the
code as comments and in the documentation ... I am just totally lost
right now :/ .

>> -build install clean:
>> +copy_pm:
>> +     cp $(GIT_MEDIAWIKI_PM) $(GIT_ROOT_DIR)/perl/blib/lib/
>
> I already commented on this:
>
> http://thread.gmane.org/gmane.comp.version-control.git/227711/focus=227721
Oops, I forgot that one, so sorry :/ .

> Also, it seems to be only part of the solution. With your change, from
> contrib/mw-to-git/ and after running only "make",
>
> ./git-mw takes the installed version of GitMediawiki.pm in priority
>
> ../../bin-wrappers/git takes the installed version of git-mw only (i.e.
> does not know "git mw" if "make install" hasn't been ran).
Same thing as the documentation point, I think I am a bit lost in that
whole thing. I will re-look into it for the next version :/ .

>>  perlcritic:
>> -     perlcritic -2 *.perl
>> +     perlcritic -2 *.perl
>> \ No newline at end of file
>
> Please, avoid these whitespace-only changes. They create noise during
> review, and more potential conflicts.
For that one, I don't know why git assumes there is a change in it :
from what I see there is absolutely no whitespaces changes but maybe
my editor added some weird character somewhere ? I will look into that
for the next version ...

Thank you,

Benoit Person
