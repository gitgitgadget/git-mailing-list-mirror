From: Andrew Myrick <amyrick@apple.com>
Subject: Re: git-svn taking a long time
Date: Wed, 10 Feb 2010 09:39:15 -0800
Message-ID: <E8C897D9-F8EB-4FF3-B27C-9679E008795A@apple.com>
References: <87hbppp8k7.fsf@krank.kagedal.org> <6D721095-7A04-4097-8D86-1A2B915182DF@apple.com> <87bpfxov6w.fsf@krank.kagedal.org>
Mime-Version: 1.0 (Apple Message framework v1133)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?iso-8859-1?Q?David_K=E5gedal?= <davidk@lysator.liu.se>
X-From: git-owner@vger.kernel.org Wed Feb 10 18:39:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfGX2-0000Z0-Cw
	for gcvg-git-2@lo.gmane.org; Wed, 10 Feb 2010 18:39:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756043Ab0BJRjS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Feb 2010 12:39:18 -0500
Received: from mail-out3.apple.com ([17.254.13.22]:51943 "EHLO
	mail-out3.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755882Ab0BJRjP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Feb 2010 12:39:15 -0500
Received: from relay14.apple.com (relay14.apple.com [17.128.113.52])
	by mail-out3.apple.com (Postfix) with ESMTP id 675168439E90;
	Wed, 10 Feb 2010 09:39:15 -0800 (PST)
X-AuditID: 11807134-b7cd9ae000001002-6c-4b72ef43488f
Received: from agility.apple.com (agility.apple.com [17.201.24.116])
	(using TLS with cipher AES128-SHA (AES128-SHA/128 bits))
	(Client did not present a certificate)
	by relay14.apple.com (Apple SCV relay) with SMTP id 49.C4.04098.34FE27B4; Wed, 10 Feb 2010 09:39:15 -0800 (PST)
In-Reply-To: <87bpfxov6w.fsf@krank.kagedal.org>
X-Mailer: Apple Mail (2.1133)
X-Brightmail-Tracker: AAAAAQAAAZE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139528>


On Feb 10, 2010, at 9:29 AM, David K=E5gedal wrote:

> Andrew Myrick <amyrick@apple.com> writes:
>=20
>> Give 1.7.0-rc2 a try.  It includes commit 8bff7c5383ed833bd1df9c8d85=
c00a27af3e5b02, which attempts to persistently cache a lot of the proce=
ssing that git-svn has to do on subversion's merge tickets, which has i=
mproved my fetch times significantly. =20
>=20
> By "merge tickets", are you talking about the merge functionality tha=
t
> appeared in subversion 1.5? We don't use that.

I do mean that.  If you don't use them, then I'm stumped.

> But I had another idea. I pecularity of our subversion repo is that w=
e
> no longer use the foo/trunk branch, but only foo/branches/*. But we d=
id
> once upon a time have a foo/trunk. And since I didn't include a "fetc=
h =3D
> foo/trunk:refs/remotes/svn/trunk" in my config, it might need to refe=
tch
> that information every time. For instance, the first revision is on
> trunk.
>=20
> I'm rerunning the fetch now with the trunk added, so see if it helps.
>=20
> And another note is that "git svn fetch --parent" was always quick.

Sounds reasonable.  Good luck!

-Andrew
