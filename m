From: Elijah Newren <newren@gmail.com>
Subject: Re: Avery Pennarun's git-subtree?
Date: Thu, 22 Jul 2010 14:43:08 -0600
Message-ID: <AANLkTikUqbAGPXcAmGsx_oML0tZHpMWHOFl7CCkjBca0@mail.gmail.com>
References: <4C472B48.8050101@gmail.com>
	<AANLkTilivtS4TccZXHz2N_n_2RpY6q_5sw7zwdWKdnYE@mail.gmail.com>
	<AANLkTinl1SB1x1bEObLIo-LWjvxM-Yf1PfdUp4DNJda3@mail.gmail.com>
	<AANLkTikl2zKcie3YGhBHrGbYbX3yB9QCtuJTKjsAfK07@mail.gmail.com>
	<AANLkTimiROxqf7KcRKTZvMvsFdd4w3jK_GLeZR8n7tdA@mail.gmail.com>
	<4C4778DE.9090905@web.de>
	<AANLkTim9nfRGjhpn2Mj-1GntLsDX7xeyL2pegB84aZX8@mail.gmail.com>
	<m31vavn8la.fsf@localhost.localdomain>
	<AANLkTimOb2VjYI21wQsC64lm4HsVPwpRWd1twIUBnbJ3@mail.gmail.com>
	<20100722195653.GC4439@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Bryan Larsen <bryan.larsen@gmail.com>,
	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 22 22:43:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oc2bs-0006bp-54
	for gcvg-git-2@lo.gmane.org; Thu, 22 Jul 2010 22:43:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756698Ab0GVUnM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Jul 2010 16:43:12 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:35662 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752352Ab0GVUnK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Jul 2010 16:43:10 -0400
Received: by vws3 with SMTP id 3so586755vws.19
        for <git@vger.kernel.org>; Thu, 22 Jul 2010 13:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=pmwqlw85m0/3Af9sKfALAv05wjampel8/IskgVYbgiY=;
        b=qJ45NTQn1EV2BRziMKvwX+ZUoojHKrOx35zQDlyHA3T0+mGR42JnIqihO0W4KfNGng
         Pio4XnJbAgQJ3aj+VRlwJN6+GLzp0aDBRwXDPc7OG9S6JCvjjGbmPE7kMyNlUn+Y50xK
         1eFZgd/hTV3IAY5SBKgpya5qeGqesgfxva2e0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=pIVggOSabc9np2YEj1AYC4F5COxjO+eAtiMQVvH1I7LQhupZNCprotuimDhqB+nIiT
         yo9mtjO0XrdRqL7C4Ijwz5MzySIpoyocRGgGaAHmrsNKg9seqeROYiLznvi72br2kxYw
         WMNZE8gMr6ZbWUmlME6QldeYapwl1LqWl/020=
Received: by 10.220.124.153 with SMTP id u25mr1056901vcr.66.1279831388431; 
	Thu, 22 Jul 2010 13:43:08 -0700 (PDT)
Received: by 10.220.99.211 with HTTP; Thu, 22 Jul 2010 13:43:08 -0700 (PDT)
In-Reply-To: <20100722195653.GC4439@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151482>

Hi,

On Thu, Jul 22, 2010 at 1:56 PM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Avery Pennarun wrote:
>
>> Unfortunately everything built *on top of* Linus's file format
>> contribution has turned out to be a disaster.
>
> Aside: this kind of statement might make it unlikely for exactly
> those who would benefit most from your opinions to read them.
>
> Well, that is my guess, anyway. =C2=A0I know that I have not found th=
e time
> to read your email (though I would like to) because I suspect based o=
n
> such sweeping statements that it would take a while to separate the
> useful part from the rest.

I'd usually agree with such a sentiment, but I don't think it's
accurate in this case.  Having read Avery's emails in this thread, I
think he does a really good job explaining why submodules don't (and
won't) work for a lot of people.  I think he provided a better
explanation than I could have for why I've never had much luck with
submodules (and further convinced me that not only do they not work
for me now, but they aren't ever going to fulfill the usecases I had).

I can't really add much other than that we've been relatively happy
with git-subtree and would like to see it or something like it merged.
 Our problems with it so far have turned out to be issues in other
areas of git (e.g. the known issue about --prefix being ignored with
the code being merged under a different directory due to
rename-detection, and the bugs in merge-recursive's handling of D/F
changes).


Elijah
