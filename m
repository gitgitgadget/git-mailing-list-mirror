From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Stable ab/i18n branch
Date: Thu, 14 Oct 2010 20:44:13 +0000
Message-ID: <AANLkTim-2V_XtWVLFbWS_A-0rFNmuDvtR58aanxKL-O2@mail.gmail.com>
References: <7v39s9fkk1.fsf@alter.siamese.dyndns.org>
	<AANLkTimr73DUBBwdj9MXOQQ=O-vmyyEZpgwdHmRsGG_-@mail.gmail.com>
	<20101014200027.GA18813@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Erik Faye-Lund <kusmabite@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 14 22:44:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6Uez-0005Cu-8n
	for gcvg-git-2@lo.gmane.org; Thu, 14 Oct 2010 22:44:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756062Ab0JNUoQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Oct 2010 16:44:16 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:53797 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755925Ab0JNUoP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Oct 2010 16:44:15 -0400
Received: by fxm4 with SMTP id 4so2880785fxm.19
        for <git@vger.kernel.org>; Thu, 14 Oct 2010 13:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=cuINzdY2FjbdvCgWYzU+dAlKHdILjLb66aXbS2lMrBs=;
        b=mvV7lW5M8ZixUYYoJKErRoxWZhszJAx8hkqwtkzzQiUTC+OOKGI+TmRUshw1U0i785
         6vLSDtktAo6soY1rKgFAiOX3VosP0oAeg1af4fP6V0BxRTlbJ2JqEZYXGNxBkbcJgGwv
         /vxjxva4eS4AcVs1P9Wjahem+bkPNFrc+c+VQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Xy8bTPf63vXWqNtYqwklULoICI75S+s0KThoNLQ/+kc517sagg02BvMM/aXxP1Oglv
         NOug/UDLBkzjJ2UO0h1u9Y7t6xjaqmDCRncdjCb6dqMcRVh5nl+7rtzKJca9/+VLFAGX
         4JU3akY6YA4SMHVNlqMZmISIfgEQtXtmLAy+w=
Received: by 10.103.169.7 with SMTP id w7mr2613561muo.70.1287089054058; Thu,
 14 Oct 2010 13:44:14 -0700 (PDT)
Received: by 10.223.119.17 with HTTP; Thu, 14 Oct 2010 13:44:13 -0700 (PDT)
In-Reply-To: <20101014200027.GA18813@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159073>

On Thu, Oct 14, 2010 at 20:00, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> Could you please pick up the 160 commit version of this at:
>>
>> =C2=A0 =C2=A0 git://github.com/avar/git.git ab/i18n
>
> This is a "give an inch and they'll ask for a mile" sort of thing, bu=
t
> would it be possible to maintain a stable branch with the i18n
> infrastructure that only gets rebased when there is reorganization
> going on?
>
> The gettextization and translations are rebased for other reasons (to
> avoid going crazy), I know. =C2=A0But with the infrastructure it is s=
tarting
> to be hard to track what changes over time.

I could do that, but I've been hoping that it just gets picked up for
the `next -> master` process of git.git itself and *that* becomes the
stable target.

But I have no idea what's going on at the other end, i.e. there's no
comments about it in the "What's cooking in git.git" posts or
elsewhere. So it's hard to know whether something like this is needed.

It's been about as ready as it's ever going to get for about a month
now. The libcharset.h change that was added to it a week or so ago
could have come on top of the series. But since it hadn't been merged
anywhere I rebased and inserted that earlier in the series for the
relatively obscure case of helping bisectability on Windows.

I'm starting to get the feeling that there isn't much interest in i18n
support at all. It didn't show up highly in the wanted features in the
Git survey, and most of the translations have been contributed by
people I've poked directly.

So maybe I should just get the hint and drop it *shrug*. I don't have
much time to spend on this these days since I've been moving /
starting a new job. So if it's not going to get merged into core I
might as well do something else.

(I'm not being bitter, really. Just practical)
