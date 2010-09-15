From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: How we should translate Git
Date: Wed, 15 Sep 2010 20:09:38 +0000
Message-ID: <AANLkTinJSzP+3xNLHJisqKzg2LHFaSuaRWxgdFrFp17R@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christian Stimming <stimming@tuhh.de>, jk@jk.gs,
	git <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Sep 15 22:09:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OvyId-0000dv-JC
	for gcvg-git-2@lo.gmane.org; Wed, 15 Sep 2010 22:09:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754164Ab0IOUJk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Sep 2010 16:09:40 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:59858 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754119Ab0IOUJj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Sep 2010 16:09:39 -0400
Received: by iwn5 with SMTP id 5so365657iwn.19
        for <git@vger.kernel.org>; Wed, 15 Sep 2010 13:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        bh=lDH3k/IcPERF7XqiaYmA/aFAAjmaDbjlimsh4yUnbOo=;
        b=ksufzYXrHcmGo/QRgZzNwlR0B0BNX4wIBcQ2n4Pmc+KvrJTIos2ACzNGDMYzI+TtdZ
         WKlpdmU5znZ4vsOv8hkmguxzaUd9S3BjHRpe2YG/YZDK3sbINlADoe2hrhBWMfwbylTP
         9ov8UFTeZ5KFwQHFFwAnyEYPU2dTAiAYKc37U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=I2TgcDt/53NAgg1tirByY0PN1atPbFr+5wQzjA3y6FjWGnnCx77gMLiow1hdmMkg0E
         /cWOyXwN/hXDPnbU8yWlo7Nzdv9A/TDU7GB3DzIgNHKMbccarmKB0WtoiQMbth7VV0l1
         u0nXt3toHVFqeBSMYR+ZqF89ZZK0ljHvCLnWs=
Received: by 10.231.183.67 with SMTP id cf3mr2018563ibb.187.1284581379272;
 Wed, 15 Sep 2010 13:09:39 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Wed, 15 Sep 2010 13:09:38 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156245>

On Wed, Sep 15, 2010 at 09:47, Thomas Rast <trast@student.ethz.ch> wrot=
e:
> There are German terms for all the untranslated ones, but I rarely
> hear them in practical usage. =C2=A0Books probably go for a full
> translation since they want to be normative (how should I know, it's
> been a while since I used a German book), but lectures stick to the
> half-translated version.
>
> And much like the average computer scientist around here uses a numbe=
r
> of English terms even in German informal speech, I suspect the averag=
e
> German user of git would not translate *every* term. =C2=A0Unless you=
 are
> aiming for a normative usage, in which case we would also have to
> translate the theory (manpages, books) using the same terms...
>
> I'll leave it at that for my $0.02, since as you note, I'm not
> actually the intended audience.

I'm forking this off from the German thread since I wanted to make a
more general point about how we translate Git in general.

=46irstly, not to step on anyone's toes. I think that final say on how
to translate Git has to be left to each language community, some
languages (like German) simply use more loan words. While others (like
Icelandic) prefer to translate pretty much anything as a matter of
course.

But here's something to keep in mind:

Unlike the German article on version control we're going to be the
primary and definite source for Git translations, and given Git's
popularity probably the definite source for all DVCS translations for
a given language.

While translating some things might look awkward now words are usually
awkward because you aren't familiar with them.

The translations we come up with are going to be used for a long time,
DVCS is a relatively new field, and if we do a good job people using
Git (or other derived systems) in the year 2050 might be using some of
the terms we come up with, and they'll sound natural to them because
they're used to them.

More and more people from all walks of life are using computers, word
processing used to be a relatively advanced thing 20 years ago, now
everyone does it.

Similarly, everyone might be using a DVCS 30 years from now. Small
children might be "forking" and "branching" on their tablet computers
as they collaborate on some school project.

People like that will benefit from a more exhaustive translation into
their native language, and even people that are bilingual will benefit
from a good translation.

I find it very easy to think in either English or Icelandic, but I
struggle when I have to do both at the same time. I'd guess that
people who explicitly turn on translations on their computer usually
want a more complete one than not.
