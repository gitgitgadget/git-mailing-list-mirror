From: Kevin Ballard <kevin@sb.org>
Subject: Re: [PATCH] completion: Add PS1 configuration for submodules
Date: Tue, 7 Dec 2010 12:31:40 -0800
Message-ID: <0E479F18-B26A-4216-A71E-C65EAB41A74A@sb.org>
References: <1291677763-55385-1-git-send-email-scott@appden.com> <AANLkTin8JstkjEWaCGZuqpEXZnLMyudFm24K7Y3iCgX6@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Scott Kyle <scott@appden.com>, git@vger.kernel.org
To: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 07 21:40:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQ4KW-0000Xr-JT
	for gcvg-git-2@lo.gmane.org; Tue, 07 Dec 2010 21:40:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754713Ab0LGUjo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Dec 2010 15:39:44 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:35130 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753164Ab0LGUjm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Dec 2010 15:39:42 -0500
Received: by pwj3 with SMTP id 3so110990pwj.19
        for <git@vger.kernel.org>; Tue, 07 Dec 2010 12:39:41 -0800 (PST)
Received: by 10.142.232.12 with SMTP id e12mr1436442wfh.177.1291753905063;
        Tue, 07 Dec 2010 12:31:45 -0800 (PST)
Received: from [10.8.0.89] ([69.170.160.74])
        by mx.google.com with ESMTPS id q13sm9408271wfc.5.2010.12.07.12.31.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 07 Dec 2010 12:31:44 -0800 (PST)
In-Reply-To: <AANLkTin8JstkjEWaCGZuqpEXZnLMyudFm24K7Y3iCgX6@mail.gmail.com>
X-Mailer: Apple Mail (2.1082)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163127>

On Dec 7, 2010, at 4:15 AM, =C6var Arnfj=F6r=F0 Bjarmason wrote:

> On Tue, Dec 7, 2010 at 00:22, Scott Kyle <scott@appden.com> wrote:
>> For those who often work on repositories with submodules, the dirty
>> indicator for unstaged changes will almost always show because devel=
opment
>> is simultaneously happening on those submodules. The config option
>> diff.ignoreSubmodules is not appropriate for this use because it has=
 larger
>> implications.
>=20
> Wouldn't it be a lot better to instead add support for showing
> submodule dirtyness as distinct from the main tree's dirtyness? Then
> you could easily spot if you had either your tree / submodule tree
> changes, without just ignoring them.

That sounds like a good idea, but it doesn't necessarily have to come w=
ith
this patch. Scott's use case here is he has a submodule that is _always=
_ dirty,
and he simply doesn't want to see that stuff in the PS1. Having an opti=
on to
show it separately would be very useful for me, but should perhaps be w=
ritten
as a separate patch.

-Kevin Ballard