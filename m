From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: GSoC idea: adding JavaScript library / framework in gitweb
Date: Wed, 28 Mar 2012 11:38:48 +0100
Message-ID: <201203281238.49171.jnareb@gmail.com>
References: <CACeyogcFJoUyAiTReDJK_nCMGBp+23OjcS407A1X=fqFR+aGag@mail.gmail.com> <201203272114.33122.jnareb@gmail.com> <CACeyoge5iVAEebwj8NHo9VF=OO10M4sG4WegngBqr6qnsYvjQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: chaitanyaa nalla <nallachaitu@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 28 12:39:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCqHM-00049U-J5
	for gcvg-git-2@plane.gmane.org; Wed, 28 Mar 2012 12:39:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754636Ab2C1Kiz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Mar 2012 06:38:55 -0400
Received: from mail-wg0-f42.google.com ([74.125.82.42]:44729 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751227Ab2C1Kix (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2012 06:38:53 -0400
Received: by wgbds11 with SMTP id ds11so4115495wgb.1
        for <git@vger.kernel.org>; Wed, 28 Mar 2012 03:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-disposition:content-type
         :content-transfer-encoding:message-id;
        bh=SiFVI0NQzIM4nBWoly/m3Qa+sF242l34iKYGzkQTO3M=;
        b=BuUihrVTEvcnhAROp/1EoH+iBP9xlXE2ABlUg4NzyU63k5rYkz7Rr+T3mVJPvp3r8/
         BEL2KXcbrLOVygLA38GYqD8+ChTHvP5TG9MyyCYS8ezjpUVQDufFDO8ue1xbGcsjVQzK
         F+VQk61/1jxafT1z1QFWs51kUWBzpvl6XDM6r1/U3Jg+6AusOzv5lkjAz7e+H/P3NhPV
         aGZekZJ6t+u04sCT202snV6QMWb2GwN1nVFqzbr23vvDXTjAqA0tvxUH79UEOX2ZKO1V
         5jtTXdpc6wWNit2HW/EwuJ4NGlxjfjf0r3xYs/FfTQggez1wL3nZoQczGFWxKvxnyA0Y
         kkkQ==
Received: by 10.180.101.72 with SMTP id fe8mr5904462wib.4.1332931132325;
        Wed, 28 Mar 2012 03:38:52 -0700 (PDT)
Received: from [192.168.1.13] (adhb238.neoplus.adsl.tpnet.pl. [79.184.157.238])
        by mx.google.com with ESMTPS id 6sm20249828wiz.1.2012.03.28.03.38.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 28 Mar 2012 03:38:51 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <CACeyoge5iVAEebwj8NHo9VF=OO10M4sG4WegngBqr6qnsYvjQQ@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194117>

On Tue, 27 Mar 2012, chaitanyaa nalla wrote:

> Dear Jakub,
>=20
> I prepared a schedule for gsoc ,please take a look and suggest me in
> case if you feel some tasks couldn't be completed with in indicated
> time .
>=20
> Week 1 =EF=83=A0 understanding how the whole gitweb and related serve=
r side
> scripts are implemented , their design philosophy , coding standards =
,
> documentation standards to maintain the best practise coding
> practices.

I think you need to at least skim the JavaScript part of gitweb code
to be able to create a decent proposal.

> Brainstorming sessions regarding which libraries to use on=20
> specific scenarios by keeping many criteria=E2=80=99s in mind and cre=
ating an
> abstract design on the additional features  that have to be added.

I think it would be a good idea to propose JavaScript library / framewo=
rk
to use for client-side scripting in gitweb (jQuery, MooTools, Dojo, YUI=
),
explaining shortly why this one and not other (popularity, "weight", yo=
ur
knowledge, etc.).  Though perhaps not commit to said library.

You say "libraries", but I think gitweb should use single JavaScript
library, perhaps with exception of specialized libraries or plugins for
extra stuff like Raphael.js for drawing.

Also here or later there should be time for short discussion about
marrying use of external JavaScript library to gitweb.perl script and
to our build system (gitweb/Makefile).

> Week 2 =EF=83=A0 Improving Javascript browser detection and increment=
al blame.

Errr... gitweb does not employ browser detection.  Well, at least not
in strict sense; it does employ some feature detection e.g. to create
XmlHttpRequest -- but that is what library is for, it is assumed to do
cross-browser behavior for us.

Anyway improving existing features, and adding new features should be
much later.  The very first thing is to transform existing code (JavaSc=
ript
detection, adjusting timezones and incremental blame) from hand written
JavaScript to using JavaScript library, incrementally if possible, and
removing our own mini-library in `gitweb/static/js/lib/`.

[...]
> Week 3 =EF=83=A0Improving UI of adjusting timezone by deciding which =
library /
> framework to use on UI.

I don't think timezone select UI needs much improvement. =20

Anyway I think that we would either use library, or UI addons for libra=
ry
(like jQuery UI if you choose jQuery), or plugins for library.

> Week 4 & 5=EF=83=A0 design and implementation of client side sorting =
of tables

That should be fairly easy (though I am not sure if "1 week" easy).
This is what "sorttable" does in jQuery and I guess also other librarie=
s
(built-in or via plugin); what needs to be adjusted is replacing or=20
overriding (perhaps via onclick handler) links to server-side sorting
by trigger to client-side sorting.  Keeping table zebra-colored might
be a problem, but I think JavaScript libraries solved that already.

> and client side syntax highlighting of the blob view by handling how
> git web splits the output into lines and providing line numbers.

That can be hard, and here there might be question of choosing separate
library for JavaScript-based source highlighting.  There is also a=20
question of integrating it with server-side source highlighting (turnin=
g
off JS-based if server side already does syntax highlighting, and using
the same CSS).

> Week 6 =EF=83=A0 testing the code robustly on as many browsers as pos=
sible
> (with their versions) and documenting the code neatly .

This is a good idea.

> MidTerm Delivarables : Improving javascript browser detection,
> incremental blame,ui of adjusting timezone .Adding client side sortin=
g
> of tables and client side syntax highlighting of blob view .

I would be happy if at midterms you would have existing JavaScript
features ported to JavaScript library, without adding any new features
or extending existing ones.

> Week 7 & 8=EF=83=A0 Using deferrands or queues in the interactive bla=
me to
> avoid the editing of DOM which happens asynchronously to avoid
> locking

O.K.  You will have to check chosen JavaScript library documentation
for its name for such things; different libraries uses different names
for asynchronous processing helpers.

This might be hard part, but if you think you can do it in week
or two...

> and automatic extending of clickable area for places where the=20
> link is constrained to a single cell or of that type.

Nice.  This also means that on server side we can remove link within
link (which does not work in some overly strict web browsers), but
this server-side change doesn't need to be done by you.

> Week 9 & 10 & 11=EF=83=A0 design and implementation support for graph=
ical
> representation of history in log ,shortlog and history using Raphael
> javascript library, adding UI to compare arbitrary commits in the pag=
e
> using commitdiff view similar to MediaWiki page history view and
> creating a side by side diff from unified diff in javascript so that
> switching between unified diff and side by side diff could be handled
> on client side.

O.K., though graphical representation of history might be harder than
that (than allowed 1 week or 2).

Side-by-side diff is just porting from Perl to JavaScript.

> Week 12 =EF=83=A0 documentation , writing a detail report , testing
> exhaustively and checking whether the written code follows the
> characteristics .
> Note: considerable amount of time will be spent each week
> concentrating on design for adding a new feature since its design
> greatly affects many things.

--=20
Jakub Narebski
Poland
