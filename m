From: "Ron Parker" <ron.parker@mobot.org>
Subject: RE: [OT] CDPATH
Date: Tue, 24 Apr 2007 08:34:22 -0500
Message-ID: <769697AE3E25EF4FBC0763CD91AB1B0201D496D1@MBGMail01.mobot.org>
References: <769697AE3E25EF4FBC0763CD91AB1B0201D496D0@MBGMail01.mobot.org> <7vvefmeqs6.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0704232235280.7626@beast.quantumfyre.co.uk> <7vvefmdab8.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0704232351530.8430@beast.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>
To: "Julian Phillips" <julian@quantumfyre.co.uk>,
	"Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Apr 24 15:34:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgLA2-0000GW-Mw
	for gcvg-git@gmane.org; Tue, 24 Apr 2007 15:34:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161764AbXDXNeY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 24 Apr 2007 09:34:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161765AbXDXNeY
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Apr 2007 09:34:24 -0400
Received: from mbgmail01.mobot.org ([63.78.97.14]:19006 "EHLO
	mbgmail01.mobot.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161764AbXDXNeX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Apr 2007 09:34:23 -0400
Content-class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <Pine.LNX.4.64.0704232351530.8430@beast.quantumfyre.co.uk>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [OT] CDPATH
Thread-Index: AceF+sYVJ0JW3/W7TESUO+vF6OZlagAc9auA
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45449>

Junio C Hamano <junkio@cox.net> wrote:

> Are you sure bash-completion is the culprit, not your CDPATH?

Sorry, I was half-asleep yesterday.  Of course it was CDPATH and not=20
bash-completion.

Julian Phillips <julian@quantumfyre.co.uk> wrote:

> CDPATH is Ok as long as it stays as an interactive shell
> variable.

Based on a shell I used years ago that had built-in functionality simil=
ar to
CDPATH, I na=EFvely *assumed* CDPATH would only impact interactive shel=
ls.

In another message, Julian wrote:

> I guess part of the problem is that a lot of these people don't actua=
lly=20
> understand the difference between shell variables and environment=20
> variables, or why the distinction is useful.  Plenty of people seem t=
o do=20
> "export FOO=3D..." by rote.

Not quite my case, but assumptions are dangerous things.  Based on my=20
assumption, I intentionally exported CDPATH so it would propagate when
I "xterm&".  Grr, I guess I'll have to alias xterm instead.

Thanks for the enlightenment gentlemen.

Yet another reason I like "git reset --hard HEAD" for stupid patch remo=
val.

Now if there was a "reset --hard HEAD" function for some people I've me=
t...

Thanks,

Ron
