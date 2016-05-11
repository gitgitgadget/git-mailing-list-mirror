From: Geoff Nixon <geoff@geoff.codes>
Subject: =?UTF-8?Q?Re:_Bug:_`git-filter-branch_=E2=88=92=E2=88=92subdire?=
 =?UTF-8?Q?ctory=E2=88=92filter`_fails_on_Darwin,_others=3F?=
Date: Wed, 11 May 2016 07:47:52 -0700
Message-ID: <154a049cf1d.12555f552239176.4375238071436036595@geoff.codes>
References: <154a01265c2.c271895e226206.8641058706319152212@geoff.codes> <20160511140802.GA20134@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 11 16:48:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0VQf-0002He-Rz
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 16:48:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752585AbcEKOr4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 May 2016 10:47:56 -0400
Received: from sender163-mail.zoho.com ([74.201.84.163]:24560 "EHLO
	sender163-mail.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752560AbcEKOrz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 May 2016 10:47:55 -0400
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 146297807241116.065856447151305; Wed, 11 May 2016 07:47:52 -0700 (PDT)
In-Reply-To: <20160511140802.GA20134@sigill.intra.peff.net>
X-Priority: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294347>




 ---- On Wed, 11 May 2016 07:08:02 -0700 Jeff King <peff@peff.net> wrot=
e ----=20
 > On Wed, May 11, 2016 at 06:47:20AM -0700, Geoff Nixon wrote:=20
 > =20
 > >    the last line before it fails appears to be=20
 > >     `git rev-parse --no-flags --revs-only --symbolic-full-name=20
 > >     --default HEAD=20
 \210\222 \210\222subdirectory \210\222filter`=20
 > >     (including the octal sequences and bad-unicode character, thos=
e=20
 > >     are not email artifacts)=20
 > =20
 > Are you sure that you are invoking filter-branch with regular ascii=20
 > dashes, and not Unicode "minus-sign" (U+2212)?=20
 > =20
 > I seem to recall this coming up once before related to OS X, but I c=
an't=20
 > seem to find it in the archive. And I don't recall if it was related=
 to=20
 > the terminal, a keyboard setting, or something else.=20

That was it. I'm an idiot.

I sometimes use `man -t` to generate postscript for lengthy man pages s=
o I can "page through" outside my terminal.
It appears that for reasons unknown this converts all "-"s to "=E2=88=92=
"s. I must have copy-pasted the example.
Then I kept using my shell history completion, never typing it out agai=
n.

Sorry for wasting your time, thanks for helping me figure this out.

-Geoff

 > =20
 > -Peff=20
 >
