From: "Ferry Huberts (Pelagic)" <ferry.huberts@pelagic.nl>
Subject: Re: jgit and ignore
Date: Sun, 01 Mar 2009 18:17:50 +0100
Message-ID: <49AAC33E.6030906@pelagic.nl>
References: <9e4733910902280831j70448ce9h7239f14e13b92b76@mail.gmail.com>	 <20090228172622.GC26689@spearce.org> <49AA5F64.6070207@pelagic.nl> <9e4733910903010454u662eb5afob45f608321660500@mail.gmail.com> <49AA884D.1050806@pelagic.nl> <49AA8ECD.4090302@gmail.com> <49AA91F0.7050008@pelagic.nl> <49AAA2B3.40808@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jon Smirl <jonsmirl@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-1?Q?Tor_Arne_Vestb=F8?= <torarnv@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 01 18:20:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdpKt-0001rG-0t
	for gcvg-git-2@gmane.org; Sun, 01 Mar 2009 18:20:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753735AbZCARRy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 Mar 2009 12:17:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753657AbZCARRx
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Mar 2009 12:17:53 -0500
Received: from hupie.xs4all.nl ([82.95.241.251]:46571 "EHLO
	Lighthouse.internal.Hupie.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753634AbZCARRw convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 1 Mar 2009 12:17:52 -0500
Received: from [192.168.0.101] (unknown [192.168.0.101])
	by Lighthouse.internal.Hupie.com (Postfix) with ESMTP id 4995E58BDBA;
	Sun,  1 Mar 2009 18:17:50 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
In-Reply-To: <49AAA2B3.40808@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111858>

Tor Arne Vestb=F8 wrote:
> Ferry Huberts (Pelagic) wrote:
>> Tor Arne Vestb=F8 wrote:
>>> In my opinion, EGit should default to using Eclipse's built in igno=
res,
>>> but then detect the presence of a global core.excludesfile, in whic=
h
>>> case it would notify the user ("I see you have a core.excludesfile"=
) and
>>> let the user switch to using that one instead.
>=20
> [snip]
>=20
> First of all, I do appreciate you working on the ignore feature :)
>=20
>> I do not agree with your propasal however.
>> We then would have different behaviour between how 'git' behaves wit=
hin
>> Eclipse (by means of the plugin) and how 'git' behaves within the
>> command line. That alone can cause much more confusion.
>=20
> I see what you mean, and I agree that in general the command line git
> porcelain and the Eclipse git porcelain should work in similar ways.
>=20
> But, with that said, I think of EGit as a standalone Eclipse-plugin
> implementation of the git porcelain -- not just a wrapper around the
> command line porcelain.
>=20
> To me that means that EGit should focus just as much on integrating w=
ith
> Eclipse properly as it does on keeping command line porcelain
> interoperability.
>=20
> The core.excludesfile is one such case, and I think my proposal is a
> good compromise.
>=20

how about we all (especially me) think a bit better on this and solve i=
t
later when I've completed the rest? That allows me to focus for now.
I think we can easily synchronise between the eclipse global ignores an=
d
the core.excludesfile when we (really) want to.
