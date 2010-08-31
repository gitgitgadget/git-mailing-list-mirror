From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH/RFC 00/17] Begin gettextizing Git
Date: Tue, 31 Aug 2010 14:42:04 -0500
Message-ID: <20100831194204.GW2315@burratino>
References: <1283203703-26923-1-git-send-email-avarab@gmail.com>
 <7v39tveq0j.fsf@alter.siamese.dyndns.org>
 <AANLkTinKgOdgTpORf-NSJ1wpURw9xOkQ3rXZvmV6XtBb@mail.gmail.com>
 <20100831180832.GQ2315@burratino>
 <AANLkTikk8nVyvp0hTycMY9bjMub38msxrOHMMLNER_DS@mail.gmail.com>
 <20100831192247.GU2315@burratino>
 <AANLkTinVFvv2J4z36zc9LAs+_-Pp2_+bYeLVxVeavWtJ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Marcin Cieslak <saper@saper.info>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 31 21:43:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqWkP-0003Dj-6s
	for gcvg-git-2@lo.gmane.org; Tue, 31 Aug 2010 21:43:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755326Ab0HaTnv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 Aug 2010 15:43:51 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:53106 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752351Ab0HaTnu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Aug 2010 15:43:50 -0400
Received: by qwh6 with SMTP id 6so5543201qwh.19
        for <git@vger.kernel.org>; Tue, 31 Aug 2010 12:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=0OUNc37DJmYFWLs+oJRbZuTQFwLZ5sqVvW6LT0yw9Bk=;
        b=jsblCk/ZsJhaY/KBbUyrC9FU4W05Mvv0wcrwi8t9OQjQSVyQ4pCc3UTAarkl4rKUJo
         RMAmUtfUYYIyyRuFr1kn2WLOE2dbfrO1OVlx2oUKe1GI7tQal6tSjnvQ3jAA8B4stVmW
         /IGi5PopkQinGZDHfdydh6y6ZHSamUbzMm1WE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=r3Z+xj06ZMN+UdccWGBWIohk61AqMWvu9A8/uArZInvxoVGdv5YE2hbiRd3LbBA6xN
         c9N/oRe/6jP9SPfeo0CClln6zCH7iV6iNLMlQSnYPxr4lDdgUKN7KUe0loBbBxNK/a0x
         kuzqa7+xyIa55dAB1cFq8bNqAyRui4vbkEtRc=
Received: by 10.224.11.6 with SMTP id r6mr4320010qar.210.1283283829131;
        Tue, 31 Aug 2010 12:43:49 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id f15sm10082016qcr.13.2010.08.31.12.43.47
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 31 Aug 2010 12:43:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTinVFvv2J4z36zc9LAs+_-Pp2_+bYeLVxVeavWtJ@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154977>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Tue, Aug 31, 2010 at 19:22, Jonathan Nieder <jrnieder@gmail.com> w=
rote:

>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if test -f po/git.pot &&
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0remove_creati=
on_date <po/git.pot >po/git.1po+ &&
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0remove_creati=
on_date <po/git.po >po/git.2po+ &&
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cmp po/git.1p=
o+ po/git.2po+; \
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0then \
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rm -f po/git.=
1po+ po/git.2po+ po/git.po; \
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0else \
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rm -f po/git.=
1po+ po/git.2po+ po/git.pot; \
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mv po/git.po =
po/git.pot; \
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0fi
[...]
> I don't know what they usually do. But that looks like a lot of work
> to work around a very rare potential edge case.

Ah, to work around the interrupted build case is simpler.  grepping for
"mv" in Documentation/Makefile would show some examples.

The above incantation is to avoid changing the timestamp on the .pot
file when it does not change.

> "make pot" is only
> ever run manually by a translator right before msgmerge.

I don't know enough about translation workflows.  Don't people
sometimes automatically run msgmerge at build time to get some okay
fuzzy messages when the translation team is off on vacation?

> Thanks for checking it out.

Thanks for doing the hard work.
