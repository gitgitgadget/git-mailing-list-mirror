From: Gianfranco Costamagna <costamagnagianfranco@yahoo.it>
Subject: I: git archive --worktree-attributes doesn't exclude .gitattributes  anymore
Date: Wed, 5 Jun 2013 08:22:44 +0100 (BST)
Message-ID: <1370416964.91753.YahooMailNeo@web172706.mail.ir2.yahoo.com>
References: <20130605031349.GA6727@sigill.intra.peff.net> <1370412601.77980.YahooMailAndroidMobile@web172702.mail.ir2.yahoo.com>
Reply-To: Gianfranco Costamagna <costamagnagianfranco@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 05 09:22:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uk83W-0005xc-Sf
	for gcvg-git-2@plane.gmane.org; Wed, 05 Jun 2013 09:22:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752267Ab3FEHWq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Jun 2013 03:22:46 -0400
Received: from nm19-vm0.bullet.mail.ird.yahoo.com ([77.238.189.92]:47973 "HELO
	nm19-vm0.bullet.mail.ird.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751703Ab3FEHWq convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 5 Jun 2013 03:22:46 -0400
Received: from [77.238.189.231] by nm19.bullet.mail.ird.yahoo.com with NNFMP; 05 Jun 2013 07:22:44 -0000
Received: from [212.82.98.75] by tm12.bullet.mail.ird.yahoo.com with NNFMP; 05 Jun 2013 07:22:44 -0000
Received: from [127.0.0.1] by omp1012.mail.ir2.yahoo.com with NNFMP; 05 Jun 2013 07:22:44 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 473201.9962.bm@omp1012.mail.ir2.yahoo.com
Received: (qmail 99985 invoked by uid 60001); 5 Jun 2013 07:22:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.it; s=s1024; t=1370416964; bh=RwT8kIz+FkxkK9RIo4EVCrFTYSBbXRfIcF0nMZPRts4=; h=X-YMail-OSG:Received:X-Rocket-MIMEInfo:X-Mailer:References:Message-ID:Date:From:Reply-To:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding; b=XJ7o+GkYjUSEW4nHt3jR/DgRyPq+ZSbWv8cwLj+SAucD9oQC73aVSkgWHt7yZUjJuGoE3bQdS4+u3sukFKRpFw/9NzmlzbmmTlQ1dSpP782d7N9yS09wt6SzG008eROqVCom3JRNRDJyDBGyx6XjqHyp+nZudiHcE8JY73CC3KE=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=X-YMail-OSG:Received:X-Rocket-MIMEInfo:X-Mailer:References:Message-ID:Date:From:Reply-To:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=CT4hJva6ks7uBpZ6vo/mx7eJnb0UVVRNmdUEXWpdplufD0GNsyoTK4CwH/M+OKTZtpOOKgMAnYFzSUidB+Sr38UfmmDNN1gDg52lVH7hAKGKU0QVpwpkf3yq/7p/X5Y7GjwzEwlrdqjoCr4rRlrsUqwoW3kuToRWgwFVPe98v+U=;
X-YMail-OSG: TVSbVAsVM1krIx7U_t8iIPcRGeDtgSQwFvJWBhpnsrBEVW3
 FhUWCii262PLgySwOWT8RSWq06tetWQ9Z_8dz0cvHOlulZj8TwkEkpGigk8i
 kp_OiM3NT7pmy5SlZvOOnHIZKH19OldasVhU05ApChoKFaG.ULS2HuAD7SZN
 PO12zpEOweUazQhsOzAofTneHg3a5h632I7eIm1ko_Ycl1nhvyWmsJrBtUEX
 V_jZZnUARoVO6013lt8m87vydKgVmvHtb41PxGc2.1TujX2n8n.bRldgDrVv
 702F249dULK2R6pxS.A9T7pMYk0zV.IrWjzuxsN2kfhIyRzvdEv7_UT.sU_Q
 ydd5El5zgMBwxfiGoWzI03cUlnf7fBU.fSYWcvFaVWuqKKjXuxeJMnanrbdH
 TMw3RJFuTQ6mkgljh3NNPkpE5L81X7_d6zDNvC5LCyitEPNCYDit_E9vQ_Ow
 bWf3qWuj_Db0VqZA8z7HRj.ITcFtRESgWOl4KsyVuNizDWhDPLQlMzwVE5XA
 0eqS7mIqFv_S63aoEPpRnp9xtKrNriaf5zFt1kABcCej_207_fhQdU.lEcSD
 4CPLrgnLoFQdytVkBrXG..0E.pw5adrwgOSdjpjkRC6ksHsrrww9ysvwmqw2
 6uv3A
Received: from [130.192.232.19] by web172706.mail.ir2.yahoo.com via HTTP; Wed, 05 Jun 2013 08:22:44 BST
X-Rocket-MIMEInfo: 002.001,U2VuZGluZyBhZ2FpbiwgdGhlIGxpc3Qgc3RyaXBzIGh0bWwKCj5PaCBtYW55IHRoYW5rcyBmb3IgeW91ciBhbnN3ZXIgSmVmZiEKPkkgd2FzIHdvbmRlcmluZyBhYm91dCBhIGZhdWx0IGluIG15IHNpZGUhCj5JIHdhcyBhbHJlYWR5IGJ1aWxkaW5nIDEuOC4zIHdoZW4gSSBzZW50IHRoZSBmaXJzdCBtYWlsLi4uCj5Bbnl3YXkKIHlvdXIgc29mdHdhcmUgaGFzIGEgYnVuY2ggb2YgdGVzdHMgdGhhdCBtYWtlIGNvbXBpbGF0aW9uIGEgbGl0dGxlIHNsb3cgCihhbmQgbm8sIEkgZG9uJ3Qgd2FudCB0byBkaXNhYmwBMAEBAQE-
X-Mailer: YahooMailWebService/0.8.145.547
In-Reply-To: <1370412601.77980.YahooMailAndroidMobile@web172702.mail.ir2.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226439>

Sending again, the list strips html

>Oh many thanks for your answer Jeff!
>I was wondering about a fault in my side!
>I was already building 1.8.3 when I sent the first mail...
>Anyway
 your software has a bunch of tests that make compilation a little slow=
=20
(and no, I don't want to disable them, they are there for a really good=
=20
reason).
>Just a question, is it possible to add a new test for handling this ki=
nd of regressions?
>And
 second, is it possible to have a patch for this problem? I'll be glad=20
to backport in debian, or to take care of updating the whole git packag=
e
 (it is already in experimental BTW)
>Thanks
>G.


----- Messaggio inoltrato -----
>Da: Gianfranco Costamagna <costamagnagianfranco@yahoo.it>
>A: "peff@peff.net" <peff@peff.net>; "git@vger.kernel.org" <git@vger.ke=
rnel.org>=20
>Inviato: Mercoled=EC 5 Giugno 2013 8:10
>Oggetto: Re: git archive --worktree-attributes doesn't exclude .gitatt=
ributes=A0=A0anymore
>=20
>
>
>Oh many thanks for your answer Jeff!
>I was wondering about a fault in my side!
>I was already building 1.8.3 when I sent the first mail...
>Anyway your software has a bunch of tests that make compilation a litt=
le slow (and no, I don't want to disable them, they are there for a rea=
lly good reason).
>Just a question, is it possible to add a new test for handling this ki=
nd of regressions?
>And second, is it possible to have a patch for this problem? I'll be g=
lad to backport in debian, or to take care of updating the whole git pa=
ckage (it is already in experimental BTW)
>Thanks
>G.
>Sent from Yahoo! Mail on Android=20
>
>
>
>________________________________
> From:=A0=A0Jeff King <peff@peff.net>;=20
>To:=A0=A0Gianfranco Costamagna <costamagnagianfranco@yahoo.it>;=20
>Cc:=A0=A0git@vger.kernel.org <git@vger.kernel.org>;=20
>Subject:=A0=A0Re: git archive --worktree-attributes doesn't exclude .g=
itattributes anymore=20
>Sent:=A0=A0Wed, Jun 5, 2013 3:13:49 AM=20
>
>
>On Tue, Jun 04, 2013 at 11:18:59PM +0100, Gianfranco Costamagna wrote:
>
>> git version 1.8.1.2
>> [...]
>> I tried to put .gitattributes or .git/info/attributes, the file is t=
he following
>> http://pastebin.com/irngA1L8
>> [...]
>> The archive gets created, but every file is inside, no exclusions at=
 all.
>>=20
>> I suspect a regression between git 1.7 and 1.8
>
>Yes, there was a regression with matching directory names in
>gitattributes in v1.8.1.1. The regression is fixed in v1.8.1.6 and
>above.
>
>If upgrading is too hard, I think you can work around it by putting
>"win_build/" instead of "win_build" in your .gitattributes (after
>v1.8.1.6, both should work for your case).
>
>-Peff
>=20
>
>=A0
