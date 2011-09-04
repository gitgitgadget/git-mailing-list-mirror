From: Michael Witten <mfwitten@gmail.com>
Subject: Re: Lost association between TAGS and COMMITs when rebased a git(1) repository
Date: Sun, 4 Sep 2011 14:43:56 +0000
Message-ID: <CAMOZ1BtxZ5C+pH_eEBu8=oqOyY6JkP8wiFmauyqcSOeijvgA+g@mail.gmail.com>
References: <FF0364F3D5244CA4987EDDCFE7244BF3@urbanjsPC> <CACx-yZ3tav1sJnLtJOn_YugQOsM9ERi7Cc7SowunyobxxX5YdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "John S. Urban" <urbanjost@comcast.net>, git@vger.kernel.org
To: knittl <knittl89@googlemail.com>
X-From: git-owner@vger.kernel.org Sun Sep 04 16:44:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0Dw1-0000CE-UM
	for gcvg-git-2@lo.gmane.org; Sun, 04 Sep 2011 16:44:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754175Ab1IDOo2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Sep 2011 10:44:28 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:44497 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753961Ab1IDOo0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Sep 2011 10:44:26 -0400
Received: by iabu26 with SMTP id u26so5240984iab.19
        for <git@vger.kernel.org>; Sun, 04 Sep 2011 07:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=tnx6RnEknXUjvZniXVnsqXWsyJpzJd2SIN0/3yvRhqI=;
        b=OLCuvPWP2axFbaPWF+n59DC76e0tTjA10J6P9nlFpxg7zCSs4BrSJovosQoAxYEN5j
         IDscdw2uOSlkGx38JaXip+fbTzQQVt2rgFmakq65B/KirgqSMu2DxYNN09m4hdaiDDXv
         dUXP4npWqjeVqL98Z8BUzvFsb+mmRjTbh1Fh0=
Received: by 10.43.48.9 with SMTP id uu9mr2438454icb.129.1315147466180; Sun,
 04 Sep 2011 07:44:26 -0700 (PDT)
Received: by 10.42.178.198 with HTTP; Sun, 4 Sep 2011 07:43:56 -0700 (PDT)
In-Reply-To: <CACx-yZ3tav1sJnLtJOn_YugQOsM9ERi7Cc7SowunyobxxX5YdA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180684>

On Sun, Sep 4, 2011 at 14:30, knittl <knittl89@googlemail.com> wrote:

> "Rebase" takes commits and creates new commits from those. The new
> commits are not the same as the old, although they might have
> associated the same tree or changeset.

According to `git help glossary':

  changeset
      BitKeeper/cvsps speak for "commit".
      Since git does not store changes, but states,
      it really does not make sense to use the term
      "changesets" with git.

Git's erroneous nomenclature is bad enough as it is, so please try
not to explain things using such spurious terminology.
