From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [PATCH v2 4/5] Make boundary characters for --color-words configurable
Date: Sat, 10 May 2008 17:02:56 +0800
Message-ID: <46dff0320805100202j54b0922cy50a2c93c4eff1757@mail.gmail.com>
References: <46dff0320805040935n22354e1bta85b3f3fe7c16cad@mail.gmail.com>
	 <46dff0320805041840g1b9362d3u138b9d40cde160f2@mail.gmail.com>
	 <7vprs1ny5e.fsf@gitster.siamese.dyndns.org>
	 <46dff0320805050510t3bc5fd0eq44e0d58d1bb57629@mail.gmail.com>
	 <46dff0320805051740o65eee07eqc7073e4fa7996277@mail.gmail.com>
	 <alpine.DEB.1.00.0805060954470.30431@racer>
	 <46dff0320805061815k6aca9020g285b09da2bcf29c3@mail.gmail.com>
	 <alpine.DEB.1.00.0805071223450.30431@racer>
	 <7viqxqc4gs.fsf@gitster.siamese.dyndns.org>
	 <20080508103436.GB3300@mithlond.arda.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Teemu Likonen" <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Sat May 10 11:04:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jul00-0000pA-Et
	for gcvg-git-2@gmane.org; Sat, 10 May 2008 11:04:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751417AbYEJJC7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 May 2008 05:02:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751400AbYEJJC7
	(ORCPT <rfc822;git-outgoing>); Sat, 10 May 2008 05:02:59 -0400
Received: from an-out-0708.google.com ([209.85.132.241]:15219 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751158AbYEJJC6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 May 2008 05:02:58 -0400
Received: by an-out-0708.google.com with SMTP id d40so330036and.103
        for <git@vger.kernel.org>; Sat, 10 May 2008 02:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=IkybqsvNW6xc0YVz/GbRTLDjA2EOpms1PkJnoBTmLtA=;
        b=ikeLKMO/TtteVc3LpGrS3GVflEzlG84IFQFR86OIqb2fEUF7binTvRgIkvQ+VLkG4EoYbZKvMHmYisBGeXa73cPLpPo6qKgT5VSbUKRB6v11qGyCeTclfFF7cYs/+Hn6rlaCWe2Rh/U3w933yz0Yrk5FD1JbC/iaF1YiQTmhWNE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=C7fRUoTy0PHLs/b2Tn2dzl+xkRUsYq/W0fZdJSgzB6qYh2pSZ4DNwo7hi93/BrDRYv6INiiLoPSWDdEhoDDu90W6g9GR2noxoQter9IC1uEGuvMWdH2RWEJTjMOV0VFMCxHWklY0aTncXBxoOw4ldWpp35hXndlycTWyys6Hddo=
Received: by 10.100.120.15 with SMTP id s15mr6792145anc.46.1210410176882;
        Sat, 10 May 2008 02:02:56 -0700 (PDT)
Received: by 10.100.32.10 with HTTP; Sat, 10 May 2008 02:02:56 -0700 (PDT)
In-Reply-To: <20080508103436.GB3300@mithlond.arda.local>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81657>

On Thu, May 8, 2008 at 6:34 PM, Teemu Likonen <tlikonen@iki.fi> wrote:
> Junio C Hamano wrote (2008-05-07 12:13 -0700):
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>
>> > I am rather interested in the semantics, i.e. if you can punch holes
>> > into this 3-class approach.
>>
>> This is not the 3-class thing, but was done as a lunchtime hack.  It
>> removes more lines than it adds, with real comments ;-).
>
> I tested your lunchtime hack from the "pu" branch. I'm perfectly happy
> with the colored output itself but I noticed some different line feed
> behaviour that you might want to know. Look at the example below. The
> first is normal line diff. The second is the same text with the old
> --color-words behaviour and the last is with the lunchtime hack version.
> There are only three words added to the text; additions are written as
> {+word} in the --color-words output.

You not only added the three words, but also wrap line at different position.

> Normal line diff
> ----------------
>
> -OpenOffice.org has user setting for defining the minimum length for
> +OpenOffice.org has a user setting for defining the minimum length for
>  words to be hyphenated. By default the word length is counted from the
> -whole word - even for compound words. For example the word
> -'elokuvalippu' is 12 characters long. The word will be hyphenated like
> -'elo-ku-va-lip-pu' in all cases when the minimum word length is set to
> -12 or less. If the minimum length is set to 13 or more the word is not
> -hyphenated at all.
> +whole word - even for compound words. For example the compound word
> +'elokuvalippu' is considered 12 characters long. The word will be
> +hyphenated like 'elo-ku-va-lip-pu' in all cases when the minimum word
> +length is set to 12 or less. If the minimum length is set to 13 or more
> +the word is not hyphenated at all.
>
> With the old --color-words
> --------------------------
>
> OpenOffice.org has {+a }user setting for defining the minimum length for
> words to be hyphenated. By default the word length is counted from the
> whole word - even for compound words. For example the {+compound }word
> 'elokuvalippu' is {+considered }12 characters long. The word will be
> hyphenated like 'elo-ku-va-lip-pu' in all cases when the minimum word
> length is set to 12 or less. If the minimum length is set to 13 or more
> the word is not hyphenated at all.
>
> With the lunchtime hack --color-words
> -------------------------------------
>
> OpenOffice.org has {+a }user setting for defining the minimum length for
> words to be hyphenated. By default the word length is counted from the
> whole word - even for compound words. For example the {+compound }word
> 'elokuvalippu' is {+considered }12 characters long. The word will be
> hyphenated like
>  'elo-ku-va-lip-pu' in all cases when the minimum word
> length is set to
>  12 or less. If the minimum length is set to 13 or more
> the word is not
>  hyphenated at all.
>

With junio's following code, the number of LF can be more than any of
the original two input. Because it will output a LF whenever we
encounter a real LF in the original input. So  some LFs are outputed
as {-LF}  or {+LF} . We can't differentiate them because we can't see
the colored output for added or removed LF. The same case is that we
can't differentiate added and removed spaces.

That's why i proposed colored background for added/removed space
characters in former reply of this thread.

+       if (line[1] == ' ') {
+               /* A token */
+               line += 2;
+               len -= 3; /* drop the trailing LF */
+       } else {
+               /* A real LF */
+               line++;
+               len--;
       }
+       emit_line(diff_words->file, set, reset, line, len);



-- 
Ping Yin
