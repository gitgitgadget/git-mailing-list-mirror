From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Reviews on mailing-list
Date: Sun, 11 Nov 2012 13:14:43 +0100
Message-ID: <CAMP44s2P-nhAGgj9nuJ3cKqb6+enAthwiUNS8QTZn8MP1poJ2g@mail.gmail.com>
References: <CA+ZXwZOnZZyk_KWmLLLNChWb1R_Av1s5jM4PsLFWKaG8BB+uXQ@mail.gmail.com>
	<CAMP44s2AvaAs-dn_eoSFWoLHBQk5QrrV=zYTOpRi2nEywoua4w@mail.gmail.com>
	<CACnwZYekU0CYnqQT8L2siJbUsn=T9qowgth94TWc8KN472Ziag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?Q?Deniz_T=C3=BCrkoglu?= <deniz@spotify.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Shawn Pearce <sop@google.com>
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 11 13:14:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXWRG-00075Y-EL
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 13:14:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752542Ab2KKMOo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2012 07:14:44 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:57342 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751456Ab2KKMOo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2012 07:14:44 -0500
Received: by mail-ob0-f174.google.com with SMTP id uo13so5408665obb.19
        for <git@vger.kernel.org>; Sun, 11 Nov 2012 04:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=czgFc0hqXf1LLbkUfetDfSh99gHr71xJNQFsgJo5jJg=;
        b=wr4QjZpagRfauF1//mPmE2ihrKhkWAqkmQVQW4wnoYjwt3iALEEdJsmoWsDO22RYJ1
         ZN5a4DitELJXSN5iFC/mRe4A/t2ZajjAHvUmcbn2jcI6DTM70bLGIyauPR0RwMB6SMMA
         inaUERPvSxmkbr47XTMZi5ZCslC1Vee6KriaM4+q+M38CM2kaWCvFMOjrIvdEOqgHZfw
         gQExK+S0CFEYgnRAnGG731tE2v8eFwijKgU2xNJSVriXJNv72OLZP2VqshHYnjaVU6yV
         tqni0774Og3kakwHhk8FSBtNcwm6W/Xesmu7dsVghoYLo800ynVBvKId5WXiviSMHfK+
         Q/8w==
Received: by 10.182.52.105 with SMTP id s9mr12920669obo.25.1352636083545; Sun,
 11 Nov 2012 04:14:43 -0800 (PST)
Received: by 10.60.4.74 with HTTP; Sun, 11 Nov 2012 04:14:43 -0800 (PST)
In-Reply-To: <CACnwZYekU0CYnqQT8L2siJbUsn=T9qowgth94TWc8KN472Ziag@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209345>

On Sun, Nov 11, 2012 at 2:13 AM, Thiago Farina <tfransosi@gmail.com> wrote:
> On Sat, Nov 10, 2012 at 9:40 PM, Felipe Contreras

>> Personally I think reviews on the mailing list is far superior than
>> any other review methods. I've even blogged about it and all the
>> reasons[1]. Gerrit is better than bugzilla, but it still requires a
>> web browser, and logging in.
>>
> Requiring a web browser is a huge requirement, ham??

Yes. Today people can use any mail interface: web, console-based,
graphical. They can use Gmail clients in their phone, or IMAP, or
whatever.

Requiring everyone to use a web browser would limit the amount of ways
people can review patches. Also, not everyone has javascript enabled
in their browser (I assume Gerrit needs that).

> How come that can
> be an impediment to move forward way of this awkward way of reviewing
> patches through email?

It's not awkward, it's the most sensible way.

You just replied to my mail the same way I would reply to a patch.

> Switching to Gerrit would mean everyone would
> be using the same tool instead of anyone using its own email client
> (gmail, mutt, thunderbird, whatever...)

Yes, that's bad.

> and having to figure out git
> format-patch, git send-email (--reply-to where?).

No need to figure anything.

% git config sendemail.to git@vger.kernel.org
% git send-email @{upstream}..

Done.

> There are a lot of issues of having to use email for reviewing patches
> that I think Gerrit is a superior alternative.

There are no issues. It works for Linux, qemu, libav, ffmpeg, git, and
many other projects.

> And many people are arguing for it!

Nope, they are not.

-- 
Felipe Contreras
