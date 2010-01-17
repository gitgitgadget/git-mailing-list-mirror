From: Michael Wookey <michaelwookey@gmail.com>
Subject: Re: [PATCH] git status: display current branch name in color
Date: Sun, 17 Jan 2010 15:31:07 +1100
Message-ID: <d2e97e801001162031n1dab2301k5a839846b3cc5d9d@mail.gmail.com>
References: <d2e97e801001141823i7519864dy264488d36fca465c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 17 05:42:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWMyI-00019T-4J
	for gcvg-git-2@lo.gmane.org; Sun, 17 Jan 2010 05:42:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753384Ab0AQEjj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 16 Jan 2010 23:39:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753374Ab0AQEjj
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jan 2010 23:39:39 -0500
Received: from mail-pz0-f190.google.com ([209.85.222.190]:34608 "EHLO
	mail-pz0-f190.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753334Ab0AQEjj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Jan 2010 23:39:39 -0500
X-Greylist: delayed 491 seconds by postgrey-1.27 at vger.kernel.org; Sat, 16 Jan 2010 23:39:38 EST
Received: by pzk28 with SMTP id 28so926745pzk.4
        for <git@vger.kernel.org>; Sat, 16 Jan 2010 20:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        bh=jd8lUbSAUrwJJSLP8xA34slqohb55vj7wjlAWmrXZgY=;
        b=fFIGGWsPAKr32kJ5kJz0zDUYmjekn3UUuMro4GiG4jAIKY3N1gmnOkSDgDU7VRViB/
         8NcSJwJ5EKuKxM6s+e0YdzMIkh/y5ArGocAFI6Vb2ZKlDO8f7d2XkV+NMXQo0l8ulcK3
         nceDOLrOQcxrZZLUxf16TAgzecL+pqwl1SKSk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        b=ee+8AE7HqB0W6y2jiKHhRvuwVRQLBnJTFBENnKEp/DOYRb4pBysKj6vgSiKDsTnhra
         cr/tBGwjuD2B3UmZxDY/WoJj0JH0QevMvHst1izf/mF1j/cPyrv4GR3/A0mKBHQUSN7O
         2Szz4J0Up/GUXR4/0EgHCW7gk9j6Msd8Zzx+Y=
Received: by 10.115.64.16 with SMTP id r16mr2994145wak.224.1263702687101; Sat, 
	16 Jan 2010 20:31:27 -0800 (PST)
In-Reply-To: <d2e97e801001141823i7519864dy264488d36fca465c@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137273>

> There is an existing highlight when the user is not on any branch.
> Enhance this functionality to always provide the name of the current
> branch in color.
>
> Signed-off-by: Michael Wookey <michaelwookey@gmail.com>
> ---
> =C2=A0wt-status.c | =C2=A0 10 ++++++----
> =C2=A0wt-status.h | =C2=A0 =C2=A03 ++-
> =C2=A02 files changed, 8 insertions(+), 5 deletions(-)

Any thoughts on this?

I have found this to be a useful feature; especially when using
msysGit in a Windows CMD shell. Specifically because a CMD shell
provides no ability for any sort of "git-completion.bash" prompt. By
highlighting the current branch name, the colouring has helped to
quickly identify what the current branch is.
