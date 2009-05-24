From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH 0/2] StGit patch series import
Date: Mon, 25 May 2009 00:18:25 +0200
Message-ID: <cb7bb73a0905241518l43048416i34cb905c143c63e0@mail.gmail.com>
References: <1243149558-17160-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <7voctirzu6.fsf@alter.siamese.dyndns.org>
	 <cb7bb73a0905241443m6b5d6ba4vab438c856e47a947@mail.gmail.com>
	 <7vfxeurwh0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 25 00:19:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8M2C-0005su-8g
	for gcvg-git-2@gmane.org; Mon, 25 May 2009 00:19:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753885AbZEXWS0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 May 2009 18:18:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753573AbZEXWS0
	(ORCPT <rfc822;git-outgoing>); Sun, 24 May 2009 18:18:26 -0400
Received: from mail-bw0-f174.google.com ([209.85.218.174]:46364 "EHLO
	mail-bw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752334AbZEXWSZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 May 2009 18:18:25 -0400
Received: by bwz22 with SMTP id 22so2737947bwz.37
        for <git@vger.kernel.org>; Sun, 24 May 2009 15:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=LYBAP03JQnFvNX4kqfSpBhiIuLNEeyg1d6QpRq5rz98=;
        b=jPEmxEQbrCsKAqee8C04tze1hNCeWgSKPNJDN7IdH+yIWhgw9NQDoCP90ZR9vQ7MiR
         xpa3hlOMOpNcBLUEdhIafewlMlYqaJH1TSy5ryFnALEOkIcT1jpVvbxDTMkKuvB9spgq
         9TvVNupjbFtxX36ui1PeX4kHTbqQ87g+FeIiw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Yi8M0khJkk5YL7GXV6NGH5MDmQILSz20jJpWNUy+kI3pImeYDfomW5Dz2UJwbf9G/d
         nLuS1H6iZSVzFBV5wOoy18eU3vzkA98ELFNLJlcfiXR+pwtAQBZqDhaKZkGVSVD3mY4y
         N0IBWUAzlXskj52v1rrpLAfjZDozEb0oJOi4k=
Received: by 10.204.100.11 with SMTP id w11mr6322065bkn.32.1243203505729; Sun, 
	24 May 2009 15:18:25 -0700 (PDT)
In-Reply-To: <7vfxeurwh0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119869>

On Mon, May 25, 2009 at 12:02 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:
>
>> That was my initial thought too, but then I realized that having the
>> 'heuristics' (although a very braindead one) in mailinfo makes more
>> sense because otherwise StGIT patch autodetection would only work wh=
en
>> applying a whole series, and not when applying a single (or a few)
>> patches.
>
> The above is very selfish---what if somebody else wanted to add a fea=
ture
> to grok a non-mailbox input to the same codepath, and it is not a StG=
IT
> patch?
>
> That is what I called "bad taste".
>
> The same comment may apply to the rest of your response. =A0"This hac=
k is
> good enough for _my_ use case; I do not care if my change makes life
> harder for others to build on top of my patch" is not what I want to =
see.

Sorry, that's totally not the idea was trying to convey. In fact, just
after sending the email I went back to the code to look for a better
solution (I should have probably also made the first try a RFC).

I did feel it was necessary to explain the reasons for the simplicity
of the patches, especially since it gave me the chance to raises some
points that I thought were worth discussing, such as the matter of
where to place patch type autodetection.


--=20
Giuseppe "Oblomov" Bilotta
