From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [VOTE] git versus mercurial (for DragonflyBSD)
Date: Tue, 28 Oct 2008 00:25:17 +0100
Message-ID: <200810280025.18234.jnareb@gmail.com>
References: <ge0rla$mce$1@ger.gmane.org> <200810271901.48925.jnareb@gmail.com> <200810272149.13542.arne_bab@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, mercurial@selenic.com, SLONIK.AZ@gmail.com
To: "Arne Babenhauserheide" <arne_bab@web.de>
X-From: git-owner@vger.kernel.org Tue Oct 28 00:26:46 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KubTu-0003IM-Aq
	for gcvg-git-2@gmane.org; Tue, 28 Oct 2008 00:26:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752836AbYJ0XZ3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Oct 2008 19:25:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752778AbYJ0XZ3
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Oct 2008 19:25:29 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:34388 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752661AbYJ0XZ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Oct 2008 19:25:27 -0400
Received: by ug-out-1314.google.com with SMTP id 39so95572ugf.37
        for <git@vger.kernel.org>; Mon, 27 Oct 2008 16:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=Bx2wy4h+c747KxbpP6jzQsVsYMZncXloBptnCql4z3Y=;
        b=l/syJuzsnhvMnkSOGnelZoE7F9EU+mjfkjQ+kFug7lbVcHS8+c2M7YP/RqyC+XM+N4
         ScWV+yayRVerHZQfQ3Z5fr5Qk7K23b013bdWlyJvYIn+cenBNr8amN0U+menYW82xTkB
         sjJuXvZIzdaVQ3lOqQgnm2Ctif9cHIKOz9JVc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=Wa3u74/tok678JNn5cuMzhT+3YTRw17T7vTd02176Mju1WTgDJybsxop0kqzZ5tHR2
         E+hbSmEPxYbnQtNn/WyBtN9aU0d/f1OOw52XIINq49USIAol9F05ho3bhtz5J4syV33Y
         2HotTTv6/3cg3qF54J9Lew53kAp8gjmE9Ft80=
Received: by 10.210.117.1 with SMTP id p1mr7433097ebc.91.1225149925463;
        Mon, 27 Oct 2008 16:25:25 -0700 (PDT)
Received: from ?192.168.1.11? (abwe94.neoplus.adsl.tpnet.pl [83.8.228.94])
        by mx.google.com with ESMTPS id 1sm367601nfv.18.2008.10.27.16.25.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 27 Oct 2008 16:25:23 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <200810272149.13542.arne_bab@web.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99268>

Dnia poniedzia=B3ek 27. pa=BCdziernika 2008 21:48, Arne Babenhauserheid=
e napisa=B3a:
> Am Montag 27 Oktober 2008 19:01:48 schrieb Jakub Narebski:
=20
> > Besides is writing plugin in Python for Mercurial that much easier
> > than writing new command or stuff in C for Git? Well, perhaps it is=
,
> > as only recently there began to appear API documentation, and there
> > were created utility mini-libraries like strbuf, or string_list,
> > or parseopt.
>=20
> Yes, for two main reasons:=20
>=20
> 1) Writing Python is much easier and quicker than writing C, especial=
ly when=20
> you can just experiment with the Python interpreter (or better still:=
 with=20
> ipython). No memory management hassle, no strange compiler bugs, no s=
tray=20
> pointers. Just plain writing what you want to do. But if you need C s=
peed, you=20
> can still include parts written in C - where you really need it. For =
all other=20
> cases you have more readable and far more compact code.=20

In Git you can write in C, using (underdocumented) git API, or you can
script (in shell script, in Perl, in Python, in Ruby) using git plumbin=
g
commands which are meant for scripting (or bindings in appropriate
language).
=20
Most new features, like git-remote tool to manage interaction with
multiple remote repositories, each of which can have multiple branches,
start as a shell or Perl script, and when they and their UI mature they
get converted into C (made into builtin). Builtinification is done not
only for performance, but also for portability (think Perl support on
MS Windows).

So in Mercurial you can write in Python, or you can write in C; in Git
you can write in any scripting language (e.g. shell script, Perl, Tcl/T=
k),
or you can write in C... yes, I know it is oversimplification...

> 2) You can easily access every core function, and you can replace eve=
ry=20
> command.=20
> You don't have to invent a "git foolog" command. Instead you can just=
 adapt=20
> the regular log to do a foolog which people can use via "hg log".

Well, if I remember correctly if you drop git-foo in EXEC_PATH, then
you would be able to call it as "git foo". So adding commands is easy.

Git provides a few entry points which can be used to extend
functionality. They are: hooks system; gitattributes to define custom
merge, diff and clean/smudge (checkout) drivers per file (pathname);
custom merge strategies; EXTRENAL_DIFF and EXTERNAL_GREP.

I'm not sure if other messing with core functions is a good idea to
have such ability accessible.

> > The extending via plugins idea used by Mercurial, so succesfull IMH=
O
> > for Firefox, and I think quite successfull for ikiwiki for example,=
 is
> > not without drawbacks, especially that there is no plugins clearing=
house,
> > and plugins are required for what is considered pretty required
> > functionality, like bisect before hg 1.0.
>=20
> But they can just be included in the core distibution once they becom=
e central=20
> enough.=20

Having some extensions blessed to be included with core program (like
ikiwiki with goodstuff, and similar to Git with contrib/ section)
solves some problems of relying on extensions for basic functionality.
I for example consider bisect and patch+mail workflow tools to be basic=
,
while patch queue management (well, patch management in general) to be
something that can be built on top of SCM, like StGit, Guilt, TopGit
for Git, or mq (Mercurial Queues) for Mercurial.
=20
>
> It's a way of allowing people to add functionality they miss without =
forcing=20
> them to mess with core code instantly.=20

The problem with extensions IMVVVHO is that they don't require to
follow strict "inclusion in core" standards, which means that there
is no pressure to add them to core... which for example leads to
including bisect in core only since hg v1.0, "because it is available
as extension".

Requiring to use large amount of extensions to having required
functionality is also one of bad consequences of extension based
development, although having default set of extensions that can be
turned on via some metaextension / metapackage (like ikiwiki's
goodstuff) reduces impact of this.
=20
Extensions / modules / plugins are good in projects with high
barriers of development, like Mozilla / Firefox, GNU Emacs, etc.
but I am not sure if it doesn't make for slower core development...

> Gits missing plugin system might just be a reason, why its usability =
still=20
> suffers from many problems: They have to do everything for everyone a=
ll the=20
> time, so the chances are high, that they won't do it really good for =
anyone=20
> (but the main git coders).=20

Well, Git doesn't have plugin system, but is easily scriptable...

And, at least according to annual Git User's Survey results (on git wik=
i)
many people create their custom scripts and scriplets to make their wor=
k
with SCM easy...

--=20
Jakub Narebski
Poland
