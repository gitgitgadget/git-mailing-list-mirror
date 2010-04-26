From: Will Palmer <wmpalmer@gmail.com>
Subject: Re: [PATCH v2 2/3] pretty: make %H/%h dependent on --abbrev[-commit]
Date: Mon, 26 Apr 2010 11:13:42 +0100
Message-ID: <p2w5b9751661004260313kd1b809earb8d9fd8c4d09adef@mail.gmail.com>
References: <1272232579-18895-1-git-send-email-wmpalmer@gmail.com> 
	<1272232579-18895-2-git-send-email-wmpalmer@gmail.com> <1272232579-18895-3-git-send-email-wmpalmer@gmail.com> 
	<20100426031012.GA29953@progeny.tock> <u2i5b9751661004260047n168ad87bx6083fc201bfb21d9@mail.gmail.com> 
	<20100426095206.GA31483@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
	Thomas Rast <trast@student.ethz.ch>,
	=?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 26 12:14:22 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6LKU-0006Yh-J4
	for gcvg-git-2@lo.gmane.org; Mon, 26 Apr 2010 12:14:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754056Ab0DZKOH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Apr 2010 06:14:07 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:47731 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751396Ab0DZKOE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Apr 2010 06:14:04 -0400
Received: by bwz19 with SMTP id 19so21967bwz.21
        for <git@vger.kernel.org>; Mon, 26 Apr 2010 03:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=YdblASCP6+Syq/V6zvWg2E2i7xK+AGw+txWUIJXt84U=;
        b=mIXSmZ68UvopZpEHIZvJqD/o6vrafqoNKqDiJPjzHaFWc8Cfd0JzRDc4Ys3786gB+I
         t6ctgX8jN2KnSQ/XtbICsw8c6F54h1pkywsUHfXlUPHaVLIlKBoFGWDRiedxEiKCiJR/
         hYLQ1Sx0kC/cxa847yFd7LoYB/MQIB6LZF8rI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=qfBvh1olAQB3mNWp9+jb+yeVOHK/wLCzU9uQ7rRGwDQxoWx+PrZ+aKDvdXwLwUeRRW
         +K6jiBEq6nXqjvOPP+GkFB+xPep0s5qEhPaxWYF9zhyL1+Uw0FSH4S667OfjeKiZbxNL
         FET7uIcqtcz/+G3FjmGUkZsuSdccXzguhBXJE=
Received: by 10.103.86.32 with SMTP id o32mr2102968mul.99.1272276842221; Mon, 
	26 Apr 2010 03:14:02 -0700 (PDT)
Received: by 10.103.239.12 with HTTP; Mon, 26 Apr 2010 03:13:42 -0700 (PDT)
In-Reply-To: <20100426095206.GA31483@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145807>

On Mon, Apr 26, 2010 at 10:53 AM, Jonathan Nieder <jrnieder@gmail.com> =
wrote:
> Will Palmer wrote:
>> Jonathan Nieder wrote:
>
>>> Shortlog doesn=92t print commit hashes, does it?
>>
>> Shortlog accepts --format, though this doesn't seem to be documented
>> (if I type "man" and search
>> for "format"), so perhaps it should be.
>
> Oh, neat! =A0Maybe this would save you the trouble.
>
> Jonathan Nieder (3):
> =A0t4201 (shortlog): guard setup with test_expect_success
> =A0t4201 (shortlog): Test output format with multiple authors
> =A0shortlog: Document and test --format option

Thanks!

I wasn't sure if you intended this to be submitted as a separate
series or added on top of my series,
as my mail client grouped them together (I really need to stop using
gmail for the mailing list...). If the latter,
I'd appreciate it being sent in as a separate series, as I'd consider
the shortlog documentation/testing to be a
separate topic. (Though I suppose I should add tests for shortlog to
the tests I wrote)
