From: Phil Hord <phil.hord@gmail.com>
Subject: Re: [PATCH] Documentation: replace 'vi' for 'editor' to reflect
 build-time option
Date: Sat, 31 Mar 2012 16:29:47 -0400
Message-ID: <CABURp0o06PsOWznpDh+c_YngLf74jO-qJeqmmwqRyqcU92HyYg@mail.gmail.com>
References: <20120330002543.2138.91961.reportbug@localhost6.localdomain6>
 <20120330005523.GA28519@burratino> <7v398qq1ei.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"Rodrigo Silva (MestreLion)" <linux@rodrigosilva.com>,
	git@vger.kernel.org, Ben Walton <bwalton@artsci.utoronto.ca>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 31 22:30:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SE4wA-00048L-79
	for gcvg-git-2@plane.gmane.org; Sat, 31 Mar 2012 22:30:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752095Ab2CaUaK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 31 Mar 2012 16:30:10 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:38967 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751342Ab2CaUaI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 31 Mar 2012 16:30:08 -0400
Received: by ghrr11 with SMTP id r11so834317ghr.19
        for <git@vger.kernel.org>; Sat, 31 Mar 2012 13:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=FlvH9N4JTlgAe7tSaOvI1bFE9gzGz59zIDS5O395r18=;
        b=PAttMpgLhaEFXdvsP5jzOVyS15Ql8lt6rQPSpOMcBYDzR5IurJ6835Q2o5gm82oMYL
         O0ZlAr0z0POhBcL+SFdMGZQMIIyuel4E2dgw2ExcUJ3UkbKaflGykCSYDk2W7EVik5Qo
         zK4TbUPFuSDeWon2b7IGBOrqrD/+P7LDFY72NlSYFAtTQxDEMK5b5i4Na0qsYYSjbAtP
         Qrq/+9E+2tvuZqb9bLnLoG8DrdlmMjuxjfPleO4w24Lvjng0PNi2YLBBFeU/7vMq3/5J
         8o++8f9rnFRzjSqb1hNWx6G/8du2OiyI7V8e4TsT3EWO+JSagvnr5DN/PrsD8ENMod0R
         GW5A==
Received: by 10.236.175.36 with SMTP id y24mr2524974yhl.64.1333225807760; Sat,
 31 Mar 2012 13:30:07 -0700 (PDT)
Received: by 10.146.207.6 with HTTP; Sat, 31 Mar 2012 13:29:47 -0700 (PDT)
In-Reply-To: <7v398qq1ei.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194464>

On Thu, Mar 29, 2012 at 10:16 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> Filling in the blank at compile time would be possible, but I'm not
>> convinced it's a good idea. =A0Wouldn't the same user be just as puz=
zled
>> when
>>
>> =A0 http://git.kernel.org/?p=3Dgit/git-htmldocs.git;a=3Dblob_plain;f=
=3Dgit-var.html
>>
>> (or whatever page with a nicer URL arises to replace the old
>> www.kernel.org/... =A0pages) says the fallback is 'vi' and git behav=
es
>> differently?
>
> I've already rejected this patch once, but that was primarily because=
 the
> patch was not justified with the above "I read everybody else's git u=
ses
> 'vi' on the Interweb, and even though my distro's manual page says it=
 uses
> 'nano', I didn't bother to read it." scenario.

I like this original patch, and I like being able to refer to "the"
online docs wherever I and google may happen to find them.

Because "my distro" may be a resource-constrained minimal OS which
omitted the git manual.  The same system for similar reasons may
default to 'nano' & 'more' if vi and less are unavailable.

Phil
