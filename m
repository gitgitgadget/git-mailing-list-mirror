From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [1.8.0] use 'stage' term consistently
Date: Sat, 5 May 2012 19:30:41 +0200
Message-ID: <CAMP44s1isa2a=a-QLGaE9ThW1iUBj0je2NUi8FVxqA=OELLmyA@mail.gmail.com>
References: <CAMP44s1qqpTxRvjEH32MNqzUeNhgZ1gB+fu=cgvxnSbMB6oBGA@mail.gmail.com>
	<703DFCB358F74F9D87F12C22B782EA61@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Scott Chacon <schacon@gmail.com>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Matthieu Moy <matthieu.moy@imag.fr>,
	Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Sat May 05 19:30:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQioh-0007A2-O0
	for gcvg-git-2@plane.gmane.org; Sat, 05 May 2012 19:30:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757394Ab2EERan (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 May 2012 13:30:43 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:53842 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757302Ab2EERam (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 May 2012 13:30:42 -0400
Received: by wgbdr13 with SMTP id dr13so3646441wgb.1
        for <git@vger.kernel.org>; Sat, 05 May 2012 10:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=QOEum4VZewPYSAthjlDjEiQfxpxv8HSxQBjq0/cXvEo=;
        b=lFpOpgMbGtp/JOaw10oehZW+iCYgetCjgAcKgY5uPXvZgVlNBih6rXRRC+DnU6d+9j
         PPIfee/+ALgXyCqSXmX5Uz9d0bacHt5uKSak/4H4hkUNmCLndYYWkf8wxicdOKGlujAm
         K1aA4NObOBEgX1tl/ey8JT1w9J2s2gqTTL/H4wlh9GXEop4XsQDmIvz3sw0hipvPN1Y5
         zclFftQB/fROIbJgj08QrzDgKJ8orH0M2qZLnLJUXoDWF0fAXJkfzfSmOk9hAm9sBACv
         uVPUrSvRZcp0yD60/u8bC5w7WMncVfXdPJVoSQWYNTHYeJ01NVWggiqPkQtUt39fMonl
         01rg==
Received: by 10.180.107.104 with SMTP id hb8mr22290438wib.8.1336239041463;
 Sat, 05 May 2012 10:30:41 -0700 (PDT)
Received: by 10.216.124.197 with HTTP; Sat, 5 May 2012 10:30:41 -0700 (PDT)
In-Reply-To: <703DFCB358F74F9D87F12C22B782EA61@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197128>

On Sat, May 5, 2012 at 6:52 PM, Philip Oakley <philipoakley@iee.org> wrote:
> From: "Felipe Contreras" <felipe.contreras@gmail.com> Sent: Saturday, May
> 05, 2012 2:04 PM
>
>> Proposal:
>>
>> Avoid the terms 'cache' and 'index' in favor of 'stage'.
>>
>> Advantages:
>>
>> The term 'stage' is more intuitive for newcomers which are more
>> familiar with English than with git, and it seems to be a
>> straightforward mental notion for people from different mother
>> tongues.
>>
>> It is so intuitive that it is used already in a lot online
>> documentation, and the people that do teach git professionally use
>> this term.
>
>
> I've never found any of the terms to be great (as per this discussion ;-).
>
> The term that helped me most, heard on one of the git videos, was "it's like
> a manifest", alluding to a 'shipping manifest', which then leads to both the
> "staging area" and "index" terms. Though "index" is probably too technical
> for most folk.
>
> The allusion to shipping a consignment or rail marshalling (classification)
> yards, and similar frieght flows

Perhaps, but these terms are not already used everywhere, unlike
'stage', and haven't been brought in past discussions. Personally the
word 'manifest' says nothing to me (manifesto?), neither does
consignment, or marshalling. As discussed before, we need a term that
has a nice noun (stage), verb (to stage), and past-participle
(staged). There have been a lot of suggestions, but nothing as good as
'stage', which is presumably the reason why it's so prevalent in
online documentation.

Maybe you are quite familiar with ships :)

Cheers.

-- 
Felipe Contreras
