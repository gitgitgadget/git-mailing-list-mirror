From: Ian Ward Comfort <icomfort@stanford.edu>
Subject: Re: [PATCH] Put quotes around branch names to prevent special  characters from being interpreted by the shell.
Date: Sun, 6 Jun 2010 23:01:00 -0700
Message-ID: <EE9EE2D7-B15C-4858-A4C1-B045FD5AC6BA@stanford.edu>
References: <1275666800-31852-1-git-send-email-bmeyer@rim.com> <20100606215505.GB6993@coredump.intra.peff.net> <AANLkTinZc1jiBmTJRsJXDe7A4ZAe001zJIWILGKQ8YoA@mail.gmail.com> <AANLkTik7PV-2u24UF78U6rtuffw4XUGS1F4hD2_ElrZZ@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jay Soffian <jaysoffian@gmail.com>, Jeff King <peff@peff.net>,
	Benjamin C Meyer <bmeyer@rim.com>, git@vger.kernel.org
To: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 07 08:01:20 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLVOe-0008Ph-T0
	for gcvg-git-2@lo.gmane.org; Mon, 07 Jun 2010 08:01:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752802Ab0FGGBM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Jun 2010 02:01:12 -0400
Received: from smtp2.Stanford.EDU ([171.67.219.82]:44571 "EHLO
	smtp.stanford.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751737Ab0FGGBL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Jun 2010 02:01:11 -0400
Received: from smtp.stanford.edu (localhost.localdomain [127.0.0.1])
	by localhost (Postfix) with SMTP id 04B03170CA6;
	Sun,  6 Jun 2010 23:01:11 -0700 (PDT)
Received: from rescomp.stanford.edu (rescomp.Stanford.EDU [171.67.43.194])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.stanford.edu (Postfix) with ESMTPS id 76902170C9D;
	Sun,  6 Jun 2010 23:01:09 -0700 (PDT)
Received: from [192.168.1.108] (c-71-198-214-12.hsd1.ca.comcast.net [71.198.214.12])
	by rescomp.stanford.edu (Postfix) with ESMTP id 35A949E02;
	Sun,  6 Jun 2010 23:01:09 -0700 (PDT)
In-Reply-To: <AANLkTik7PV-2u24UF78U6rtuffw4XUGS1F4hD2_ElrZZ@mail.gmail.com>
X-Mailer: Apple Mail (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148574>

On 6 Jun 2010, at 10:48 PM, =C6var Arnfj=F6r=F0 Bjarmason wrote:
> On Mon, Jun 7, 2010 at 05:10, Jay Soffian <jaysoffian@gmail.com> =20
> wrote:
>> BTW, quotemeta is technically intended for use with regular =20
>> expressions, isn't it?
>
> Yes, it's completely insecure to use it for shell interpolation.
>
> In Perl it's best to use the list form of system() so that the =20
> command will escape things for you automatically.

Passing a list to system() actually ensures that Perl will call execvp =
=20
directly, instead of looking for metacharacters and possibly invoking =20
the system shell.  (But this is getting a little OT; sorry.)

--=20
Ian Ward Comfort <icomfort@stanford.edu>
Systems Team Lead, Academic Computing Services, Stanford University
