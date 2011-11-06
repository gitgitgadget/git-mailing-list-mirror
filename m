From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [git patches] libata updates, GPG signed (but see admin notes)
Date: Sat, 5 Nov 2011 17:53:30 -0700
Message-ID: <CA+55aFzxmDC407EDcm8MV55R7BnRhuxuTOyhZ-jyg2q39=NKfw@mail.gmail.com>
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
 <CA+55aFyRawm9CoJMiEXDFCX4YTidPOiV4oqSS2d7nNv7Ecw8BQ@mail.gmail.com>
 <7v1utn9it8.fsf@alter.siamese.dyndns.org> <CA+55aFy0gA0ROSyE03h6Lw0zn4B4j-oEFBmffOcWs6NfyYy8JA@mail.gmail.com>
 <7vsjm2870k.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "Ted Ts'o" <tytso@mit.edu>, Shawn Pearce <spearce@spearce.org>,
	git@vger.kernel.org,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Jeff Garzik <jeff@garzik.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
To: Junio C Hamano <junio@pobox.com>
X-From: linux-ide-owner@vger.kernel.org Sun Nov 06 01:53:57 2011
Return-path: <linux-ide-owner@vger.kernel.org>
Envelope-to: lnx-linux-ide@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-ide-owner@vger.kernel.org>)
	id 1RMqzk-0007Zd-Pr
	for lnx-linux-ide@lo.gmane.org; Sun, 06 Nov 2011 01:53:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752693Ab1KFAxx (ORCPT <rfc822;lnx-linux-ide@m.gmane.org>);
	Sat, 5 Nov 2011 20:53:53 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:43641 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751397Ab1KFAxx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 5 Nov 2011 20:53:53 -0400
Received: by wwi36 with SMTP id 36so5136139wwi.1
        for <multiple recipients>; Sat, 05 Nov 2011 17:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=QpUBCkj42YCRDxBg88AmHSEW3j1Oumxl4b/jmoidJOk=;
        b=C3cW99JUfnQwZYr8fJCAfc3hjOq7tmPpQvumxtiqoCrpZjkOydPqpD4MnfMC3x3aCd
         KMfuZF3njDgiw7iaaWUaRfpa67NzAjZOMmgI+pgrLwSOLPTNSNkCKCYHJY3MOGcdc3G2
         1bcrXNVTiUQsKFr4tCB6RADZjSg2/PkkcCAlo=
Received: by 10.216.24.39 with SMTP id w39mr2291599wew.67.1320540831158; Sat,
 05 Nov 2011 17:53:51 -0700 (PDT)
Received: by 10.216.166.3 with HTTP; Sat, 5 Nov 2011 17:53:30 -0700 (PDT)
In-Reply-To: <7vsjm2870k.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: 0bWOITsp2s3OPz1N6EY18nyxU00
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184891>

On Sat, Nov 5, 2011 at 4:49 PM, Junio C Hamano <junio@pobox.com> wrote:
>
> You do not have to resort to NUL; we could just stuff whatever you do not
> need to see but needs to be left *intact* in the new header fields just
> like the embedded GPG signatures are stored in signed commits.

Agreed, [ details removed ] that sounds perfect. And makes it easy to
get at if you want to with just "git cat-file commit" - without ever
really being visible to people who don't care. And having it visible
in the editor with '#' means that the user who does the merge gets to
see what actually ended up being put in there, along with the fact
that yes, it verified correctly.

So I think I really like that approach - it seems to solve all problems.

               Linus
