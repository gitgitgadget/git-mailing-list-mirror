From: Eugene Sajine <euguess@gmail.com>
Subject: Re: Help creating git alias
Date: Wed, 30 Oct 2013 16:10:44 -0400
Message-ID: <CAPZPVFZ9WujUCQ1O9VfV83XUu_6g7Vp_MmYRCCO+GptOoSyvcg@mail.gmail.com>
References: <CAPZPVFbiSx8n0W1kcczCdC6ioVuWpwuUQ_pc9T=7i4X_FuZNhg@mail.gmail.com>
	<CAN0XMOKMF235S-23QcMj5cBup+Lh4vQs7QcOqXQ-MgafsAMKNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Andrew Ardill <andrew.ardill@gmail.com>
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 30 21:10:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vbc6L-0007yA-My
	for gcvg-git-2@plane.gmane.org; Wed, 30 Oct 2013 21:10:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754715Ab3J3UKq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Oct 2013 16:10:46 -0400
Received: from mail-we0-f173.google.com ([74.125.82.173]:37563 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752966Ab3J3UKp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Oct 2013 16:10:45 -0400
Received: by mail-we0-f173.google.com with SMTP id u57so1795554wes.18
        for <git@vger.kernel.org>; Wed, 30 Oct 2013 13:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=DncOjRNY/tNVpLkzOnMi/U8SQdqfXdGozSfyxT4fvqE=;
        b=kMJ0OrldFtmtNwW7DY6sJkSLx1meWmUcVFuTyjKmSlUVJGSPxErjrTqQR/dCokEn/N
         FTz7j/tZbull61A9rmDkAtjTc6rSC3sbtTF5Pe0t6HctBuOuEJ1UPX6I9pgfHGE1AqXr
         WXoFGe00CqYuhvYNGvBAf/NvBgvWMUBVVFc6XAqf9IoAeBWXt+RB8vN4ePJYCLPIHMN/
         sAm3xpuLG3z/9CmOqQaDKisefqmiOAjup4jNdOyiywejYKsrwtOdyyHEUdTaHopLSquK
         du6Bpk9e4Oo5CcRybqdriEy8f8U72gWx+AnUTPHfxpA/4/JLyIJOrWynNVb/yKcwUrAo
         eMVg==
X-Received: by 10.181.12.104 with SMTP id ep8mr3709222wid.54.1383163844362;
 Wed, 30 Oct 2013 13:10:44 -0700 (PDT)
Received: by 10.216.123.145 with HTTP; Wed, 30 Oct 2013 13:10:44 -0700 (PDT)
In-Reply-To: <CAN0XMOKMF235S-23QcMj5cBup+Lh4vQs7QcOqXQ-MgafsAMKNg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237066>

On Wed, Oct 30, 2013 at 3:57 PM, Ralf Thielow <ralf.thielow@gmail.com> wrote:
> lg=!git log --pretty=format:'%h %ad %ae %s' --date=short | sed 's/@\\S*//g'
>
> should work.


It did! thanks! I didn't know that "!sh -c" is not needed

>
> On Wed, Oct 30, 2013 at 8:34 PM, Eugene Sajine <euguess@gmail.com> wrote:
>> Hi,
>>
>> I need some advice about creating the git command alias:
>>
>> I have this as the command:
>>
>> git log --pretty=format:"%h %ad %ae %s" --date=short | sed 's/@\S*//g'
>>
>>
>> The purpose is to cut off the email domain and keep only username.
>>
>> I'm trying to create this as the alias:
>>
>>
>> lg = !sh -c 'git log --pretty=format:"%h %ad %ae %s" --date=short |
>> sed 's/@\S*//g'' -
>>
>> but it complains about the \S and i'm failing to come up with the
>> escape sequence to make it work right.
>>
>> I know i can work around that by creating shell alias, but it is not
>> what i would like to have.
>>
>> Any ideas?
>>
>> Thanks!
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
