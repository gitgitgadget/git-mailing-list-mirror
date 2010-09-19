From: Russ Allbery <rra@debian.org>
Subject: Re: Make format-patch produce UTF-8 `From:' header
Date: Sun, 19 Sep 2010 12:19:00 -0700
Organization: The Eyrie
Message-ID: <87mxrda6e3.fsf@windlord.stanford.edu>
References: <AANLkTin_5qzDkMU_1stYZcJpfW-W7K0kxy=0K2dA7SwO@mail.gmail.com>
	<AANLkTinOa+s-28PYXHhtKr_POu2D33ibfgKDKk4Wqi=9@mail.gmail.com>
	<87y6axshmt.fsf_-_@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	"Stefan-W. Hahn" <stefan.hahn@s-hahn.de>,
	Lukas =?utf-8?Q?Sandstr=C3=B6m?= <luksan@gmail.com>,
	Jeff King <peff@peff.net>,
	Christian Himpel <chressie@googlemail.com>
To: =?utf-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 19 21:19:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxPPr-0008NR-UY
	for gcvg-git-2@lo.gmane.org; Sun, 19 Sep 2010 21:19:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753649Ab0ISTTE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 19 Sep 2010 15:19:04 -0400
Received: from smtp4.Stanford.EDU ([171.67.219.84]:43135 "EHLO
	smtp.stanford.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752207Ab0ISTTD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Sep 2010 15:19:03 -0400
Received: from smtp.stanford.edu (localhost.localdomain [127.0.0.1])
	by localhost (Postfix) with SMTP id 6D53CCAFF;
	Sun, 19 Sep 2010 12:19:02 -0700 (PDT)
Received: from windlord.stanford.edu (windlord.Stanford.EDU [171.67.225.134])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.stanford.edu (Postfix) with ESMTPS id A8D7DC984;
	Sun, 19 Sep 2010 12:19:00 -0700 (PDT)
Received: by windlord.stanford.edu (Postfix, from userid 1000)
	id 904802F5AB; Sun, 19 Sep 2010 12:19:00 -0700 (PDT)
In-Reply-To: <87y6axshmt.fsf_-_@gmail.com> (=?utf-8?B?IsWgdMSbcMOhbiBOxJtt?=
 =?utf-8?B?ZWMiJ3M=?= message of "Sun,
	19 Sep 2010 20:38:50 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156511>

=C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec <stepnem@gmail.com> writes:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> Maybe format-patch could provide another mode to produce patches tha=
t
>> do not include unnecessary headers (in particular, leaving out the
>> difficult "From " line and using UTF-8 instead of quoted-printable f=
or
>> the "From: " line).

> FWIW, the quoted-printable `From:' encoding has always annoyed me -- =
I
> replace it manually with my name & address in UTF-8 every time I send
> out a patch. What is the reason format-patch does that (and if there =
is
> a reason not to change the default, could an option to disable it be
> provided)?

Well, it's required if you're going to actually send the result directl=
y
as a mail message, since the RFC 5322 format requires headers be encode=
d
using RFC 2047 encoding.  But if you're just attaching the patch to
another mail message, it's pointless.

--=20
Russ Allbery (rra@debian.org)               <http://www.eyrie.org/~eagl=
e/>
