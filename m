From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] git-rebase--interactive.sh: Add new command "shell"
Date: Thu, 4 Nov 2010 11:40:19 +0100
Message-ID: <AANLkTikbrab3kmDqTCLo_tPeZWm_c-5Yux0FnVmwQE85@mail.gmail.com>
References: <9C0BAFB4-299E-459B-A64A-54D480C5445D@sb.org> <20101104112530.5c0e444a@chalon.bertin.fr>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: kevin@sb.org, git@vger.kernel.org
To: Yann Dirson <dirson@bertin.fr>
X-From: git-owner@vger.kernel.org Thu Nov 04 11:40:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDxFO-00013P-Ve
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 11:40:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754267Ab0KDKkm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Nov 2010 06:40:42 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:65052 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754108Ab0KDKkl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Nov 2010 06:40:41 -0400
Received: by fxm16 with SMTP id 16so1297880fxm.19
        for <git@vger.kernel.org>; Thu, 04 Nov 2010 03:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=okZK5srSIqDboZbjMXJeM1Ii8xTelMl8GmgzsV/1YrU=;
        b=DPmKpJcKVOROhjQhIUCkKjdeaEXiJW1s6Fj20oLDbjXnII80cX8ltpVDHP7r2wDHKW
         BoO1cFBmOMgHicCzag/HCY1v7MUdkwj4g5v2BnZ5Rq8iJ/njEvBrbIWfZ2kTySV1Hm/j
         qyF+1C+aQjNPVtwiKX11eZJWjDlngmW9SVIJI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=HMJiKaO+nhl0ce7bRkEAfi3NahhKYn0XEV3ILCiTqOdSbYOsDNCMFZXpXvcuLL7K4B
         ElKAKUYsZZJTmj0EvMlFO8IWGL6uxsRiPM8Nid7DCqVTanzbV8JJLKsWBfLNgbKh5mzw
         7RlpNVpJ6pdtNXcrum5zVIEqC0MjJwJu2zuSY=
Received: by 10.223.89.142 with SMTP id e14mr475160fam.143.1288867239997; Thu,
 04 Nov 2010 03:40:39 -0700 (PDT)
Received: by 10.223.108.73 with HTTP; Thu, 4 Nov 2010 03:40:19 -0700 (PDT)
In-Reply-To: <20101104112530.5c0e444a@chalon.bertin.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160714>

On Thu, Nov 4, 2010 at 11:25 AM, Yann Dirson <dirson@bertin.fr> wrote:
>>> I'm sorry if I'm missing something, but how is this different from
>>> "edit"?
>>
>>Edit cherry-picks a commit, then exits to the shell. I needed to exit
>>to the shell without cherry-picking a commit.
>

Then you do "edit" on the preceding commit instead, no?

> Indeed, before "x false" was available, I had found out that "edit"
> without an argument fails with a harmless error and indeed achieves t=
hat
> "pause" mechanism which was really missing.
>
> What about just fixing this so we can use "edit" ? =A0Do we really ne=
ed
> another command here ?
>

Having an parameter-less "edit" would indeed be a bit more convenient.
