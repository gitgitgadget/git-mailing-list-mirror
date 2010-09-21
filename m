From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 000/160] [PULL] Update ab/i18n (again)
Date: Tue, 21 Sep 2010 08:47:00 +0000
Message-ID: <AANLkTikr4=K1e2VFU4WkawjpvCp0MvqGk-Sqv5ixj8fm@mail.gmail.com>
References: <1285015029-23103-1-git-send-email-avarab@gmail.com>
	<4C985A47.3030101@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	=?UTF-8?Q?Jan_Kr=C3=BCger?= <jk@jk.gs>,
	Marcin Cieslak <saper@saper.info>,
	Peter Krefting <peter@softwolves.pp.se>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Sep 21 10:47:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxyVX-0005sD-VK
	for gcvg-git-2@lo.gmane.org; Tue, 21 Sep 2010 10:47:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756503Ab0IUIrF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Sep 2010 04:47:05 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:58024 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756714Ab0IUIrC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Sep 2010 04:47:02 -0400
Received: by iwn5 with SMTP id 5so4981857iwn.19
        for <git@vger.kernel.org>; Tue, 21 Sep 2010 01:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=CoPqQVTQKbH9u//M7Gr2Nx6Q/3WPxFjtGff2PQ0GHss=;
        b=EBGhl298x2hOXVr78wsNSp+ah/vBmN/QWkLU+rWvgG4CysT4d7SsNxDGYcMkHiZa7u
         sSCsvnOF6oCr3xMoYxpSbrMIHrjwrDJ7Rtg/TZnPV7c97rvn4Fkz7ZJSlFv0o7AyEH0j
         pmMMl8bKjr25h5r/DN7MykXOFPPvd9sMajxvE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Y/qHP2I/vcXh0UwAMWv4yAvbz8H08jtY/rGhE6HxQBF4k+NbKL/UIMqGyM1Q4N1Ma8
         B3u/6ajLMa1Xb8hqKav5xrQigZLKJDxtJHBAA1j0GM/uz0lwIbRMmo4OHk5EwYGIzM54
         gvTyrrSnH04WjCri9qGadgqQRPdMj39x4LyTM=
Received: by 10.231.16.204 with SMTP id p12mr8127408iba.194.1285058820906;
 Tue, 21 Sep 2010 01:47:00 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Tue, 21 Sep 2010 01:47:00 -0700 (PDT)
In-Reply-To: <4C985A47.3030101@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156697>

On Tue, Sep 21, 2010 at 07:09, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason venit, vidit, dixit 20.09.2010=
 22:37:
> Would it be possible to split the infrastructure part from the actual
> translations, i.e. have two or more dependent branches (which is
> probably easier than reordering on a single branch)?
>
> I know at least one locale where we're actually in the early stages o=
f a
> fundamental discussion about translation principles. Blocking the who=
le
> series because of that makes no sense.
>
> Also, the set of reviewers for infrastructure parts will be quite
> different from that for individual translations.

=46irstly I'm hoping this gets merged soon so this all becomes a
non-issue.

But having multiple branches would be harder for me, I used to have
three branches: infrastructure, gettextize and translations. Rebasing
all of those on top of each other and testing each of them was a PITA,
so I folded things back into one huge series.

But I don't think any of this is a problem for translators, they just
have to pull down any version of the series and start cracking at
"make pot && msginit ...". Maybe that POT file is *slightly* out of
date, but the translation strings themselves are really stable at this
point, so that's always going to be <1-2% of the translation that
needs to be fixed up & unfuzzied.

So just submit translations, maybe they'll make it as part of the
initial ab/i18n merge and maybe they won't.
