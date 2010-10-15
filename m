From: Kevin Ballard <kevin@sb.org>
Subject: Re: Manual hunk edit mode + emacs + ^G == garbage
Date: Fri, 15 Oct 2010 02:13:55 -0700
Message-ID: <EDCC7CB3-4DFF-45B8-9E23-E12045CC29D7@sb.org>
References: <39CB17A9-2717-491B-8E01-F3E855F90649@sb.org> <AANLkTimM92SdY_+v5JcOx2kYbDKBJJzBofFm0FLF_S6K@mail.gmail.com> <buomxqhayqc.fsf@dhlpc061.dev.necel.com>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Fri Oct 15 11:14:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6gMq-0000Tm-Fo
	for gcvg-git-2@lo.gmane.org; Fri, 15 Oct 2010 11:14:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754864Ab0JOJN7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Oct 2010 05:13:59 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:34791 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754492Ab0JOJN6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Oct 2010 05:13:58 -0400
Received: by iwn35 with SMTP id 35so693068iwn.19
        for <git@vger.kernel.org>; Fri, 15 Oct 2010 02:13:58 -0700 (PDT)
Received: by 10.231.58.201 with SMTP id i9mr326294ibh.98.1287134038266;
        Fri, 15 Oct 2010 02:13:58 -0700 (PDT)
Received: from [10.0.1.14] ([24.130.32.253])
        by mx.google.com with ESMTPS id d40sm10589640ibc.7.2010.10.15.02.13.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 15 Oct 2010 02:13:57 -0700 (PDT)
In-Reply-To: <buomxqhayqc.fsf@dhlpc061.dev.necel.com>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159108>

On Oct 14, 2010, at 2:51 AM, Miles Bader wrote:

> =C6var Arnfj=F6r=F0 Bjarmason <avarab@gmail.com> writes:
>>> I've been having a rather strange problem using manual hunk edit mo=
de (`git add -p`, e)
>>=20
>> Aside from this bug you might want to check out magit.el, it's a muc=
h
>> nicer hunk edit more for Emacs than running git add -p in an Emacs
>> terminal is.
>=20
> Yup, for that particular problem, magit is, well, like magic :)

I tested out magit, and didn't particularly like it. First off, it seem=
s to be throwing an error when I invoke magit-status, at least if there=
's no changes. I don't know if this is related to the fact that my emac=
s is only 22.1, but magit itself doesn't document any required version =
of emacs. Secondly, when there is a change, the coloration is really ha=
rd to read, and the navigation is quite poor as well (and I didn't find=
 anything to make it better in the cheatsheet). And it's far slower tha=
n just using `git add -p` and only dropping into emacs occasionally for=
 manual hunk edits.

I'm still very much interested in finding a solution to why ^G kills em=
acs when it's invoked by git. As I said earlier, it appears that emacs =
shares the same process group with the perl process that called it, eve=
n though Andreas Schwab says it puts itself into its own process group =
and invoking emacs from the shell does just that. Does anyone know why =
this might be happening?

-Kevin Ballard