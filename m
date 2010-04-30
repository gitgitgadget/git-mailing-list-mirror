From: =?UTF-8?B?SGVydsOpIENhdXdlbGllcg==?= <herve@itaapy.com>
Subject: Re: Multiblobs
Date: Fri, 30 Apr 2010 21:06:10 +0200
Message-ID: <4BDB2A22.40400@itaapy.com>
References: <loom.20100428T164432-954@post.gmane.org> <k2y32541b131004281107u6d15ed4ex54b5e5c138cc0e24@mail.gmail.com> 	<loom.20100428T204406-308@post.gmane.org> <4BDA9F5C.2080808@itaapy.com> <u2lb4087cc51004301116t17ba0efamf4c9b38842bad409@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 30 21:04:51 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O7vW6-0004r3-3E
	for gcvg-git-2@lo.gmane.org; Fri, 30 Apr 2010 21:04:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932953Ab0D3TEl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Apr 2010 15:04:41 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:50345 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759408Ab0D3TER (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Apr 2010 15:04:17 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 8A08C818157;
	Fri, 30 Apr 2010 21:04:07 +0200 (CEST)
Received: from [192.168.1.3] (lns-bzn-28-82-250-155-237.adsl.proxad.net [82.250.155.237])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 52037818196;
	Fri, 30 Apr 2010 21:04:05 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100330 Shredder/3.0.4
In-Reply-To: <u2lb4087cc51004301116t17ba0efamf4c9b38842bad409@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146047>

On 04/30/10 20:16, Michael Witten wrote:
> 2010/4/30 Herv=C3=A9 Cauwelier<herve@itaapy.com>:
>>
>> Unless you are talking about a dedicated application to store and ge=
nerate
>> on-the-fly office documents, built on top of Git, you're better not =
touching
>> the contents the user is entrusting git to store, and write a .gitat=
tribute
>> not to compress them in a pack.
>
> Doesn't OOo provide at least some library of official code for
> handling such files, so that other programs might be able to
> interoperate?

I'm not sure what you mean but the only way to interoperate with OOo is=
=20
to run it in "server mode" with at least a framebuffer xorg in the=20
background. Then you connect a client and use their RPC/Corba-like API.

OpenDocument libraries all start from scratch, or at least the RelaxNG=20
schema to generate validating code.

If the chunks are Zip parts, you're almost done. If you want smarter=20
splitting logic like slides in a presentation, sheets in a spreadsheet,=
=20
and pages... no, there is no page in a text; well, you need to go=20
through the XML layer or better use a OpenDocument library that=20
abstracts it. Other parts in the Zip like styles and metadata are easie=
r=20
to split since they are basically a linear collection of objects.

> If so, then it would be almost trivial for an OpenDocument 'plugin' t=
o
> be 'built on top of Git'.
>
> If not, then OOo is crap.

I already had reasons to conclude this. But hopefully OD is an open=20
standard, not restricted to OOo.

--=20
Herv=C3=A9 Cauwelier - ITAAPY - 9 rue Darwin 75018 Paris
T=C3=A9l. 01 42 23 67 45 - Fax 01 53 28 27 88
http://www.itaapy.com/ - http://www.cms-migration.com
