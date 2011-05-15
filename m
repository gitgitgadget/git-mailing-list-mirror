From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 6/7] update git-stage.po
Date: Sun, 15 May 2011 08:51:09 -0500
Message-ID: <20110515135037.GB9422@elie>
References: <1305292458-3920-1-git-send-email-okano.osamu@gmail.com>
 <1305292458-3920-7-git-send-email-okano.osamu@gmail.com>
 <7vtycy7d9z.fsf@alter.siamese.dyndns.org>
 <BANLkTi=u4_vbTjDyL1JNAz06=R_1XUikvA@mail.gmail.com>
 <20110514192154.GA17271@elie>
 <BANLkTin+oceG32Xr9J+f3Kmf05P_MdDgeA@mail.gmail.com>
 <20110515130856.GB3178@elie>
 <BANLkTin3hVusWc-oubW5T-L=mCatubHiKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Osamu OKANO <okano.osamu@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 15 15:51:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLbj9-0003LI-KF
	for gcvg-git-2@lo.gmane.org; Sun, 15 May 2011 15:51:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755657Ab1EONvQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 May 2011 09:51:16 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:36414 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754052Ab1EONvP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 May 2011 09:51:15 -0400
Received: by iwn34 with SMTP id 34so3300691iwn.19
        for <git@vger.kernel.org>; Sun, 15 May 2011 06:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=QKG0F2M7GloQ2HrjUWJwSzIhSalTEg+0F7oxGyg2s/Y=;
        b=ab7RVlw/odakC6Xx4q5yFn/r3DCyHBwgFaV4WjJ8xoB8AJwpFG0aCPFn36YokEn2bq
         Zav/wAn/GJ7f6Sa1XLwtqjFXUK1/TGtQU8s9OYcHqm+B1OTSC856Cy5VstyvhVY5qMwm
         ne1DWEbusMxcntApWP6hnrVsOqQIvRuNY/3hI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=icOL4G18oKtbnBWDK9PqGgJ/JBsOnlA8Ps0PaMeTgArvDq2jUx6e0GyP1hOAZCUYiy
         J7brnhWjf8tsSFUUcPTKDdo66NuRwZQVMEbN3VfZn4lhvwnkmm7DhIYCFistqIWx4jl1
         WsrxjhiVovxNLVOaiTCVsw3c6yEjnM/c54OLk=
Received: by 10.231.74.18 with SMTP id s18mr251997ibj.135.1305467475378;
        Sun, 15 May 2011 06:51:15 -0700 (PDT)
Received: from elie (adsl-69-209-56-134.dsl.chcgil.sbcglobal.net [69.209.56.134])
        by mx.google.com with ESMTPS id u17sm1786211ibm.28.2011.05.15.06.51.13
        (version=SSLv3 cipher=OTHER);
        Sun, 15 May 2011 06:51:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <BANLkTin3hVusWc-oubW5T-L=mCatubHiKA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173637>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> We should be able to have a merge driver defined for git.git to do
> that using the "Defining a custom merge driver" facility defined in
> gitattributes(5), but I haven't actually tried to make one. But it
> looks easy enough, I'll look at doing that when this becomes a proble=
m
> I have to deal with, and I'm hoping someone beats me to it :)

Heh.  Hopefully it won't be hard to do this as a program using
libgettextpo.  For now my i18n time will be going towards playing with
the toolset you've already sent, but afterwards I'd like to try that
out.

msgmerge itself cannot perform a 3-way merge, if I understand it
correctly --- its purpose is instead to integrate new strings and
fuzzies as the document being translated changes over time, while what
I would like to do is to combine two changes to a translation without
RCS merge(1) [or rather git's ll-merge machinery] being confused by
irrelevant changes to line numbers, message order, and line wrapping.

That said, msgmerge can be helpful in almost solving the problem.

To compare old-hu.po and new-hu.po:

	msgmerge old-hu.po po/git.pot >+preimage.po
	msgmerge new-hu.po po/git.pot >+postimage.po
	git diff --no-index +preimage.po +postimage.po

To perform a 3-way merge between ancestor-hu.po, our-hu.po, and
their-hu.po:

	msgmerge ancestor-hu.po po/git.pot >+base.po
	msgmerge our-hu.po po/git.pot >+ours.po
	msgmerge their-hu.po po/git.pot >+theirs.po
	git merge-file -L ours -L base -L theirs --stdout \
		+ours.po +base.po +theirs.po >hu.po
