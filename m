From: Andreas Ericsson <ae@op5.se>
Subject: Re: libgit2 - a true git library
Date: Sun, 09 Nov 2008 11:17:14 +0100
Message-ID: <4916B8AA.2080602@op5.se>
References: <20081031170704.GU14786@spearce.org> <4915939B.1070306@gmail.com> <4915A3CB.5010909@op5.se> <20081108172759.GA31655@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-15?Q?Steve_Fr=E9cinaux?= <nudrema@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Scott Chacon <schacon@gmail.com>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Sun Nov 09 11:18:54 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kz7Na-00038G-Ca
	for gcvg-git-2@gmane.org; Sun, 09 Nov 2008 11:18:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754136AbYKIKRe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Nov 2008 05:17:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753980AbYKIKRe
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Nov 2008 05:17:34 -0500
Received: from mail.op5.se ([193.201.96.20]:44018 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753876AbYKIKRd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Nov 2008 05:17:33 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id CB64B1B8037F;
	Sun,  9 Nov 2008 11:11:27 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uRI3CDLX3kPg; Sun,  9 Nov 2008 11:11:25 +0100 (CET)
Received: from clix.int.op5.se (unknown [172.27.78.10])
	by mail.op5.se (Postfix) with ESMTP id 8F8331B8005E;
	Sun,  9 Nov 2008 11:11:21 +0100 (CET)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <20081108172759.GA31655@artemis.corp>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100437>

Pierre Habouzit wrote:
> On Sat, Nov 08, 2008 at 02:35:55PM +0000, Andreas Ericsson wrote:
>> Steve Fr=E9cinaux wrote:
>>> Just a random question: is there a reason why you have put all the
>>> .h in a separate includes/ directory instead of relying on the
>>> install target to put the include files at the right place ?
>>> To me it makes it much harder to hack on the files as one is always
>>> required to switch between both directories...
>> I agree with this, but as I guess Shawn will do roughly 45 times mor=
e
>> work on it than me (according to current commit-count in git.git), I=
'll
>> live with it.
>=20
> I don't, modifying the public includes may break the ABI and the API.
>=20
> I believe it to be a good practice to put them in a separate director=
y
> so that people modifying them will know this particular header is
> public. Yes you can name your private headers differently, but it's n=
ot
> really the same, it doesn't make editing public headers hard, and it =
has
> to. People modifying them _have_ to thing "err why am I modifying thi=
s
> specific header in the first place" before doing anything in it.
>=20

Well, I suggested putting "src/public/public_header.h" quite early on,
with private headers next to the source. AFAIU, the private and public
headers both are now located in the same directory, and that directory =
is
separate from the .c files.

--=20
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
