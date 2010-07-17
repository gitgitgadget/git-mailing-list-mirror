From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Challenge with Git-Bash
Date: Sat, 17 Jul 2010 16:36:30 +0000
Message-ID: <AANLkTinKt2Mbsw4SbTCjbTOuzOpzYEBjQsGGh2Fq67Bo@mail.gmail.com>
References: <001d01cb25cb$eb176980$c1463c80$@net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Rainer Lauer <lauerr@gmx.net>
X-From: git-owner@vger.kernel.org Sat Jul 17 18:36:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OaANb-00073b-34
	for gcvg-git-2@lo.gmane.org; Sat, 17 Jul 2010 18:36:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756231Ab0GQQgc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Jul 2010 12:36:32 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:63341 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756077Ab0GQQgc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Jul 2010 12:36:32 -0400
Received: by iwn7 with SMTP id 7so3160086iwn.19
        for <git@vger.kernel.org>; Sat, 17 Jul 2010 09:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=8MOcNfax3qqImBiDBSzqDox5ouRVN0AyMWPvM9bskig=;
        b=UgwoqXmamh44tQ+h4aCTHMd4s+x8iavsU7u8pqRssSd/o8pKLoO5L2A9ujRjR0ef7m
         Jhqy/J0v6MfxE2HE1NuhVTVwJQsOwWWx6AM58pC+vrOXW2PmBlrQn0lCeq9JcMYImRM1
         o1f83kkvxr0IaDxnxYlevUMkbxYOMUatLygA8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=a+YXVohCBg33TsdSz+z5m17f/V36teiDdd4oeJnj0qGK8PbfxFLaL7GIfGCRWD7Q3J
         ia9WBa/+2QVu/AOXPmZc6T+U2/Wg6JRK5GVXmKUVyaeduTK6e/F0A/ekunRgoCvKqbld
         L9fPHuYFjTfabtRvSG9z+nyxNiF0sQRAldC7I=
Received: by 10.231.145.1 with SMTP id b1mr2784154ibv.69.1279384590435; Sat, 
	17 Jul 2010 09:36:30 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Sat, 17 Jul 2010 09:36:30 -0700 (PDT)
In-Reply-To: <001d01cb25cb$eb176980$c1463c80$@net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151194>

On Sat, Jul 17, 2010 at 16:20, Rainer Lauer <lauerr@gmx.net> wrote:
> Hello,
> with my Windows 7 Git-Installation I get following challenge:
> 1) =C2=A0 =C2=A0 =C2=A0Set GIT_EDITOR to editor of your choice
> 2) =C2=A0 =C2=A0 =C2=A0With Windows7 let this editor run in admin-mod=
e
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Goto .exe-file -> right mouse-click -> com=
patibility -> run program
> as admin (I'm running a German version maybe English names are slight=
ly
> different)
> 3) =C2=A0 =C2=A0 =C2=A0Make a git action like git add file
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git commit
> =C2=A0 =C2=A0 =C2=A0 =C2=A0from the git bash.
> 4) =C2=A0 =C2=A0 =C2=A0Now following message appears: =C2=A0sh.exe: .=
/"editor of your choice":
> Bad file number
> Everything is fine without Admin-Mode set for editor. In other words =
if you
> get rid of step 2) step 4) doesn't appear instead the editor starts.
> Due to other tasks my editor of choice has to run in this mode - stup=
id
> enough.
>
> Any chance to get around this problem?
> (No not taking a different editor, no not getting rid of admin mode :=
) )

Did you actually set "GIT_EDITOR" to the string "editor of your
choice", as opposed to the full path to Emacs, notepad or something
like that?
