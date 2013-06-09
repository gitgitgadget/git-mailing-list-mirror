From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v4 10/45] sequencer: trivial fix
Date: Sun, 9 Jun 2013 12:53:38 -0500
Message-ID: <CAMP44s1F5O3vjHuL=cGys=p_dbnnE-f-Mv+j5Q1ZbyVAJCjLSA@mail.gmail.com>
References: <1370796057-25312-1-git-send-email-felipe.contreras@gmail.com>
	<1370796057-25312-11-git-send-email-felipe.contreras@gmail.com>
	<20130609171810.GA10858@goldbirke>
	<CAMP44s3yhVbgkhtrSfHpk=VwcwMkb66ELA-xR0i6FCVGyRwHJw@mail.gmail.com>
	<20130609173342.GB2091@goldbirke>
	<20130609173739.GF22905@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sun Jun 09 19:54:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UljoU-0004Py-Jm
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 19:53:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751638Ab3FIRxv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jun 2013 13:53:51 -0400
Received: from mail-lb0-f176.google.com ([209.85.217.176]:39071 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751088Ab3FIRxk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Jun 2013 13:53:40 -0400
Received: by mail-lb0-f176.google.com with SMTP id z5so5528132lbh.7
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 10:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=1LEt0SuO+O3lYToQpHPD4XGYdw9+q9vMj9Y7aGWKRpE=;
        b=owgbqEN0Fdw/A9+TKwSyyC24UR4FdaqOUJ2XLeqIB6Ncu6wkx2nAwy8wQnuKYLmAiv
         0buMfcdePE5PAUzrhTy7quJUYBnHkBkmmvRfZTDzoobqEP9Y49lxePHTIsqhwXsRIktd
         ua+F7ktUxkFenER6cf58Ahp6+PUIg7/rel+qfdF6z2rC69x8Ey+OTWU2xPg5ECWi8qnw
         SmEy5oXqs4EHp4E2/kNrjpmT7dTNEV3toPzTTh3WyUG3FMA5diQ5+H1c9GvECCL9TwJw
         UI4T9Y5GkDUuQYJOTXvS3gsKtWQ2/rNJF7cNdI+t4RMdBIAWPDmzC77FqlttK3Vl2OM8
         uQqQ==
X-Received: by 10.152.22.73 with SMTP id b9mr3371371laf.36.1370800418968; Sun,
 09 Jun 2013 10:53:38 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Sun, 9 Jun 2013 10:53:38 -0700 (PDT)
In-Reply-To: <20130609173739.GF22905@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227054>

On Sun, Jun 9, 2013 at 12:37 PM, John Keeping <john@keeping.me.uk> wrot=
e:
> On Sun, Jun 09, 2013 at 07:33:42PM +0200, SZEDER G=C3=A1bor wrote:
>> On Sun, Jun 09, 2013 at 12:23:01PM -0500, Felipe Contreras wrote:
>> > On Sun, Jun 9, 2013 at 12:18 PM, SZEDER G=C3=A1bor <szeder@ira.uka=
=2Ede> wrote:
>> > > On Sun, Jun 09, 2013 at 11:40:22AM -0500, Felipe Contreras wrote=
:
>> > >> We should free objects before leaving.
>> > >>
>> > >> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>> > >
>> > > A shortlog-friendlier subject could be: "sequencer: free objects
>> > > before leaving".
>> >
>> > I already defended my rationale for this succinct commit message:
>> >
>> > http://thread.gmane.org/gmane.comp.version-control.git/225609/focu=
s=3D225610
>>
>> Your arguments were unconvincing.  The mere fact that I raised this
>> issue unbeknownst to the earlier posting clearly shows that there's
>> demand for descriptive subjects.
>
> Not to mention that with your subject no body is needed, making the
> overall message more succinct.

It's not succinct at all, because there's no short and quick
description of what the patch actually is; a trivial fix.

> When reading a log, as soon as I see "trivial" I become suspicious th=
at
> someone is trying to cover something up, much like "left as an exerci=
se
> for the reader".  If the subject says "fix memory leak" then it's
> obvious what the patch is meant to do, and when there is no subtlety =
to
> be explained (as there isn't in this patch) there is no need for a bo=
dy.

You are not a rational person then. The commit message has absolutely
no bearing on the quality of the code. If you are less suspicious of a
commit message that says "fix memory leak", you are being completely
biased.

Whether the commit message says "fix memory leak", or "trivial fix",
or "foobar", the code might still be doing something wrong, and you
can't decide that until you look at the code.

If you don't care about the code, but still want to know what the
patch is doing, then you can look at the whole commit message, and "We
should free objects before leaving." explains that perfectly.

=46or the people that only read the summary, the vast majority of them
need to know what this patch is, not what it does, and when they see
"trivial fix" they most likely can skip it.

--=20
=46elipe Contreras
