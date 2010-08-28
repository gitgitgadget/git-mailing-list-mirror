From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Does changing filename case breaks git's rename heuristic?
Date: Sat, 28 Aug 2010 10:39:40 +0000
Message-ID: <AANLkTi=89_QvzNf44OLL6K9-5uG6WLrMtHsA9cbmrCt1@mail.gmail.com>
References: <AANLkTinxvj85Jzb-ykK0=MmRHkz8aQzmVxexC8H+Xgno@mail.gmail.com>
	<4C777090.2000107@drmicha.warpmail.net>
	<AANLkTikN_PbNNH2f4zWuk1FH+LgpKzkoZ6mYOdT9ANBj@mail.gmail.com>
	<4C77DDDC.8070407@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Dan Loewenherz <dloewenherz@gmail.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sat Aug 28 12:39:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OpIpH-0004F2-67
	for gcvg-git-2@lo.gmane.org; Sat, 28 Aug 2010 12:39:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752655Ab0H1Kjv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Aug 2010 06:39:51 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:44995 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752095Ab0H1Kju (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Aug 2010 06:39:50 -0400
Received: by iwn5 with SMTP id 5so3402441iwn.19
        for <git@vger.kernel.org>; Sat, 28 Aug 2010 03:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=u4rT8fSIDA2RwY2Wcs0Mgh4PvumXtZhZ9hhNbSkksFU=;
        b=wulCaZiUotKa1If4lf/xQZIJQ3cDJT+7M0qemOkd5v22+p0VghtiMlsl2FtbRgGvqg
         KrEVrh84ekd6hHInpeHKliLcV6sRTZauLZnSb6Lxk+uXbHth6OIf6OSAU6E0SfAjWhcV
         ncCcBWuOlrlqzipYGDb6qbU1Rwqhj8Lq1SYUw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=E/i9PNEkfT+rv8gGpdYGO/Znl8l9hej0Pzbpf5LA4n+1ELStiDiiVU6y5565Q6q9Ki
         MI2H28V5WVPpK67inheepWzeK0gMQLHM9idka8xpkMoKj5neH9g6t9671cmOFX1r3goC
         8tNQBDYxl9QWVLJWXVTwjb6CMkKiuVev0177s=
Received: by 10.231.183.67 with SMTP id cf3mr2499503ibb.187.1282991980364;
 Sat, 28 Aug 2010 03:39:40 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Sat, 28 Aug 2010 03:39:40 -0700 (PDT)
In-Reply-To: <4C77DDDC.8070407@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154640>

On Fri, Aug 27, 2010 at 15:46, Michael J Gruber
<git@drmicha.warpmail.net> wrote:

> The journalling is no problem, but HFS is. I'm no Macxpert but if I
> remember correctly, then under HFS "readme" and "README" are the same
> file, i.e. HFS only remembers how you want it spelled. People will
> correct me where I'm wrong.

FWIW this is called "case preserving". Where the filesystem is
case-insensitive so that you can't create both "foo" and "FOO", but it
still remembers if you did "touch Foo", "touch FoO" or whatever.

It affects more filesystems than just HFS.
