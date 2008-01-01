From: Jan Hudec <bulb@ucw.cz>
Subject: Re: git over webdav: what can I do for improving http-push ?
Date: Tue, 1 Jan 2008 12:33:01 +0100
Message-ID: <20080101113301.GC9214@efreet.light.src>
References: <477822C3.9060002@gbarbier.org> <alpine.LNX.1.00.0712302145500.13593@iabervon.org> <47791F90.8030302@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	=?utf-8?B?R3LDqWdvaXJl?= Barbier <gb@gbarbier.org>,
	git@vger.kernel.org
To: Graham Barr <gbarr@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 01 12:33:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J9fNS-0007OY-1g
	for gcvg-git-2@gmane.org; Tue, 01 Jan 2008 12:33:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753160AbYAALdP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Jan 2008 06:33:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753139AbYAALdP
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Jan 2008 06:33:15 -0500
Received: from ns1.bluetone.cz ([212.158.128.13]:42332 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753106AbYAALdO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jan 2008 06:33:14 -0500
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id F019557461;
	Tue,  1 Jan 2008 12:33:10 +0100 (CET)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id NXcHBtk5j-zH; Tue,  1 Jan 2008 12:33:08 +0100 (CET)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id C84F957443;
	Tue,  1 Jan 2008 12:33:06 +0100 (CET)
Received: from bulb by efreet.light.src with local (Exim 4.68)
	(envelope-from <bulb@ucw.cz>)
	id 1J9fMj-0005pw-QR; Tue, 01 Jan 2008 12:33:01 +0100
Content-Disposition: inline
In-Reply-To: <47791F90.8030302@pobox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69435>

On Mon, Dec 31, 2007 at 10:57:52 -0600, Graham Barr wrote:
> Daniel Barkalow wrote:
>> On Sun, 30 Dec 2007, Gr=C3=A9goire Barbier wrote:
>
>>> I'm using Git for a rather short time but enough to fall in love wi=
th it. For
>>> a few days I'm trying to use it over webdav, that is over http/http=
s with
>>> write (push) access. As for me, the main rationale to use http(s) r=
ather than
>>> git or ssh is to get through corporate firewalls, otherwise I would=
 probably
>>> not bother with webdav.
>
>> In general, we've been able to either get through firewalls with ssh=
 or=20
>> it's all in the same VPN. So it's kind of unloved at this point. Peo=
ple=20
>> poke at it occasionally, but mostly in the context of other fixes, I=
=20
>> think.
>
> If you have a http proxy that you can use, the you can use ssh via th=
at with
> something like corkscrew. http://wiki.kartbuilding.net/index.php/Cork=
screw_-_ssh_over_https

This, obviously, requires, that ssh is running on port 443, because mos=
t HTTP
proxies won't let you CONNECT anywhere else. I have also heared of a HT=
TP
proxy, that will check whether the session inside CONNECT starts with S=
SL
handshake and will break your connection if it does not.

> A simple shell script wrapper around ssh to detect when you are behin=
d a firewall
> can inject the ProxyCommand into the command line arguments with -o

Most of the time simply setting the parameter in .ssh/config works bett=
er
-- because you are often behind a proxy for some sites only.

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>
