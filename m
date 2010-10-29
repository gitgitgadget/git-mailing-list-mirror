From: =?utf-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>
Subject: Re: [PATCH] CodingGuidelines: Add a section on writing documentation
Date: Fri, 29 Oct 2010 13:54:23 +0200
Message-ID: <87wrp12p00.fsf@gmail.com>
References: <20101021222129.GA13262@burratino> <20101024155121.GA9503@headley>
	<AANLkTimpJbuZAPfvVOedstV7=UiLiDMnDaYWQLVNQ+Yc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Mark Lodato <lodatom@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 29 13:55:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBnYo-0005rM-1q
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 13:55:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751991Ab0J2Lzu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Oct 2010 07:55:50 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:53056 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758022Ab0J2Lzs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Oct 2010 07:55:48 -0400
Received: by bwz11 with SMTP id 11so2410554bwz.19
        for <git@vger.kernel.org>; Fri, 29 Oct 2010 04:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject
         :in-reply-to:references:user-agent:date:message-id:mime-version
         :content-type:content-transfer-encoding;
        bh=p3HpYcx4K7xq1x4TwIDQfhovRaebHkArDTSdKRO2bxc=;
        b=lQIcpj2L7tCrP3jKeDVPHOSKk76SSLSG4/fsRUBjhHd9kUQhZoa+4OKdqLA2D1JhKl
         oWBgnMNSmGPOuFcpVSe550vU6V/0cSk1kwT7fG8Sby1R/DrvL4C34G+KhR1kMmt/egbb
         Dzw4EzVJNza052dUy+jukXSvvY/Ft93IYL65s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version:content-type:content-transfer-encoding;
        b=k5PBA2GkS7S1RfzFbZklZixaFR6cHe91+RAB2T6G0HmAoEUF3fjObeQyaan/V5zOCT
         3xLBkqG9RsPWPnW8nw/Cs3uVBNCmC3MBjFWPnbS4wPtk6QMwbPeQWjt0JwWSpW6BQ5ml
         GHt2EeYdlk7BatmLsY1HADFH6IiAh9DY5c0a0=
Received: by 10.204.100.17 with SMTP id w17mr9415021bkn.43.1288353346596;
        Fri, 29 Oct 2010 04:55:46 -0700 (PDT)
Received: from localhost (176.119.broadband10.iol.cz [90.177.119.176])
        by mx.google.com with ESMTPS id p22sm780690bkp.9.2010.10.29.04.55.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 29 Oct 2010 04:55:44 -0700 (PDT)
In-Reply-To: <AANLkTimpJbuZAPfvVOedstV7=UiLiDMnDaYWQLVNQ+Yc@mail.gmail.com>
	(Mark Lodato's message of "Thu, 28 Oct 2010 22:56:14 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160330>

Mark Lodato <lodatom@gmail.com> writes:

> On Sun, Oct 24, 2010 at 11:51 AM, =C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec <s=
tepnem@gmail.com> wrote:
>> + Specific number of occurences is indicated as follows:
>> +   <commit>{0,2}
>> +   (Up to two <commit>s.)
>
> I suggest removing this notation - it is confusing and is only used b=
y
> git-diff.txt and git-difftool.txt.  We already have notation to serve
> this purpose:
>
>     [<commit> [<commit>]]

Yeah, it's kind of an oddball, although I don't really find it
confusing. I guess it might be useful in cases where you have a bigger
number of "things", say 4 or more, where the brackets could get
unwieldy.

But given that it's only used as {0,2} at the two places right now
(disregarding occurences of "0{40}" in the documentation), I agree it
might be better to get rid of it, although I don't feel strongly about
it. Any other opinions?

>> + Parentheses are used for grouping, often combined with vertical ba=
r
>> + to indicate alternatives:
>> +   [(<rev>|<range>)...]
>> +   (Any number of either <rev> or <range>.  Parens are needed to ma=
ke
>> +   it clear that "..." pertains to both <rev> and <range>.)
>
> You could also mention that parentheses are not needed if square
> brackets will do:
>     [-q | --quiet]

Good point, will do.

> Also, should there be a standard for spacing and for whether the shor=
t
> or the long option comes first?
>
> git-add.txt:
>     [--patch | -p]
> git-commit.txt:
>     [-a | --interactive]
> git-stash.txt:
>     [-q|--quiet]

I thought about this already when preparing the recent unification
series, and came to the conclusion "no, there shouldn't". :-) As the
examples you give show, the current usage is inconsistent, but given
that it brings no semantic ambiguity, I don't think it is a problem. Yo=
u
could find more similar cosmetic inconsistencies and I don't think it
makes much sense to mandate any rules for such things. (But again, I
don't feel _too_ strongly about this either, so if more people think
it's worth it, I can prepare a patch that unifies them and mention the
preference in CodingGuidelines.)

> Otherwise, I think this patch looks good.

Thank you for the feedback!

=C5=A0t=C4=9Bp=C3=A1n
