From: Scott Kyle <scott@appden.com>
Subject: Re: [PATCH] completion: Add PS1 configuration for submodules
Date: Tue, 7 Dec 2010 12:37:00 -0800
Message-ID: <AANLkTinuD2ze_mn5QMLqFaoftwZvTsz-DKv1ojAizg7P@mail.gmail.com>
References: <1291677763-55385-1-git-send-email-scott@appden.com> <AANLkTin8JstkjEWaCGZuqpEXZnLMyudFm24K7Y3iCgX6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 07 21:37:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQ4IN-0007rn-8W
	for gcvg-git-2@lo.gmane.org; Tue, 07 Dec 2010 21:37:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754905Ab0LGUh1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Dec 2010 15:37:27 -0500
Received: from mail-ey0-f171.google.com ([209.85.215.171]:46643 "EHLO
	mail-ey0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754896Ab0LGUhY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Dec 2010 15:37:24 -0500
X-Greylist: delayed 11788 seconds by postgrey-1.27 at vger.kernel.org; Tue, 07 Dec 2010 15:37:24 EST
Received: by eyg5 with SMTP id 5so397389eyg.2
        for <git@vger.kernel.org>; Tue, 07 Dec 2010 12:37:23 -0800 (PST)
Received: by 10.216.172.15 with SMTP id s15mr886181wel.70.1291754240477; Tue,
 07 Dec 2010 12:37:20 -0800 (PST)
Received: by 10.216.242.137 with HTTP; Tue, 7 Dec 2010 12:37:00 -0800 (PST)
In-Reply-To: <AANLkTin8JstkjEWaCGZuqpEXZnLMyudFm24K7Y3iCgX6@mail.gmail.com>
X-Google-Sender-Auth: NyOxvFUC2-7gsecfCVCEHhKhnNM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163126>

[sorry for the duplicate email, my original was rejected from the list]

On Tue, Dec 7, 2010 at 4:15 AM, =C6var Arnfj=F6r=F0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Tue, Dec 7, 2010 at 00:22, Scott Kyle <scott@appden.com> wrote:
> > For those who often work on repositories with submodules, the dirty
> > indicator for unstaged changes will almost always show because deve=
lopment
> > is simultaneously happening on those submodules. The config option
> > diff.ignoreSubmodules is not appropriate for this use because it ha=
s larger
> > implications.
>
> Wouldn't it be a lot better to instead add support for showing
> submodule dirtyness as distinct from the main tree's dirtyness? Then
> you could easily spot if you had either your tree / submodule tree
> changes, without just ignoring them.

I considered that, but thought it to be a rather disruptive change,
and one that conceptually didn't work.  The way I see it, either
somebody thinks of their repo as dirty when the submodules are dirty,
or not. And I think since this behavior has perpetuated for so long,
most users are content with how it currently works.  I, however, was
not, and so that is why I added an option for people like me.

Scott Kyle

http://appden.com
http://github.com/appden
http://twitter.com/appden
