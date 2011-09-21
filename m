From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 3/3] git-read-tree.txt: correct sparse-checkout and
 skip-worktree description
Date: Wed, 21 Sep 2011 19:26:04 +1000
Message-ID: <CACsJy8BrBsBM-DwC_CkYrrpFU6aTqpcohWDPxTnRhMEX+w3Nug@mail.gmail.com>
References: <cover.1316590874.git.git@drmicha.warpmail.net>
 <4E7996AA.4040909@drmicha.warpmail.net> <31152a2ddb83e37be1efce1d0cd742b71ea3efdd.1316590874.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Joshua Jensen <jjensen@workspacewhiz.com>,
	Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Sep 21 11:26:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6J4j-00004r-1T
	for gcvg-git-2@lo.gmane.org; Wed, 21 Sep 2011 11:26:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752787Ab1IUJ0g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Sep 2011 05:26:36 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:55874 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752727Ab1IUJ0f (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Sep 2011 05:26:35 -0400
Received: by bkbzt4 with SMTP id zt4so1264505bkb.19
        for <git@vger.kernel.org>; Wed, 21 Sep 2011 02:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=JyONh28D2LViwzlVqAVCAy8PZI1PtxEeuPeOhri2bQA=;
        b=xcoorLkgZDOFhgdA8/ukmKj7bDvqNxlbj5SkTi+ddtMuwn7lB7MG+t+U+TSP72Glmc
         SJ7GIAH1s1XBIZiPPNy04uYig+TkTwX97491xjecQy4FKUT+WIj8vvYdMwv+eMSM+dDe
         BOenjuDAM8kXEjVk4PuM8x1pTCoaIKKH9ckFQ=
Received: by 10.204.133.193 with SMTP id g1mr361137bkt.131.1316597194143; Wed,
 21 Sep 2011 02:26:34 -0700 (PDT)
Received: by 10.205.114.134 with HTTP; Wed, 21 Sep 2011 02:26:04 -0700 (PDT)
In-Reply-To: <31152a2ddb83e37be1efce1d0cd742b71ea3efdd.1316590874.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181830>

On Wed, Sep 21, 2011 at 5:48 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> The description of .git/info/sparse-checkout and
> skip-worktree is exactly the opposite of what is true, which is:
>
> If a file matches a pattern in sparse-checkout, then (it is to be
> checked out and therefore) skip-worktree is unset for that file;
> otherwise, it is set (so that it is not checked out).
>
> Currently, the opposite is documented, and (consistently) read-tree's
> behavior with respect to bit flips is descibed incorrectly.
>
> Fix it.

Ack.

> In hindsight, it would have been much better to have a "sparse-ignore"
> or "sparse-skip" file so that an empty file would mean a full checkout,
> and the file logic would be analogous to that of .gitignore, excludes
> and skip-worktree.

.gitignore works towards excluding files. No rule means no excluding.
sparse-checkout file works towards including files, no rule means no
inclusion.
-- 
Duy
