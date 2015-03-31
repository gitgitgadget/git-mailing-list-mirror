From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3] config.c: split some variables to $GIT_DIR/config.worktree
Date: Tue, 31 Mar 2015 19:17:10 +0700
Message-ID: <CACsJy8DQZmySvakBnjgEX2rPb4ndYo52XSoCeNHosh2VNaRFCg@mail.gmail.com>
References: <1427371464-22237-1-git-send-email-pclouds@gmail.com> <1427804079-13061-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Max Kirillov <max@max630.net>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 31 14:17:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ycv74-00072F-7L
	for gcvg-git-2@plane.gmane.org; Tue, 31 Mar 2015 14:17:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752901AbbCaMRm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 Mar 2015 08:17:42 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:34837 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751359AbbCaMRl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Mar 2015 08:17:41 -0400
Received: by igcau2 with SMTP id au2so16253910igc.0
        for <git@vger.kernel.org>; Tue, 31 Mar 2015 05:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=5tZq1kyI7CCRyZfWdHuezBBsM9Pq0SWMz+UKBhdsrJ8=;
        b=eDCTANu6FBMDcQpSXCAIBJknTcNMkFT7Dbyp85BVbED8gDio0gTunNV/955morrjjd
         ywmslWdIrYiE0blYi2mmaCMcKdc5JvckhypEaAjF9OIZindkG8oG1sBluXvE68aT8adu
         BZemCR6+QgQ5PJhq9p13reb5xqgPvA3F7XNkI9IY+LJ4Uqh+2qZ+wSPrHCFwc3pgkgU+
         89JRNI3AMLAqe0FYZYb7uI4dY+FcTBIP0hAMbKmlMWWQb7ixdDZRFe+IvEH01ELcZAVV
         ghMeXEQ71+r1PhvlaBmmnnQBFDfaC2EARWWqHEzdvx9KYpqnv3qoQj//DBWNEq4t3xdW
         /OSQ==
X-Received: by 10.50.36.103 with SMTP id p7mr3826144igj.20.1427804260837; Tue,
 31 Mar 2015 05:17:40 -0700 (PDT)
Received: by 10.107.47.170 with HTTP; Tue, 31 Mar 2015 05:17:10 -0700 (PDT)
In-Reply-To: <1427804079-13061-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266521>

On Tue, Mar 31, 2015 at 7:14 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
>  The general principle is like in the last mail: .git/config is for
>  both shared and private keys of main worktree (i.e. nothing is
>  changed from today).  .git/worktrees/xx/config.worktree is for
>  private keys only (and private keys in .git/config are ignored)

When I put it this way, I realize that
=2Egit/worktrees/xx/config.worktree can simply be
=2Egit/worktrees/xx/config. No ".worktree". Looks nice (or it's just a
source of more confusion later)
--=20
Duy
