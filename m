From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 00/18] Sequencer for inclusion v4
Date: Thu, 28 Jul 2011 22:30:10 +0530
Message-ID: <CALkWK0n03qVpUbeG9jX+Sz+G9RgPYCR2s=pbEkdtBuBZzzWJyA@mail.gmail.com>
References: <1311871951-3497-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 28 19:00:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmTwq-0006RZ-Fw
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jul 2011 19:00:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755780Ab1G1RAc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Jul 2011 13:00:32 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:34377 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755738Ab1G1RAb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Jul 2011 13:00:31 -0400
Received: by wyg8 with SMTP id 8so289167wyg.19
        for <git@vger.kernel.org>; Thu, 28 Jul 2011 10:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=xmZoZ1Hmx2pSR/w4xBWONFDlhRHAViEeklvtnnqjAto=;
        b=UHyxa+vfB+xSp5gkhsbez5mWPnHsGn2zEjnVNHkiExMD17MK/CNd7Z68GFN9eJv9jF
         c6UXCHz4rCbxFeiZhuzoL+AmSGfdgHPl50dp0pOe5mzTZVNGyDTOBo7FYGwQdlgMZ7YR
         /ksBh2w/T6aE9+qPFdF56yZvtUQc3JtJQ5yaA=
Received: by 10.227.55.66 with SMTP id t2mr250421wbg.109.1311872430101; Thu,
 28 Jul 2011 10:00:30 -0700 (PDT)
Received: by 10.216.137.134 with HTTP; Thu, 28 Jul 2011 10:00:10 -0700 (PDT)
In-Reply-To: <1311871951-3497-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178097>

Hi again,

Ramkumar Ramachandra writes:
> There were more style nits pointed out in v3: I learnt my lesson and
> ran checkpatch.pl this time. =C2=A0Apart these minor stylistic change=
s, the
> other changes are:
> 1. Minor improvements to commit messages.
> 2. Tests now cleanup first, so one failing test doesn't take
> everything else down.
> 3. A rebase that moves "revert: Propogate errors upwards from
> do_pick_commit" to the end of the series. =C2=A0A big thanks to Jonat=
han
> for performing the rebase for me.

And one more significant change:

4. read_populate_todo, read_populate_opts and dependent functions were
moved to the "revert: Introduce --continue to continue the operation"
patch, eliminating the need for the ugly MAYBE_UNUSED.

-- Ram
