From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 3/3] t4033-diff-patience: factor out tests
Date: Wed, 6 Jul 2011 12:59:09 +0530
Message-ID: <CALkWK0=qO4NOfK0x044Hd+dM5pY8-EMrBrk_Tkia=fpYDzkyig@mail.gmail.com>
References: <1309932945-5048-1-git-send-email-rctay89@gmail.com>
 <1309932945-5048-2-git-send-email-rctay89@gmail.com> <1309932945-5048-3-git-send-email-rctay89@gmail.com>
 <1309932945-5048-4-git-send-email-rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 06 09:29:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QeMYC-00047F-4V
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jul 2011 09:29:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751591Ab1GFH3b convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Jul 2011 03:29:31 -0400
Received: from mail-ww0-f42.google.com ([74.125.82.42]:52625 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751299Ab1GFH3a convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Jul 2011 03:29:30 -0400
Received: by wwg11 with SMTP id 11so2898903wwg.1
        for <git@vger.kernel.org>; Wed, 06 Jul 2011 00:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=qNiFHt8zTS8PwNmdXk6aXkcNcEE3480cFV+PZv+rUjY=;
        b=oxt5xgKuru9NxhC08aKAZcE4GWbyz2ubpzctWyKUEQIPO0JddEJiTzJoNAfvb8YqbG
         2GQspxtF+DoCfgVK7UejYGSDoOl+c67gR9/UbpXPVSvv6OJKG+FMEEM+Ldtwyx0DnV2U
         9A9yOYAZA4E9NXuDgJh7SFOZOOatnn6kIbsdk=
Received: by 10.216.187.65 with SMTP id x43mr5651246wem.62.1309937369124; Wed,
 06 Jul 2011 00:29:29 -0700 (PDT)
Received: by 10.216.175.198 with HTTP; Wed, 6 Jul 2011 00:29:09 -0700 (PDT)
In-Reply-To: <1309932945-5048-4-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176645>

Hi Tay,

Tay Ray Chuan writes:
> ---

Submitting RFC patches without commit messages is alright I think, but
a missing signoff won't even permit anyone else to pick up this up and
work on it.  Please sign-off on everything.

> =C2=A0t/lib-diff-patience.sh =C2=A0 | =C2=A0162 +++++++++++++++++++++=
+++++++++++++++++++++++++
> =C2=A0t/t4033-diff-patience.sh | =C2=A0162 +-------------------------=
--------------------
> =C2=A02 files changed, 165 insertions(+), 159 deletions(-)
> =C2=A0create mode 100644 t/lib-diff-patience.sh

Maybe separate this out into two patches: one that renames the file,
and another that makes the minor changes so that it's easy to review?

-- Ram
