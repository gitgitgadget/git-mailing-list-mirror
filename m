From: PJ Weisberg <pj@irregularexpressions.net>
Subject: Re: Does content provenance matter?
Date: Mon, 7 May 2012 15:14:25 -0700
Message-ID: <CAJsNXT=26u-PPNe9_LFoC1tAKpWJRWfBNNKzQB5Ya3X0n4K_eg@mail.gmail.com>
References: <878vh4flh1.fsf@thomas.inf.ethz.ch>
	<1336427003.53220.YahooMailClassic@web121504.mail.ne1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Kelly Dean <kellydeanch@yahoo.com>
X-From: git-owner@vger.kernel.org Tue May 08 00:14:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRWCM-0004eC-QO
	for gcvg-git-2@plane.gmane.org; Tue, 08 May 2012 00:14:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756818Ab2EGWO0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 May 2012 18:14:26 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:38227 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752760Ab2EGWOZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 May 2012 18:14:25 -0400
Received: by vbbff1 with SMTP id ff1so1242756vbb.19
        for <git@vger.kernel.org>; Mon, 07 May 2012 15:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=cWn3FwhE26XmuuJc1eVXLXJF65KBx7CRRAvdX88pECg=;
        b=DAeZ/238IwxHMKsoTsuLA28lCznRqli+zcvAtJnTuJnapRPh+Xzgj1rKrMA5TvS9wE
         jkDZ22yFASj2Bwf7j3haQZsZSYWVN+Td5IzsySHFivuSB/KCM1eh81dFbAUBW+WlqSDv
         eWdFtclsnDMFJ+UIaShn5tb8XMjmADB9kcvgV1+A14+apgtZSVeM5Id9nIuqVS9eSrx1
         vpHpL3XAjUBGgPtDHyypJdMahbmSiV2Y5bvI0xXsQYJ+6xu+XQ1pNQBRRkn5GvVxtHrW
         OHfrxFZS2ItusI+lJo79+zlUI2hE7lpsahpZ6qiPitOA3fawlMOzn5vYUU52fDXvQMpA
         OhIQ==
Received: by 10.52.172.194 with SMTP id be2mr2293775vdc.60.1336428865210; Mon,
 07 May 2012 15:14:25 -0700 (PDT)
Received: by 10.220.118.206 with HTTP; Mon, 7 May 2012 15:14:25 -0700 (PDT)
In-Reply-To: <1336427003.53220.YahooMailClassic@web121504.mail.ne1.yahoo.com>
X-Google-Sender-Auth: BFkAXfsxx94n7qp8cZomNE6zXeI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197320>

On Mon, May 7, 2012 at 2:43 PM, Kelly Dean <kellydeanch@yahoo.com> wrot=
e:
> --- On Mon, 5/7/12, Thomas Rast <trast@student.ethz.ch> wrote:
>> What's the difference between the following series of
>> commits?
>>
>> =A0 Foo
>> =A0 Bar
>> =A0 Revert Bar
>>
>> and
>>
>> =A0 Foo
>>
>> You claim that they're the same, because the tree state
>> after each is
>> the same. =A0But I learned that Bar was broken, and
>> recorded it for all to see.
> No, I don't claim they're the same. Different commits have different =
timestamps (and different commit messages, but that's not useful for au=
tomatic searching to find which commits are derived from which others).=
 Consider if "Revert Bar" and "Bar" didn't point to their parents; coul=
d you still deduce from them that Bar was broken? Yes--on the basis of =
the commit timestamps (which shows their temporal order) and the conten=
ts of the trees which the commits point to (which shows that Revert Bar=
 undoes a change made in Bar).

But there could be any number of unrelated commits newer than "Bar"
but older than "Revert Bar" on other branches.  Even if you could
trust the timestamps to be accurate (you can't), you still can't
determine a commit's parent unambiguously.

-PJ

Gehm's Corollary to Clark's Law: Any technology distinguishable from
magic is insufficiently advanced.
