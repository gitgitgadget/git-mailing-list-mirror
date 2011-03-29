From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [PATCH 00/10] Docs: git tag
Date: Tue, 29 Mar 2011 08:59:48 -0500
Message-ID: <AANLkTi=U8amjCM7=bn2=ewJs2UpNG+D+sCKm4pPf4hP-@mail.gmail.com>
References: <1301327622-8595-1-git-send-email-mfwitten@gmail.com>
 <7v8vvzyvdi.fsf@alter.siamese.dyndns.org> <4D917B5E.1000600@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Mar 29 16:00:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4ZT9-00045C-Io
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 16:00:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752706Ab1C2OAV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Mar 2011 10:00:21 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:65495 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751866Ab1C2OAT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Mar 2011 10:00:19 -0400
Received: by iyb14 with SMTP id 14so202328iyb.19
        for <git@vger.kernel.org>; Tue, 29 Mar 2011 07:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=I+4TXRDU2YH7JKItiyPdLnpDIEpF9TMK17+lB82aYNY=;
        b=Cp5G/J23tV6k6m+uqbEPRKOPRB+nlwNGqQWRmkWTi9PwfTc5iANy0WHWeS4zD3/O5I
         pDqFYDWaHMRuZiPpS1vU8QLSc5+U6jGfAMAtMPp9lW4KD0EONjipcMMKe/IbquBrVO6E
         5VarHRYOIHcYMYvFh0ojfrhV9e2bRyqyNuZ1U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=XBXG94OusxwH8z2YrTKIpBf4CUDvnpQhGtENbkKB7S78e1NUQnCAegUwfCxFISyBdn
         Hmz7cKFbrxQhDPe84l7ed/n6WaScs1M5kVBycMiZtzn41QP/Qu17FAIbpEjV2YdKSEIW
         4iMeTWhX6j6+xAXwSETiMt23LHnIxESqmV5RM=
Received: by 10.43.49.69 with SMTP id uz5mr9225632icb.133.1301407219029; Tue,
 29 Mar 2011 07:00:19 -0700 (PDT)
Received: by 10.42.138.199 with HTTP; Tue, 29 Mar 2011 06:59:48 -0700 (PDT)
In-Reply-To: <4D917B5E.1000600@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170269>

On Tue, Mar 29, 2011 at 01:25, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Junio C Hamano venit, vidit, dixit 28.03.2011 20:04:
>> Michael Witten <mfwitten@gmail.com> writes:
>>
>>> Small patches fixing up the `git tag' docs.
>>>
>>> Michael Witten (10):
>>> =C2=A0 Docs: git tag: Add `the'
>>> =C2=A0 Docs: git tag: peoples back -> people's backs
>>> =C2=A0 Docs: git tag: Revise a paragraph.
>>> =C2=A0 Docs: git tag: other's -> the other person's
>>> =C2=A0 Docs: git tag: Streamline a sentence.
>>> =C2=A0 Docs: git tag: Add missing 'the'
>>> =C2=A0 Docs: git tag: Use 'who' again
>>> =C2=A0 Docs: git tag: Remove superfluous 'with'
>>> =C2=A0 Docs: git tag: Use semicolon
>>> =C2=A0 Docs: git tag: Rewrite discussion of GIT_COMMITTER_DATE
>>
>> Thanks; all looked sensible changes, except for 7/10 which I somehow=
 find
>> the original is more readable than the new text, partly because the
>> sentences are shorter but more importantly because the two sentences=
 make
>> two separate assertions (the first is about what "one-shot" pull mea=
ns,
>> the second is about why automatic tag following is not desired in th=
at
>> situation).
>
> Looked mostly sensible to me (and I share Junio's view on 7), too,
> although I probably would have changed "other's" simply to "others'".

I probably chose the singular variant for 2 reasons: I generally
prefer singular renditions, and the sentence is referring to an
example of a pull-request from one individual.

On Tue, Mar 29, 2011 at 01:25, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Those 10 patches could have been 1 actually, they are really divided
> into atoms (which is not bad per se) even though they all fall under
> "cosmetic language corrections and improvements" without any content
> change nor restructuring.

It's always hard to tell what delineations will be appreciated.
However, it's almost always the case that the smaller a patch is, the
more quickly it can be reviewed and approved (also, the smaller the
diff, the more meaningful the commit message), so I err on the side of
too small; after all, it's generally much easier to squash than to
split.

Of course, I would have no problem if Junio ultimately saw fit to
squash some or all of them (with a note that such squashing has
occurred).

Thanks for your input.
