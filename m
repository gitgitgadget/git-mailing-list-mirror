From: Cosmin Apreutesei <cosmin.apreutesei@gmail.com>
Subject: [ANN] multigit: overlaid git repositories
Date: Fri, 15 May 2015 01:27:43 +0300
Message-ID: <CAKJdRa=U8sy4ikBwBc2utZfHCjR73t0a417GWW8sTs73gouZTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 15 00:28:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yt1c6-0007qT-G6
	for gcvg-git-2@plane.gmane.org; Fri, 15 May 2015 00:28:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161217AbbENW2P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2015 18:28:15 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:32914 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161213AbbENW2N (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2015 18:28:13 -0400
Received: by pacuq5 with SMTP id uq5so4905865pac.0
        for <git@vger.kernel.org>; Thu, 14 May 2015 15:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=P203kj2u7HHbQI+mz3JbbN2275wroVql6Ez059Xg2IY=;
        b=wVjJqwG+oOKiFIXkQdcE2jPiP7wmy0UpUIyjmDmUwjOYHocPFAiTcqNearB+YTY3O+
         A8dGw3EpMdb0PQFEmbFTbgMhzKWteM50J+bydH78Ivl5QReiuoTiTceP/OZ7g111SqqZ
         gipXjNVnQd+QeGbFzBqViYhSrgpNDF5Wnxpt/U/ZmbKID0ip1ilnh7Iko8JTJPgtPOEQ
         o7hkr/u2BsFcXoL6IFkPRrce8SYiVucACp0syqLH3wBnTMdFTZ8/ChJaLAy5c5KPKNFK
         Su3pt8Lb49K/tuSO+WjzFB7sZVglE0koAXmB2vfw1X7V0GrGeanKYs9WIZKGA2aZkC7L
         WXeA==
X-Received: by 10.70.55.199 with SMTP id u7mr12264910pdp.42.1431642483949;
 Thu, 14 May 2015 15:28:03 -0700 (PDT)
Received: by 10.70.86.232 with HTTP; Thu, 14 May 2015 15:27:43 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269115>

Hello everyone,

Multigit is a tool which allows you to work with multiple repositories
overlaid over a single directory.

URL: https://github.com/capr/multigit

It's used extensively as the package manager for luapower[1], and it's
similar to vcsh[2] for those who know that project.

It is useful for projects which are made of different components that
are developed separately, but which need to deploy files in different
parts of the directory structure of the project, like for instance:

  * manage customizations made to a web app in a separate repository.
  * putting your home directory under source control.
  * package and/or config manager for a Linux distro.

I hope someone finds it useful.

--Cosmin

PS: I wish I could do `git clone --git-dir=foo foo-url`.


[1] https://luapower.com/luapower-git
[2] https://github.com/RichiH/vcsh
