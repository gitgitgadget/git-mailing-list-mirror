From: Olivier LE ROY <olivier_le_roy@yahoo.com>
Subject: Re: Handling empty directories in Git
Date: Tue, 8 Apr 2014 11:39:25 -0700 (PDT)
Message-ID: <1396982365.73812.YahooMailNeo@web120805.mail.ne1.yahoo.com>
References: <1396968442.95061.YahooMailNeo@web120806.mail.ne1.yahoo.com>	<vpqob0blpna.fsf@anie.imag.fr> <87zjjvg1v1.fsf@fencepost.gnu.org>
Reply-To: Olivier LE ROY <olivier_le_roy@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: David Kastrup <dak@gnu.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Apr 08 20:39:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXavk-0000Sj-Kr
	for gcvg-git-2@plane.gmane.org; Tue, 08 Apr 2014 20:39:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757466AbaDHSj2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Apr 2014 14:39:28 -0400
Received: from nm5-vm4.bullet.mail.ne1.yahoo.com ([98.138.91.165]:35564 "EHLO
	nm5-vm4.bullet.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756359AbaDHSj1 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 8 Apr 2014 14:39:27 -0400
Received: from [98.138.100.111] by nm5.bullet.mail.ne1.yahoo.com with NNFMP; 08 Apr 2014 18:39:26 -0000
Received: from [98.138.89.244] by tm100.bullet.mail.ne1.yahoo.com with NNFMP; 08 Apr 2014 18:39:26 -0000
Received: from [127.0.0.1] by omp1058.mail.ne1.yahoo.com with NNFMP; 08 Apr 2014 18:39:26 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 125400.66295.bm@omp1058.mail.ne1.yahoo.com
Received: (qmail 17623 invoked by uid 60001); 8 Apr 2014 18:39:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1396982365; bh=iVCQdp3xP5nhw9+zWm5fuIeE75EROUmoABxGZ7fT/Jg=; h=X-YMail-OSG:Received:X-Rocket-MIMEInfo:X-Mailer:References:Message-ID:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding; b=NE4fNw430aOFzf/tn44sD2joQBGMTJZKxU9jtHepX61HSLZNzNwACwYy9ON2kHMFdh0L+ix9D6VEMiXJJziGQnIuidYNisXqMfiQFLm8thEWZ4CjdO1ACk9P9zWepzsNq/JdDlOPTi3V1yMOb9VbmXCAXAssp+rAggmK0HvNd6Q=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:X-Rocket-MIMEInfo:X-Mailer:References:Message-ID:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=ZDcC+GOkWtQlXYAJ4O0nqhLGNEbLQq+sbDj+d8BOqEgGOkhOpiBIOvTSznE9F5GZSRZf6Ay4Oc6V6EYiedXMnI0t83is80wD/oGMjVyf0Hp7Vd1oyscJJqVav++cSnp4zCqw6088PEl/kSnx4VAiForEcJTK409jmTyyJZBB+Bo=;
X-YMail-OSG: sqpI7TYVM1myvqnNT6scTPQQRnvcuEpAA0PXryqgplYHrKW
 j3beREwX0BCjoxHVK42OTqB.gupQ0C9iHJMW_30s27AEJQULgKEJ16IH0_lO
 OZ83QkiE5qnwLGh255gK6e7vJJpxMQdU8Rre8darQ6dUQd5BoW1Z32nKYgx9
 ROzCn0enRcpdKjpg5i.2NgwoaZSXUlHyaglM8g1.6FATndBMwZajz3jKe4RX
 XV4gjonhrOPq1RpR8YmKmndSia_bLBlyYshr78bsvm1CoZ4JHHSBxwnDdjYk
 qUwjWKbshOiq9TagbtJU0k4YlJXt2p5Vk.FNL6asZWqPdd1sRsOYjvCGSzvd
 SBWnCWSKe82tod8Qu3MEIbE04_mkR.hkyPrdHRxrVRPLjbwPg7jkAYIJRqQ0
 t78ywZvsTWYolwzcxT1bfCfMX2ZFaeiwGVbFlr3oMocISZEQR2WV103e5QiP
 ehi.WQL3kNbU1ffk2YjQnkagVrlaHa3BHK9xLFy4ElJ5S2Qb.wRqTsClgSV2
 Bm8dLh1s7LRfRMAzJgMY3BfU8R22gNgZXUGK2nD1StN7TOgKUmJ1XHhEacQ-
 -
Received: from [92.163.125.246] by web120805.mail.ne1.yahoo.com via HTTP; Tue, 08 Apr 2014 11:39:25 PDT
X-Rocket-MIMEInfo: 002.001,SGkgRGF2aWQsCgp0aGFua3MgZm9yIHRoZSB3aG9sZSBzdG9yeS4gV2UgdW5kZXJzdGFuZCB3aHkgdGhlIGVtcHR5IGRpcmVjdG9yaWVzIGhhbmRsaW5nIHdhcyBuZXZlciBjb21wbGV0ZWQsIGFuZCBob3cgaXQgY291bGQgYmUsIGlmIG9uZSBkZXZlbG9wZXIgc3VibWl0ZWQgcGF0Y2hlcyBmb3IgdGhhdC4KClJlZ2FyZHMsCgpPbGl2aWVyIExFIFJPWQoKCgotLS0tLSBNYWlsIG9yaWdpbmFsIC0tLS0tCkRlwqA6IERhdmlkIEthc3RydXAgPGRha0BnbnUub3JnPgrDgMKgOiBNYXR0aGlldSBNb3kgPE1hdHRoaWUBMAEBAQE-
X-Mailer: YahooMailWebService/0.8.182.648
In-Reply-To: <87zjjvg1v1.fsf@fencepost.gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245943>

Hi David,

thanks for the whole story. We understand why the empty directories han=
dling was never completed, and how it could be, if one developer submit=
ed patches for that.

Regards,

Olivier LE ROY



----- Mail original -----
De=A0: David Kastrup <dak@gnu.org>
=C0=A0: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Cc=A0: Olivier LE ROY <olivier_le_roy@yahoo.com>; "git@vger.kernel.org"=
 <git@vger.kernel.org>
Envoy=E9 le : Mardi 8 avril 2014 17h36
Objet=A0: Re: Handling empty directories in Git

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> The reason would be closer to "there is a valuable reason, but not
> valuable enough to change Git to do it". It's actually not so easy to
> track directories properly. Storing them in the Git repository is
> actually possible (actually, an empty tree is a special case of this,
> and is obviously supported), but defining and implementing a decent
> behavior for each Git command wrt this is not trivial.
>
> David Kastrup gave it a try a few years ago. I don't remember exactly
> what made him give up, but it was never completed and merged.

Oh, most likely what afflicts most of my unfinished projects.=A0 I=A0lo=
st
focus at some point of time.=A0 I don't remember any fundamentally
unsolvable problems, but then I don't remember much at all.=A0 There we=
re
some annoyances with sorting order (either regarding the sorting of xxx=
/
or . or ./ or whatever) and some other stuff.

If anybody wants to take a look at the direction of unfinished stuff,
I=A0can see whether there are some old backups with git repos in my
possession.=A0 But I really have no idea how much of the design might h=
ave
ended up in actual comments or code, and how much on some scraps of
paper or half-committed memory, and how much of that might have been
invalidated by other scraps of paper and half-committed memory.

So there is not likely to be more than food for thought recoverable.

I'm amused that you remember me being involved with that.=A0 I=A0think
I=A0myself had forgotten all about it until recently.=A0 I=A0don't even
recollect what made me remember again: looking at some old repo/commit
or searching in some old mailing list archive.


--=20
David Kastrup
