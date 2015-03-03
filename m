From: Shawn Pearce <spearce@spearce.org>
Subject: Re: An interesting opinion on DVCS/git
Date: Tue, 3 Mar 2015 14:49:43 -0800
Message-ID: <CAJo=hJuKL3akaG3Xh8mH5iij_dAdMkBW8fQgvreOsUHV517gpw@mail.gmail.com>
References: <54F2CD12.8050609@gmail.com> <CAGZ79kZ8CrjwVh3+OHSV1tv+fRXaDZ_diOO5E7QnSLZ=HTFSfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Mar 03 23:50:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSvdl-000667-Cw
	for gcvg-git-2@plane.gmane.org; Tue, 03 Mar 2015 23:50:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756552AbbCCWuF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Mar 2015 17:50:05 -0500
Received: from mail-yk0-f179.google.com ([209.85.160.179]:38281 "EHLO
	mail-yk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756031AbbCCWuE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Mar 2015 17:50:04 -0500
Received: by ykp9 with SMTP id 9so18250932ykp.5
        for <git@vger.kernel.org>; Tue, 03 Mar 2015 14:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=C17yDu4Vbi5it0Y+3vrHxIgQ3lXmVS94AhFMkhgqjPA=;
        b=C5Z2O03swGTc5Od+n2Yg4PGDGGP4ycDWC11YC1HwcHH3USSCgDdMQWYa5ICdoYNL9f
         qO2FMXqkRNuJs77aOJ+uaeMwH/hsakESClBXzLewD6DNi1FO+Z+ZIVYuEarA8neSvk7M
         UshPMTOoTui0f8pgD8RmF6an31oLxzDJrKSl8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=C17yDu4Vbi5it0Y+3vrHxIgQ3lXmVS94AhFMkhgqjPA=;
        b=B9nFokJVJ/m+ZH+Xmc6sRCPnEq2uzjVzvSwYBDBeydLTxs7J8WAVSttfcQNjmhVl0y
         aGa9slOztPnVI81hyqQfF/j2rb7WNVWH9mekfo5S5XxEECQZFXeSmzvkLO70pOWP5P2T
         vXRr6V26qPYjWYfMtEOFNAlpcblLVAxw5sAisgcRGQhrb+KbSrg1V2qFsTVbBLt3svRs
         1Owo1VicEU1M1KfJ0gSPNve5RkDzSsXMJWRvTb5w8P/3bcmligUqKcsOgiPP1ZeKlzMH
         Fy55CgLFCYR0GokP3OvfxWPx7/fdp3+E/sE+wiEpRkvJvU2CxALYrZWJ/tNaGfCuYzCV
         OJWw==
X-Gm-Message-State: ALoCoQlVJtNAfarnFgNEYCfGzvuPTNbdadteMCcmIrMaOv6Lznv5aykZwmL1eQ+KGIHwMIZEH0QN
X-Received: by 10.236.228.34 with SMTP id e32mr744658yhq.33.1425423003756;
 Tue, 03 Mar 2015 14:50:03 -0800 (PST)
Received: by 10.170.39.19 with HTTP; Tue, 3 Mar 2015 14:49:43 -0800 (PST)
In-Reply-To: <CAGZ79kZ8CrjwVh3+OHSV1tv+fRXaDZ_diOO5E7QnSLZ=HTFSfg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264701>

On Sun, Mar 1, 2015 at 7:29 PM, Stefan Beller <sbeller@google.com> wrot=
e:
> bitquabit.com/post/unorthodocs-abandon-your-dvcs-and-return-to-sanity

Indeed, a DVCS like Git or Hg does not fit everyone. And neither do
centralized systems like Subversion. Choice is good.

However... I found some passages troubling for Git, e.g.:

---snip---
Git is so amazingly simple to use that APress, a single publisher,
needs to have three different books on how to use it. It=E2=80=99s so s=
imple
that Atlassian and GitHub both felt a need to write their own online
tutorials to try to clarify the main Git tutorial on the actual Git
website. It=E2=80=99s so transparent that developers routinely tell me =
that
the easiest way to learn Git is to start with its file formats and
work up to the commands.
---snap---

We have heard this sort of feedback for years. But we have been unable
to adequately write our own documentation or clean up our man pages to
be useful to the average person who doesn't know why the --no-frobbing
option doesn't disable the --frobinator option to the
--frobbing-subcommand of git frob.  :(

http://git-man-page-generator.lokaltog.net/ shouldn't exist and
shouldn't be funny. Yet it does. :(
