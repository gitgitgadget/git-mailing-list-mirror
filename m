From: "Matthias Andree" <matthias.andree@gmx.de>
Subject: Re: Merging in Subversion 1.5
Date: Fri, 28 Aug 2009 18:28:57 +0200
Message-ID: <op.uzdr2j0n1e62zd@balu.cs.uni-paderborn.de>
References: <4A979690.1050601@gnu.org>
 <m3ocq0km5m.fsf_-_@localhost.localdomain>
 <32541b130908280829s6fcebbe5ja84b10e649de1eb3@mail.gmail.com>
 <200908281819.10135.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Jakub Narebski" <jnareb@gmail.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 28 18:29:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mh4KM-0004UB-GA
	for gcvg-git-2@lo.gmane.org; Fri, 28 Aug 2009 18:29:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751713AbZH1Q26 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Aug 2009 12:28:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751623AbZH1Q26
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Aug 2009 12:28:58 -0400
Received: from mail.gmx.net ([213.165.64.20]:49184 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751493AbZH1Q25 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2009 12:28:57 -0400
Received: (qmail invoked by alias); 28 Aug 2009 16:28:58 -0000
Received: from balu.cs.uni-paderborn.de (EHLO balu.cs.uni-paderborn.de) [131.234.21.37]
  by mail.gmx.net (mp023) with SMTP; 28 Aug 2009 18:28:58 +0200
X-Authenticated: #428038
X-Provags-ID: V01U2FsdGVkX19iFKYLsZdi3Ny4OlIVRElgkVcIrlkAlgph0Q35Yt
	1GF3kQK3YtsaOe
Received: from localhost ([127.0.0.1] helo=balu.cs.uni-paderborn.de)
	by balu.cs.uni-paderborn.de with esmtp (Exim 4.69)
	(envelope-from <matthias.andree@gmx.de>)
	id KP3HSA-0004O8-4H; Fri, 28 Aug 2009 18:28:58 +0200
In-Reply-To: <200908281819.10135.jnareb@gmail.com>
User-Agent: Opera Mail/9.64 (Win32)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.58
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127311>

[culling most of Cc: list]

Am 28.08.2009, 18:19 Uhr, schrieb Jakub Narebski <jnareb@gmail.com>:

> On Fri, 28 Aug 2009, Avery Pennarun wrote:
>> On Fri, Aug 28, 2009 at 3:12 PM, Jakub Narebski<jnareb@gmail.com> wr=
ote:
>
>> > From what I understand (from what I have read, and browsed, and
>> > lurged, and noticed) is that Subversion 1.5+ does merge tracking, =
but
>> > in very different way that in Git:
>> >
>> > =A0* the svn:mergeinfo is client-side property; if I understand
>> > =A0 correctly this would help you in repeated merges, but not anyo=
ne
>> > =A0 other
>>
>> I don't believe there is such a thing as a "client-side property" in
>> svn.
>
> What about svn:ignore or svn:mimetype (IIRC) property?

All this is committed to the repository, so there isn't a question of i=
f =20
it's client-side in a sense of "local to the client/checkout". Some =20
properties (such as svn:mergeinfo) require a bit of additional server-s=
ide =20
support, but that's about it.

Oh, and to complicate matters, let me mention revprops (such as =20
svn:log).   SCNR :^)

--=20
Matthias Andree
