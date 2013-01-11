From: Hilco Wijbenga <hilco.wijbenga@gmail.com>
Subject: Re: git send-email should not allow 'y' for in-reply-to
Date: Fri, 11 Jan 2013 10:43:39 -0800
Message-ID: <CAE1pOi0zc+d6d9Y4KViX24qHgc1WL9atmRuyygorX_DQMj69Hg@mail.gmail.com>
References: <1357885869-20815-1-git-send-email-cyliu@suse.com>
 <50EFD066.60501@redhat.com> <50F0402A.1000108@redhat.com> <20130111164730.GA7921@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Blake <eblake@redhat.com>, git@vger.kernel.org,
	libvir-list@redhat.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 11 19:44:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TtjaY-0003eD-IE
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jan 2013 19:44:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755172Ab3AKSoB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2013 13:44:01 -0500
Received: from mail-vc0-f173.google.com ([209.85.220.173]:48116 "EHLO
	mail-vc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754795Ab3AKSoA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2013 13:44:00 -0500
Received: by mail-vc0-f173.google.com with SMTP id f13so1743718vcb.4
        for <git@vger.kernel.org>; Fri, 11 Jan 2013 10:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=o/wm3SyWGfHJQ79aBXJttzGrYItucruxQ1xjHGYG27Q=;
        b=nKUVeSaj+6gN1JJWWR2wg7m0gis/plEa12C69mgf6uEowg7AZFaNjNUgBUMII68ZVu
         2qeQA8H2qEUarRt7D/dCd+5Dw2gVXEUnreWZoWbRlU9dti4/7stBHi8XcLLU11dBwzeX
         gf4dULduEBJRrz/ENVs4PWP+cCF01yflKneOhuY+iKRHC435uQvmrUXLzdkLxYc0qvd/
         vJvbLSZ9KIKEZqvg4D5KO57pxgzvo+1ilCVSUO6b6Qxpi5afxhG16dj5xnwO55LXmcaV
         0jzOj6v5hpRdJSlbBqvOCBX38Hp4dfvTiuI2aZRH0J3mLgBmOuUH3rbVB6KaEzSQUO22
         VCdg==
Received: by 10.220.155.84 with SMTP id r20mr13383382vcw.19.1357929839867;
 Fri, 11 Jan 2013 10:43:59 -0800 (PST)
Received: by 10.58.189.4 with HTTP; Fri, 11 Jan 2013 10:43:39 -0800 (PST)
In-Reply-To: <20130111164730.GA7921@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213231>

On 11 January 2013 08:47, Jeff King <peff@peff.net> wrote:
> On Fri, Jan 11, 2013 at 09:39:06AM -0700, Eric Blake wrote:
>
>> > Please don't answer "y" when git send email shows the following prompt:
>> >
>> > "Message-ID to be used as In-Reply-To for the first email?"
>> >
>> > you should respond with a message ID there. Unfortunately we have a
>> > growing thread that contains submissions with this mistake.

<snip/>

>   People answer 'y' to "Who should the emails appear to be from?"  and
>   'n' to "Message-ID to be used as In-Reply-To for the first email?"
>   for some unknown reason.  While it is possible that your local
>   username really is "y" and you are sending the mail to your local
>   colleagues, it is possible, and some might even say it is likely,
>   that it is a user error.

I have never used Git's email support so this doesn't affect me one
way or another but it seems that checking the results is fixing the
symptoms, not the problem? I apologize if this was already discussed
but I couldn't find such a discussion.

I was wondering if it might be a better idea to change the wording of
the questions if they have proven so confusing? The first time (just
now) that I read "Message-ID to be used as In-Reply-To for the first
email?", it clearly seemed like a yes/no question to me. :-)

How about "What Message-ID to use as In-Reply-To for the first email?"
or "Provide the Message-ID to use as In-Reply-To for the first
email:". I'm a little surprised that "Who should the emails appear to
be from?" would be interpreted as a yes/no question but we could
rephrase that similarly as "Provide the name of the email sender:" (I
don't really like this particular version but you get the idea).
