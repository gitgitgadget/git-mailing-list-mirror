From: Justin Collum <jcollum@gmail.com>
Subject: Re: git status resets permissions on index file -- Ubuntu 12.04 64b
Date: Fri, 9 Aug 2013 10:00:42 -0700
Message-ID: <CACO0oR4_+=6iimO4U0rt2JuhfxrX1CkjWR5iMkt=+EuxscmBMg@mail.gmail.com>
References: <CACO0oR7a1-fUASQ+SJVbH1CU8d=NbHrK0MuMu+9Pr4_=7q85Vw@mail.gmail.com>
	<52040F27.4050908@googlemail.com>
	<20130808221807.GA8518@gmail.com>
	<C525FA0D-D22C-4C78-8C97-45819FD58DD7@gmail.com>
	<CACO0oR7tJNKWA=cynBA8R2kaGr2iKNCiCmXKLur9nub6pnBG0g@mail.gmail.com>
	<8761vf3uml.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "Kyle J. McKay" <mackyle@gmail.com>,
	Stefan Beller <stefanbeller@googlemail.com>,
	Andrew Ruder <andy@aeruder.net>, Git List <git@vger.kernel.org>
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Fri Aug 09 19:00:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7q3T-0004AF-CN
	for gcvg-git-2@plane.gmane.org; Fri, 09 Aug 2013 19:00:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968257Ab3HIRAn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Aug 2013 13:00:43 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:38901 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968243Ab3HIRAm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Aug 2013 13:00:42 -0400
Received: by mail-ie0-f170.google.com with SMTP id e14so4602669iej.15
        for <git@vger.kernel.org>; Fri, 09 Aug 2013 10:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=SBGXH2gSnLlNUxio0VrWBvpyzX1ezKo3VQro31QLNmc=;
        b=a+l7XyqKOjqivC4kyjjc6CaAQQEOgzeIjDT0VNjyNxHsmB08p671C2+bvuT8sKKDjx
         ecMk3aUlBtM8lqm2eyYlTHj0bZMrz9ObLwzV0J+fa5SSgwNYYyxYakgqw/NwahhHpQTY
         Dtwfzg96KMk+EHLlrXklhSf+Vri/h1odnAOg3KxxpF5mezwVRwCbep92ZDa3VxwnEYnX
         v92LM9Qo2mPrl9Vw8G2ZcWl47/Fu5ChXG/Mz74e31ZfIb5uK34MIvGNHm45i3TBhbiqM
         HA9R+XNAoZVVWFdVeIg6wSEbEEWThI9GIznwsTtTOFnG/Mrpmcd6d6wh4V2ycc1ZikGP
         Nv3A==
X-Received: by 10.50.109.134 with SMTP id hs6mr2724711igb.35.1376067642367;
 Fri, 09 Aug 2013 10:00:42 -0700 (PDT)
Received: by 10.43.146.70 with HTTP; Fri, 9 Aug 2013 10:00:42 -0700 (PDT)
In-Reply-To: <8761vf3uml.fsf@igel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231995>

> That doesn't make sense.  If you are the owner of the file, why do you need sudo???

I've just never seen a chmod command without sudo. I assumed it was
needed. Is this relevant to the bug that I'm seeing?

On Fri, Aug 9, 2013 at 5:40 AM, Andreas Schwab <schwab@linux-m68k.org> wrote:
> Justin Collum <jcollum@gmail.com> writes:
>
>>      sudo chmod 644 ./.git/index
>
> That doesn't make sense.  If you are the owner of the file, why do you
> need sudo???
>
> Andreas.
>
> --
> Andreas Schwab, schwab@linux-m68k.org
> GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
> "And now for something completely different."
