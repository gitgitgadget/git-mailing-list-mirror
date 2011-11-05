From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [git patches] libata updates, GPG signed (but see admin notes)
Date: Sat, 5 Nov 2011 09:41:25 -0700
Message-ID: <CA+55aFy0gA0ROSyE03h6Lw0zn4B4j-oEFBmffOcWs6NfyYy8JA@mail.gmail.com>
References: <20111026202235.GA20928@havoc.gtf.org> <1319969101.5215.20.camel@dabdike>
 <CA+55aFx1NGWfNJAKDTvZfsHDDKiEtS4t4RydSgHurBeyGPyhXg@mail.gmail.com>
 <1320049150.8283.19.camel@dabdike> <CA+55aFz3=cbciRfTYodNhdEetXYxTARGTfpP9GL9RZK222XmKQ@mail.gmail.com>
 <7vy5w1ow90.fsf@alter.siamese.dyndns.org> <CA+55aFwL_s=DcT46dprcYVWEAm_=WkuTV6K9dAn3wc_bDQU8vA@mail.gmail.com>
 <7vwrbjlj5r.fsf@alter.siamese.dyndns.org> <CA+55aFx_rAA6TJkZn1Zvu6u9UjxnmTVt0HpMnvaE_q9Sx-jzPg@mail.gmail.com>
 <7vk47jld5s.fsf@alter.siamese.dyndns.org> <CA+55aFz7TeQQH3D4Tpp31cZYZoQKeK37jouo+2Kh61Wa07knfw@mail.gmail.com>
 <CAJo=hJv5nAKH_ptYSWfMvFQv0Dj+naPXK35wSzKYkfPOYsWkxg@mail.gmail.com>
 <CA+55aFx0oCd6-sh0psYxho-s=sHAK0RHXJHfLewRuUcdXzxZbg@mail.gmail.com>
 <CA+55aFwXu=+HdQ5nW11Ts5p-V=KgpxjyagKqB+Xv+qBOEEWXvQ@mail.gmail.com>
 <7v62j1gitn.fsf@alter.siamese.dyndns.org> <7vvcr1f38j.fsf@alter.siamese.dyndns.org>
 <CA+55aFyRawm9CoJMiEXDFCX4YTidPOiV4oqSS2d7nNv7Ecw8BQ@mail.gmail.com> <7v1utn9it8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "Ted Ts'o" <tytso@mit.edu>, Shawn Pearce <spearce@spearce.org>,
	git@vger.kernel.org,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Jeff Garzik <jeff@garzik.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: linux-ide-owner@vger.kernel.org Sat Nov 05 17:41:52 2011
Return-path: <linux-ide-owner@vger.kernel.org>
Envelope-to: lnx-linux-ide@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-ide-owner@vger.kernel.org>)
	id 1RMjJY-0001QK-0h
	for lnx-linux-ide@lo.gmane.org; Sat, 05 Nov 2011 17:41:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753517Ab1KEQls (ORCPT <rfc822;lnx-linux-ide@m.gmane.org>);
	Sat, 5 Nov 2011 12:41:48 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:47118 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753253Ab1KEQlr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 5 Nov 2011 12:41:47 -0400
Received: by wyh15 with SMTP id 15so3227619wyh.19
        for <multiple recipients>; Sat, 05 Nov 2011 09:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=8B/WdUWxd8wXmfuOI94sq/F7sGsyfmUZBrKEGIfm2m0=;
        b=ULD3G0wkl/48iHlxfDfe6VsLLASBOr2aS25Ae1iASEBbvbvm4Phmiw7HIQjX9TS8Jr
         hSxH1YGSkOTymp7gM/rXawY9s9GaLyP4CB5CWSkLsiwzmlxAD4lSKFKDzX4nU1eoeaYY
         E5sPoKbHbLPyW/z9wI+8WatH4ihEMatJHZ82g=
Received: by 10.216.193.212 with SMTP id k62mr5486269wen.67.1320511306078;
 Sat, 05 Nov 2011 09:41:46 -0700 (PDT)
Received: by 10.216.166.3 with HTTP; Sat, 5 Nov 2011 09:41:25 -0700 (PDT)
In-Reply-To: <7v1utn9it8.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: NoPk9upjCNs8bgTtoNjIOeuIdYA
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184866>

On Fri, Nov 4, 2011 at 11:36 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> About the ugliness of the merge commit log messages, you have already
> learned to ignore them with "log --no-merges" ;-)

Absolutely not. I look at merges all the time. I never use
"--no-merges" except when I'm doing certain statistics (ie "How many
real changes do we have") or when I do release files.

But I actually think it's important that people write *good* merge
messages. I've berated some people for it when they just have

    Merge branch 'origin'

in their commit message, because I think a merge commit should say why
it happened or what it brought in.

> and the material the
> patch series I sent out adds are at the end, so "/^commit.*$" in less
> would hopefully work well enough in "log --no-merges" as well.

I agree that being at the end helps, but I do a lot of "git log
ORIG_HEAD.." etc, and I don't do a lot of "/^commit" searching.

The "/commit" thing I do tends to be because I do "git log -p" to see
patches, but at the same time am not going to read through
everything..

So I'd really like some way to not see it.

Ted suggested a NUL character in the commit message in front of the
"hidden content". What do you think?

                Linus
