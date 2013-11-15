From: "Jason St. John" <jstjohn@purdue.edu>
Subject: Re: [PATCH 2/2] Fix minor grammatical and other formatting issues in
 the "git log" man page
Date: Thu, 14 Nov 2013 20:47:27 -0500
Message-ID: <CAEjxke-O0MnWvPabeUOVGFnxs0rW6J0q72JRxh7s_zqqSxxkXw@mail.gmail.com>
References: <1384323709-2690-1-git-send-email-jstjohn@purdue.edu>
 <1384323709-2690-2-git-send-email-jstjohn@purdue.edu> <xmqqy54sc6ev.fsf@gitster.dls.corp.google.com>
 <CAEjxke8vLtA5CgW8v4zv58kexe631koniNpdqTrr8LFYAOrMuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 15 02:47:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vh8Vl-0004NL-Tk
	for gcvg-git-2@plane.gmane.org; Fri, 15 Nov 2013 02:47:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755145Ab3KOBrv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Nov 2013 20:47:51 -0500
Received: from mailhub246.itcs.purdue.edu ([128.210.5.246]:32819 "EHLO
	mailhub246.itcs.purdue.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754773Ab3KOBrt (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Nov 2013 20:47:49 -0500
Received: from mail-qc0-f174.google.com (mail-qc0-f174.google.com [209.85.216.174])
	(authenticated bits=0)
	by mailhub246.itcs.purdue.edu (8.14.4/8.14.4/mta-auth.smtp.purdue.edu) with ESMTP id rAF1lm2X015735
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <git@vger.kernel.org>; Thu, 14 Nov 2013 20:47:48 -0500
Received: by mail-qc0-f174.google.com with SMTP id v2so1734078qcr.19
        for <git@vger.kernel.org>; Thu, 14 Nov 2013 17:47:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        bh=tOq7KOsLrVJWr8/Dc6tv1fOge5TcOm06Q/+z42mdcOg=;
        b=A2dHqOy/rI4V/bzo/p0WblS3xBlOA7QJxtHUjranbxAoxYb94jsuPWwNBNr6D+Xr2P
         focd0PAo99d4jwnYLm7gMAuZXdVZWG1tYa8PxDabphfTz4ao/FgL0cZ16JVy9hCP8Tg1
         wJmzlec5rmMTI5vzwl1bflgAlG/UlRj0y9xuao9fRzD5lAbhtM+Q4wqhgp07h9RTuuCr
         EM3DMSn2HmGdheFYKrWffhIm8SwpeDTjMDWUbDeuSl1b94PbCdEkWZ+brgxTC+wAzCM3
         +T6+53cXlY5+j+ag128/MOveDXLG7OHws/bMkvLHqnsAwSoeySgH3k597BH2E7Tl9ztr
         Ii1g==
X-Received: by 10.224.54.129 with SMTP id q1mr6961615qag.19.1384480068093;
 Thu, 14 Nov 2013 17:47:48 -0800 (PST)
Received: by 10.224.127.131 with HTTP; Thu, 14 Nov 2013 17:47:27 -0800 (PST)
In-Reply-To: <CAEjxke8vLtA5CgW8v4zv58kexe631koniNpdqTrr8LFYAOrMuA@mail.gmail.com>
X-PMX-Version: 6.0.2.2308539
X-PerlMx-Virus-Scanned: Yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237888>

On Thu, Nov 14, 2013 at 8:44 PM, Jason St. John <jstjohn@purdue.edu> wrote:
> On Wed, Nov 13, 2013 at 4:56 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> "Jason St. John" <jstjohn@purdue.edu> writes:
>>
>>> Documentation/git-log.txt:
>>> -- replace single quotes around options/commands with backticks
>>> -- use single quotes around references to sections
>>> -- replaced some double quotes with proper AsciiDoc quotes (e.g.
>>>      ``foo'')
>>> -- use backticks around files and file paths
>>> -- use title case when referring to section headings
>>> -- use backticks around option arguments/defaults
>>>
>>> Signed-off-by: Jason St. John <jstjohn@purdue.edu>
>>> ---
>>> When working on this commit, I noticed a difference in how options and
>>> option descriptions are separated (e.g. with a blank line or not). At least
>>> with Vim's syntax highlighting, if there is a blank line between the option
>>> and its description, the text block is all colored the same; however, if
>>> there isn't a blank line, then the text block is not specially colored.
>>>
>>> Is there an existing convention for how this should be done?
>>
>> I do not think we have a written rule or convention (and I do not
>> know if we want one).  While reading the text in the source form
>> (and the point of choosing AsciiDoc was to be able to read the docs
>> without formatting), I personally have a slight preference to
>> immediately follow the body text to the label in the labelled list,
>> and a blank line after the item, i.e.
>>
>>         item label::
>>                 This describes the item.
>>
>>         next item label::
>>                 This describes the next item.
>>
>> as it makes it clear that the body belongs to the heading that
>> precedes it.
>>
>> But it does help to have a blank between the label and the beginning
>> of the body when reflowing the body with fill-paragraph, i.e.
>>
>>         item label::
>>
>>                 This describes the item.
>>
>> You say that it is also easier on Vim to have the blank line there,
>> so perhaps we may want to aim for updating the documentation over
>> time to consistently do so.  I dunno.
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> As I stated in my recent resubmit[1], I decided to remove the blank
> lines after option subheadings because the syntax highlighting in Vim
> actually looks better with the blank lines removed. As such, I would
> prefer that we go with the option of removing these blank lines going
> forward.
>
> If we are in agreement on this, should I send in a patch for
> CodingGuidelines to state this?
>
> [1] http://marc.info/?l=git&m=138447927208462&w=2

I forgot to mention that if we do go with this, then I will need to
resubmit this patch.

Sorry for the extra email.
