From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] Fix a typo in line 117 of git-gui/lib/sshkeys.tcl.
Date: Mon, 31 Oct 2011 00:57:29 +0100
Message-ID: <CABPQNSaLsS9P8hWMEBYVe4FEo5x11+J+pMw29NN+EF2siCO35w@mail.gmail.com>
References: <1319995124-7509-1-git-send-email-dejan.ribic@gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git ML <git@vger.kernel.org>
To: =?ISO-8859-2?Q?Dejan_Ribi=E8?= <dejan.ribic@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 31 00:58:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RKfGd-0001lq-KV
	for gcvg-git-2@lo.gmane.org; Mon, 31 Oct 2011 00:58:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753070Ab1J3X6L convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Oct 2011 19:58:11 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:38559 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751072Ab1J3X6K convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 Oct 2011 19:58:10 -0400
Received: by pzk36 with SMTP id 36so16803545pzk.1
        for <git@vger.kernel.org>; Sun, 30 Oct 2011 16:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=th++y45tvQMbuEKNtCkOoDTxCDmZPSees1bsuu2Uy/E=;
        b=wizGNfy/Y8ObI/FcS63rBCP9nGPotrXolDC4GwQ2deiL2szVUdLrYlfdzWAkL55YbA
         gpQ5s8fpuiO4PTKn71iW8h+HNGKF9U4iTvnsuXFfC9Nh5HRz+JPWAlmNAUtMP/281oX0
         GuT9rF/4H12mBAwrSX0uzT+2qNhj698gDoL+o=
Received: by 10.68.38.8 with SMTP id c8mr19232488pbk.42.1320019090053; Sun, 30
 Oct 2011 16:58:10 -0700 (PDT)
Received: by 10.68.71.135 with HTTP; Sun, 30 Oct 2011 16:57:29 -0700 (PDT)
In-Reply-To: <1319995124-7509-1-git-send-email-dejan.ribic@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184489>

Thanks for re-posting inline and with a sign-off. But there's still a
few minor nits:

2011/10/30 Dejan Ribi=C4=8D <dejan.ribic@gmail.com>:
> "succeded" changed to "succeeded".

We write commit messages in imperative mood, so this should be
something like 'change "succeded" to "succeeded"' instead. This is
documented in Documentation/SubmittingPatches.

> modified: =C2=A0 git-gui/lib/sshkey.tcl

We don't normally include a list of changed files in the commit
message; the diffstat already provides that information.
