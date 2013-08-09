From: Justin Collum <jcollum@gmail.com>
Subject: Re: git status resets permissions on index file -- Ubuntu 12.04 64b
Date: Fri, 9 Aug 2013 12:29:54 -0700
Message-ID: <CACO0oR7Kx0auNV6GRwqr-OdtnrCW21LxiMFrNUDRGRJN+P6ebg@mail.gmail.com>
References: <CACO0oR7a1-fUASQ+SJVbH1CU8d=NbHrK0MuMu+9Pr4_=7q85Vw@mail.gmail.com>
	<52040F27.4050908@googlemail.com>
	<20130808221807.GA8518@gmail.com>
	<C525FA0D-D22C-4C78-8C97-45819FD58DD7@gmail.com>
	<CACO0oR7tJNKWA=cynBA8R2kaGr2iKNCiCmXKLur9nub6pnBG0g@mail.gmail.com>
	<8761vf3uml.fsf@igel.home>
	<CACO0oR4_+=6iimO4U0rt2JuhfxrX1CkjWR5iMkt=+EuxscmBMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "Kyle J. McKay" <mackyle@gmail.com>,
	Stefan Beller <stefanbeller@googlemail.com>,
	Andrew Ruder <andy@aeruder.net>, Git List <git@vger.kernel.org>
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Fri Aug 09 21:30:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7sNr-0005JU-Jz
	for gcvg-git-2@plane.gmane.org; Fri, 09 Aug 2013 21:29:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030527Ab3HIT3z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Aug 2013 15:29:55 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:40677 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030224Ab3HIT3z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Aug 2013 15:29:55 -0400
Received: by mail-ie0-f169.google.com with SMTP id qd12so4818413ieb.14
        for <git@vger.kernel.org>; Fri, 09 Aug 2013 12:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=M86+yX9DZ2zV5K9vYK6oQIiLpYIBmtZeUpF3CxolwUg=;
        b=OBCpAFnd8DTtNX+NxOR/47Ej4vMkGIu7eHlpp1RMlHF3a8N/Niy/dohhcK9f5CNqZe
         6lLMIUadxPw9wkcIoDdQoA4sZDtO0l2XWF+OEumdbosJbbqZAJia5tY9wars9bK4buB8
         XVdivoIEHNUNoCjIjJQc45Do97+3gho0X0+xFYV0+x38mtLyDl7Z0NCR3SRw4Qbz/gfm
         SU1pVE+g10D0p5Fn+g/H+QRg1KdnDcVY1qWun1n0CJpsuTeayQxcsbb56vzV8S7h8n1G
         CUkkAmxyrsiZIohgIE8IQDgdjD6olFXprJGJ+EHuIP05RwY7X/cpU3ighQgVa+8HQplg
         xw+Q==
X-Received: by 10.43.77.137 with SMTP id zi9mr5026549icb.106.1376076594497;
 Fri, 09 Aug 2013 12:29:54 -0700 (PDT)
Received: by 10.43.146.70 with HTTP; Fri, 9 Aug 2013 12:29:54 -0700 (PDT)
In-Reply-To: <CACO0oR4_+=6iimO4U0rt2JuhfxrX1CkjWR5iMkt=+EuxscmBMg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232014>

I've looked into this a bit and I think this is a bug in Webstorm.
Webstorm saves files a lot without you actually hitting save, so
that's why I didn't put 2 and 2 together. It appears that any file
change in Webstorm is screwing up the permissions on git's index --
but only in 64b Ubuntu, it wasn't happening in 32b.

On Fri, Aug 9, 2013 at 10:00 AM, Justin Collum <jcollum@gmail.com> wrote:
>> That doesn't make sense.  If you are the owner of the file, why do you need sudo???
>
> I've just never seen a chmod command without sudo. I assumed it was
> needed. Is this relevant to the bug that I'm seeing?
>
> On Fri, Aug 9, 2013 at 5:40 AM, Andreas Schwab <schwab@linux-m68k.org> wrote:
>> Justin Collum <jcollum@gmail.com> writes:
>>
>>>      sudo chmod 644 ./.git/index
>>
>> That doesn't make sense.  If you are the owner of the file, why do you
>> need sudo???
>>
>> Andreas.
>>
>> --
>> Andreas Schwab, schwab@linux-m68k.org
>> GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
>> "And now for something completely different."
