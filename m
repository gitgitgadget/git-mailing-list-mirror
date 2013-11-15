From: "Jason St. John" <jstjohn@purdue.edu>
Subject: Re: [PATCH 2/2] Fix minor grammatical and other formatting issues in
 the "git log" man page
Date: Thu, 14 Nov 2013 20:44:22 -0500
Message-ID: <CAEjxke8vLtA5CgW8v4zv58kexe631koniNpdqTrr8LFYAOrMuA@mail.gmail.com>
References: <1384323709-2690-1-git-send-email-jstjohn@purdue.edu>
 <1384323709-2690-2-git-send-email-jstjohn@purdue.edu> <xmqqy54sc6ev.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 15 02:44:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vh8Sp-0001i5-HD
	for gcvg-git-2@plane.gmane.org; Fri, 15 Nov 2013 02:44:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755148Ab3KOBop (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Nov 2013 20:44:45 -0500
Received: from mailhub249.itcs.purdue.edu ([128.210.5.249]:52631 "EHLO
	mailhub249.itcs.purdue.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754742Ab3KOBoo (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Nov 2013 20:44:44 -0500
Received: from mail-qc0-f176.google.com (mail-qc0-f176.google.com [209.85.216.176])
	(authenticated bits=0)
	by mailhub249.itcs.purdue.edu (8.14.4/8.14.4/mta-auth.smtp.purdue.edu) with ESMTP id rAF1igED024057
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <git@vger.kernel.org>; Thu, 14 Nov 2013 20:44:43 -0500
Received: by mail-qc0-f176.google.com with SMTP id s19so1733554qcw.21
        for <git@vger.kernel.org>; Thu, 14 Nov 2013 17:44:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        bh=sPykj4zWL7e/Czjw9ymrJkcFsRXX6nW0oNp7r2yOTEQ=;
        b=HQ2JTVKzua/4NF/DxYa/+/F38u8/Dxw4bziR29ub1yNIrs22UFQzGMi4VIMywRUulW
         0w04pQcCxUd8emT3BQOO8ymb/Wxr80rcwqP/u6yMVn5Sn7mMzH1vsfabKPeD0XODPl5m
         Upin5Y+AAptYmqH5nDd8ceIdd57P5y2XzccO90fzUVxkshtn3DvsXP3H1O10Hfg3Eiyj
         gK/DK9y3oYcW0SPlmw2702D8ffxyzvhWBSceX+SFmm2Z1mOUbPiOcH2Jgr1hLSdFbISH
         62od2IjMc6mtJjGwsXfX7BDuJVA64IdWn19EEDLrCmDNtrdIrmx9MMga9RqY6e0zUwY6
         k1Zg==
X-Received: by 10.49.1.230 with SMTP id 6mr7056194qep.48.1384479882854; Thu,
 14 Nov 2013 17:44:42 -0800 (PST)
Received: by 10.224.127.131 with HTTP; Thu, 14 Nov 2013 17:44:22 -0800 (PST)
In-Reply-To: <xmqqy54sc6ev.fsf@gitster.dls.corp.google.com>
X-PMX-Version: 6.0.2.2308539
X-PerlMx-Virus-Scanned: Yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237886>

On Wed, Nov 13, 2013 at 4:56 PM, Junio C Hamano <gitster@pobox.com> wrote:
> "Jason St. John" <jstjohn@purdue.edu> writes:
>
>> Documentation/git-log.txt:
>> -- replace single quotes around options/commands with backticks
>> -- use single quotes around references to sections
>> -- replaced some double quotes with proper AsciiDoc quotes (e.g.
>>      ``foo'')
>> -- use backticks around files and file paths
>> -- use title case when referring to section headings
>> -- use backticks around option arguments/defaults
>>
>> Signed-off-by: Jason St. John <jstjohn@purdue.edu>
>> ---
>> When working on this commit, I noticed a difference in how options and
>> option descriptions are separated (e.g. with a blank line or not). At least
>> with Vim's syntax highlighting, if there is a blank line between the option
>> and its description, the text block is all colored the same; however, if
>> there isn't a blank line, then the text block is not specially colored.
>>
>> Is there an existing convention for how this should be done?
>
> I do not think we have a written rule or convention (and I do not
> know if we want one).  While reading the text in the source form
> (and the point of choosing AsciiDoc was to be able to read the docs
> without formatting), I personally have a slight preference to
> immediately follow the body text to the label in the labelled list,
> and a blank line after the item, i.e.
>
>         item label::
>                 This describes the item.
>
>         next item label::
>                 This describes the next item.
>
> as it makes it clear that the body belongs to the heading that
> precedes it.
>
> But it does help to have a blank between the label and the beginning
> of the body when reflowing the body with fill-paragraph, i.e.
>
>         item label::
>
>                 This describes the item.
>
> You say that it is also easier on Vim to have the blank line there,
> so perhaps we may want to aim for updating the documentation over
> time to consistently do so.  I dunno.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

As I stated in my recent resubmit[1], I decided to remove the blank
lines after option subheadings because the syntax highlighting in Vim
actually looks better with the blank lines removed. As such, I would
prefer that we go with the option of removing these blank lines going
forward.

If we are in agreement on this, should I send in a patch for
CodingGuidelines to state this?

[1] http://marc.info/?l=git&m=138447927208462&w=2
