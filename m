From: Tom Tobin <korpios@korpios.com>
Subject: Re: On Tabs and Spaces
Date: Wed, 17 Oct 2007 13:25:09 -0500
Message-ID: <1192645509.6640.21.camel@athena>
References: <634393B0-734A-4884-93E3-42F7D3CB157F@mit.edu>
	 <471476B7.5050105@users.sourceforge.net>
	 <8c5c35580710160204s5a4f9fb3j68c0a86c4d080cb7@mail.gmail.com>
	 <47148F72.1090602@users.sourceforge.net>
	 <1192548367.3821.4.camel@lt21223.campus.dmacc.edu>
	 <B2F6DB0C-4EFE-4C56-8E7A-31820320CA02@mit.edu> <3awb7zw6.fsf@blue.sea.net>
	 <alpine.LFD.0.999.0710161214530.6887@woody.linux-foundation.org>
	 <1192565900.6430.16.camel@athena>
	 <alpine.LFD.0.999.0710161559150.6887@woody.linux-foundation.org>
	 <20071017015109.303760cc@localhost.localdomain>
	 <alpine.LFD.0.999.0710161722320.26902@woody.linux-foundation.org>
	 <3A9408D5-2667-43A6-A0CE-C0720B3A3987@vicaya.com>
	 <alpine.LFD.0.999.0710170849590.26902@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Oct 17 20:25:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiDaB-0007jK-Cb
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 20:25:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757120AbXJQSZQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Oct 2007 14:25:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756092AbXJQSZQ
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Oct 2007 14:25:16 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:47041 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758150AbXJQSZO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2007 14:25:14 -0400
Received: by py-out-1112.google.com with SMTP id u77so4478154pyb
        for <git@vger.kernel.org>; Wed, 17 Oct 2007 11:25:13 -0700 (PDT)
Received: by 10.35.14.18 with SMTP id r18mr10825442pyi.1192645512440;
        Wed, 17 Oct 2007 11:25:12 -0700 (PDT)
Received: from ?127.0.0.1? ( [208.75.86.189])
        by mx.google.com with ESMTPS id y64sm8500016pyg.2007.10.17.11.25.10
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 17 Oct 2007 11:25:11 -0700 (PDT)
In-Reply-To: <alpine.LFD.0.999.0710170849590.26902@woody.linux-foundation.org>
X-Mailer: Evolution 2.12.0 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61405>

On Wed, 2007-10-17 at 08:53 -0700, Linus Torvalds wrote:
>=20
> On Wed, 17 Oct 2007, Luke Lu wrote:
> >=20
> > Well, we just established that all-space is perfect, look-wise.
>=20
> But we also established that an all-space model is not stable, becaus=
e any=20
> unix developers will start adding tabs instead of spaces.

Damn unix developers!  They just can't be controlled!

=2E.. seriously now.  You're trying on one hand to enforce a particular
indentation rule (use tabs for indentations, assume tabs are 8
characters wide, use spaces for partial indentation) =E2=80=94 which as=
sumes
unix developers *can* follow a project's rules for coding style =E2=80=94=
 and
yet you're arguing *against* all-spaces because unix developers *can't*
follow rules.

Or is "unix developers" code for "my sample size of one"?

> > As I mentioned, an all-space policy is trivial to enforce.
>=20
> Hell no, it's not.
>=20
> More importantly, I can guarantee that certain developers will refuse=
 to=20
> be part of such a project with such an idiotic design that eats disk-=
space=20
> for no gain, and makes it impossible for me to use my normal editor.

Interesting how you waver between "certain developers" and "me".  I'm
convinced at this point that your argument comes down to "I can't use m=
y
favorite text editor with all-spaces, therefore all-spaces sucks".

As for *disk space*?  When we can measure cheap drives in sizable
fractions of *terabytes*, this simply isn't a serious argument.

> > But I still haven't seen any compelling arguments against the "all =
space"
> > case, other than "people will screw it up into mixed spaces", which=
 is really
> > a straw man, as many multi-platform projects enforced the all-space=
 policy
> > easily by using a pre-commit hook in maintainers' repository.
>=20
> Hey, you start your own projct, and you can enforce whatever idiotic =
rules=20
> you want to.=20

Yeah, can you believe some projects actually *survive* with an
all-spaces indentation rule?  And ::gasp:: even *thrive*?

> But in the meantime, all-tab indentations are equally good, and are t=
he=20
> defacto rule. So *you* are the one who should show compelling argumen=
ts=20
> for changing, and so far you haven't shown any.
>=20
> Really: what is the problem with hardtabs? Absolutely none.

Problems have been outlined, but since everything for you comes down to
"anything that comes between me and microemacs sucks", rational
discussion breaks down.

Thank goodness the git community (not to mention the Linux community!)
is larger than you; they exist in no small part due to your programming
skill and initial open-sourcing, but certainly in *spite* of your
personality otherwise.
