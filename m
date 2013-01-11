From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: git send-email should not allow 'y' for in-reply-to
Date: Fri, 11 Jan 2013 22:53:16 +0100
Message-ID: <CALWbr2xasF1y9j3G=-fQ9Wwg41Ymv=MMsWoqyuhweDov9KpRvg@mail.gmail.com>
References: <A0DB01D693D8EF439496BC8B037A0AEF322039A7@xmb-rcd-x15.cisco.com>
	<20130111212325.GA18193@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "Matt Seitz (matseitz)" <matseitz@cisco.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 11 22:53:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TtmXl-0006n4-6p
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jan 2013 22:53:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755723Ab3AKVxT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2013 16:53:19 -0500
Received: from mail-ea0-f182.google.com ([209.85.215.182]:59810 "EHLO
	mail-ea0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755701Ab3AKVxS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2013 16:53:18 -0500
Received: by mail-ea0-f182.google.com with SMTP id d1so914844eaa.13
        for <git@vger.kernel.org>; Fri, 11 Jan 2013 13:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=CGMS5Lr+5ikmNpcLmOYksb6+p93/5js0MIvnRmwyVP4=;
        b=mqUvWl2ADgNiZ4o1SvlzG4OTk/n86Q98u2+DF4eEOpiggm4prGm/z4M+yBl2HqLdhd
         qE/6DcgUuhJh2y46U/XCkAaxy8r8c1yT+eVv/gbAjsxNSYo8XsXiUZCLTfzaIh5PPk/H
         bwJJJ9P87FDWfJT28bup3jxGvss1rDYhhZA68b6CF579K3h+3amDY/IkG77DPArk/3Z9
         l2RUbjJvfOgI4HudWCobiEeTYAIYABHQpg7mym2EYFx+wmM0YrhDjEmBVGQQnJx+KXZ0
         x09HGBGPsqBfqnn1/rIAy2Kh3G1AAn9Tvy4LiPk2TuikdLwa7YN1lr6ei/oGdzycQENU
         ja+Q==
Received: by 10.14.204.70 with SMTP id g46mr178916038eeo.15.1357941196473;
 Fri, 11 Jan 2013 13:53:16 -0800 (PST)
Received: by 10.14.187.6 with HTTP; Fri, 11 Jan 2013 13:53:16 -0800 (PST)
In-Reply-To: <20130111212325.GA18193@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213246>

On Fri, Jan 11, 2013 at 10:23 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Jan 11, 2013 at 08:13:57PM +0000, Matt Seitz (matseitz) wrote:
>
>> > > How about "What Message-ID to use as In-Reply-To for the first email?"
>> > > or "Provide the Message-ID to use as In-Reply-To for the first
>> > > email:".
>> >
>> > seem fine to me. Maybe somebody who has been confused by it can offer
>> > more. At any rate, patches welcome.
>>
>> Suggestion: "Message-ID to use as In-Reply-To for the first email:".
>>
>> Simple and unlikely to generate a "y" or "n" response.  Putting
>> "Message-ID" first makes it more obvious what data is being asked for
>> by this prompt.
>
> You'd think. But the existing message that has been causing problems is:
>
>   Message-ID to be used as In-Reply-To for the first email?
>
> which is more or less what you are proposing. I do think a colon rather
> than a question mark helps indicate that the response is not yes/no.

That is true.

I'm definitely not a wording person, but assuming people who make the
mistake probably don't read the whole sentence out of laziness (that
might be somehow extreme though ;), starting it with "what" makes it
obvious at first sight that you can't answer yes/no.
That is not true if the message starts with Message-ID .. which
doesn't look like a question. Now it feels like you have agree or not.

Antoine,
