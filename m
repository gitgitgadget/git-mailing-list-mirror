From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 00/21] Support multiple worktrees
Date: Sun, 15 Dec 2013 09:29:05 +0700
Message-ID: <CACsJy8C4FXbR7JtUiRLH=PuDDR8CLzwMeADR6u8JzFEOOj43AA@mail.gmail.com>
References: <1386771333-32574-1-git-send-email-pclouds@gmail.com> <1387018507-21999-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Niedier <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Dec 15 03:29:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vs1Se-00085N-M1
	for gcvg-git-2@plane.gmane.org; Sun, 15 Dec 2013 03:29:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753845Ab3LOC3h convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Dec 2013 21:29:37 -0500
Received: from mail-qe0-f54.google.com ([209.85.128.54]:37186 "EHLO
	mail-qe0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753590Ab3LOC3g convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Dec 2013 21:29:36 -0500
Received: by mail-qe0-f54.google.com with SMTP id cy11so2861710qeb.41
        for <git@vger.kernel.org>; Sat, 14 Dec 2013 18:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=Tpbm8Q3t2p0ZBa1/Yb2xpZ6q5zYM5/xAZPPLrdNRP5o=;
        b=nE4fxb7SOAUnbmq+rIDNuW+E+xBE0wXo/9n7/n0RMzJflXfxtYqwmbLJBq/oaPI2D6
         8m0ToP6Pyz/H8ETPFGFeeGkLngPCxuqZ7Rze2BwmGR71u7XqTCid1kmnbNFpDFcsDFY6
         S6TTDGRDiX3FsVuU4311Me7t3P40AB6mTs/ov1px/8+tjmXud35UMhzqlKhDc46KWwQ9
         S8Kf+CMesYIT9F+ht3vmKFc8SUEgX9SdWf0jfLYIoNEAnv5HDdwse8TnrZ85hXY9hXUN
         2zNKpt6u/v7f+t/GtZiTnuVIEL9bHZlfOZAOaHn8wO7Pbd8FnDt6f24271wgqybT1ey6
         AOEw==
X-Received: by 10.49.1.106 with SMTP id 10mr19479158qel.55.1387074575858; Sat,
 14 Dec 2013 18:29:35 -0800 (PST)
Received: by 10.96.124.101 with HTTP; Sat, 14 Dec 2013 18:29:05 -0800 (PST)
In-Reply-To: <1387018507-21999-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239323>

On Sat, Dec 14, 2013 at 5:54 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
> Known issues

Scripts that expand "$GIT_DIR/objects" and are not aware about the new
env variable. I introduced "test-path-utils --git-path" to test
git_path(). I could move it to "git rev-parse --git-path" for use in
scripts, but there'll be more changes. git-new-workdir's symlink
approach shines here.
--=20
Duy
