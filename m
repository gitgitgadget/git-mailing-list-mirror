From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH 3/3] Adds a #!bash to the top of bash completions so that editors can recognize, it as a bash script. Also adds a few simple comments above commands that, take arguments. The comments are meant to remind editors of potential, problems that can occur when the script is sourced on systems with "set, -u."
Date: Thu, 15 Jan 2009 23:56:00 +0100
Message-ID: <200901152356.00997.markus.heidelberg@web.de>
References: <496CBD17.3000207@tedpavlic.com> <200901131403.16012.bss@iguanasuicide.net> <20090113201024.GA20129@chistera.yi.org>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Ted Pavlic <ted@tedpavlic.com>, git <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Adeodato =?utf-8?q?Sim=C3=B3?= <dato@net.com.org.es>
X-From: git-owner@vger.kernel.org Thu Jan 15 23:57:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNb93-0007fa-6S
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 23:57:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934938AbZAOWze convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Jan 2009 17:55:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765810AbZAOWzc
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 17:55:32 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:59832 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934779AbZAOWz3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Jan 2009 17:55:29 -0500
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate03.web.de (Postfix) with ESMTP id 44F8CF6940AA;
	Thu, 15 Jan 2009 23:55:26 +0100 (CET)
Received: from [89.59.96.34] (helo=pluto)
	by smtp08.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1LNb7W-0003c6-00; Thu, 15 Jan 2009 23:55:26 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <20090113201024.GA20129@chistera.yi.org>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX19hRGUh/q7MDBKLisPdWENTVifbflX4UQnqAnKj
	MUhZhqO3GvmwMq+G/op2INabDKNVBh+V7RtfEDf7spf5YhCqEb
	yrYQQEZag3EO6o/8D5GA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105890>

Adeodato Sim=C3=B3, 13.01.2009:
> * Boyd Stephen Smith Jr. [Tue, 13 Jan 2009 14:03:11 -0600]:
>=20
> > On Tuesday 2009 January 13 10:45:18 Shawn O. Pearce wrote:
> > >See [...] how the subject is a niceshort, one
> > >line summary of the module impacted and the change?
>=20
> > My rule for this is absolutely no more than 80 characters.
>=20
> My rule for *all* of the commit message is "absolutely no more than 7=
6
> characters". With more than 76, `git log` wraps in a 80-column termin=
al.

What about the 50 character limit proposed in the documentation
(git-commit, gittutorial, user-manual)?

At the beginning I tried to fulfil this limit, but often it's not easy.
So should it be adjusted to a slightly higher value in the documentatio=
n
or even split into a recommended limit (e.g. 50) and a recommended
absolute maximum (e.g. 76)? Hmm, the split wouldn't make sense, I think=
=2E

Markus
