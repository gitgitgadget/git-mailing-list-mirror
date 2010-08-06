From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Cooking of the ab/i18n series
Date: Fri, 6 Aug 2010 19:28:19 +0000
Message-ID: <AANLkTik1KVpb25nuwSFA2z4ezRJKWdTwRrS_KXzwM+2D@mail.gmail.com>
References: <AANLkTi=bnDgUsnBCv5493sH9eY5hg0S2YPywKba9jD20@mail.gmail.com>
	<7vzkx0bt4w.fsf@alter.siamese.dyndns.org>
	<AANLkTim1G=wjAgts_BvjwU8_B1wqrUEQHWbP_MY=cJa9@mail.gmail.com>
	<7vmxszamwd.fsf@alter.siamese.dyndns.org>
	<AANLkTimooDYBW3N0qV4G2JKSvcdWiCVRj3WjuoO+CJ54@mail.gmail.com>
	<7viq3nagje.fsf@alter.siamese.dyndns.org>
	<AANLkTimJCgZ8kU0Nrm6Zi-PXSgT96bFfTi0oaaX2t-6v@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 06 21:31:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhSdJ-0001dO-HG
	for gcvg-git-2@lo.gmane.org; Fri, 06 Aug 2010 21:31:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935810Ab0HFTbG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Aug 2010 15:31:06 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:53479 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935831Ab0HFT2U convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Aug 2010 15:28:20 -0400
Received: by gxk23 with SMTP id 23so2973862gxk.19
        for <git@vger.kernel.org>; Fri, 06 Aug 2010 12:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=pWwyvhvXaHo3DkEfkfO6xPEmAYZUSb6V0Rh8vLyypnc=;
        b=W6F/4MgU+j7fSw430/2Gvcdd8wavlSlA0rIaBl6dylbZOz00ddbLhnUnQiV7VLnnmE
         k+owWRSRGliXP3WsMZI4PR+9DKsFqrN1sz56RR7qlFXVJYeziY604iXf9vMgWOJn5PyI
         polNnkY/ocDq6sAL7m95USgUa6wuY17pD5VNM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=PZz0mIofOj9D4xQgUsDzfDbIKuesOAfcUVoWKpifGuFJOt4nCuvqv/QUQ6DGX8qUIK
         AdsmrzUG0wQ7v+M9BuA6MhaykaZherGDN13Ys6koNyIJIn5IO+spLHGoIcvqdcgrVjBW
         M2ABpD+i//lI4uzhVhlc/7FsbJU/kpsXLHRaU=
Received: by 10.101.20.3 with SMTP id x3mr2001095ani.116.1281122899828; Fri, 
	06 Aug 2010 12:28:19 -0700 (PDT)
Received: by 10.231.186.226 with HTTP; Fri, 6 Aug 2010 12:28:19 -0700 (PDT)
In-Reply-To: <AANLkTimJCgZ8kU0Nrm6Zi-PXSgT96bFfTi0oaaX2t-6v@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152803>

On Fri, Aug 6, 2010 at 17:01, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <a=
varab@gmail.com> wrote:
> On Fri, Aug 6, 2010 at 15:48, Junio C Hamano <gitster@pobox.com> wrot=
e:
> [...]

I don't mean to bombard you with E-Mails, but hopefully this one is a
bit more to the point.

As I'm sure you've gathered by now I'm keen to get this into Git. I'm
also fully prepared to address any specific concerns about the series
before it gets merged.

However, and maybe I'm just dense, I can't really see some unambiguous
things about the series that I could improve from your comments. So
let's try to clear them up, shall we?

My mental plan for this series has basically been as follows:

  1. Get it to a state where it can cook in pu [You Are Here]

  2. After it's been there for a while get it to master

  3. Once it's there for a while and we're sure the new dependency /
     code doesn't harm some more obscure systems..

  4. Start submitting patches to the main porcelain $(grep
     'mainporcelain common' command-list.txt) to make the most common
     user-visible messages translatable.

  5. Recruit translators to translate the strings in #4. Send
     translations in as patches adding/altering the *.po files.

While doing #4 and #5 I planned to write some new
documentation. E.g. a quick guide for Git hackers showing how you can
add strings that are properly i18n-able. And for #5 an equivalent
thing for non-techie translators showing what the need to translate,
how to submit translations etc.

Now, your main concern is that this doesn't break plumbing output. My
plan for that was to just leave it for later. As long as I'm not
altering something in 'mainporcelain common' I'm not going to break
the plumbing.

I think I can read between the lines that you're uneasy about this
approach. But I'm not sure how else to handle it.

One thing that could perhaps help things in the long run would be to
explicitly mark plumbing messages as not for translation. E.g. with a
"commit" -> P_("commit") macro.

That'd also give us something like the Documentation/ page you
suggest, but with only the plumbing messages extracted on a per-tool
basis (using the gettext tools). That'd probably make for a useful API
reference.

To sum it up. I'm happy to amend something in the 5-point plan above,
or to write new code to make the gettext series more acceptable. I
just don't see what that something is.

In any case, thanks for all the work you and others have put into
getting the series into the state it's in today. I really appreciate it=
=2E
