From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: shallow clone not very shallow due to tags
Date: Wed, 17 Aug 2011 09:49:59 +0700
Message-ID: <CACsJy8CXiZ8uGruAk5XGFhY8MJsTHAPv3Mvh0euQdFE3U43MCg@mail.gmail.com>
References: <CAJo=hJuyZMj+qwFr_=stbQtGh2SCCpjfsBxm+2wbfJK=i_VTdw@mail.gmail.com>
 <CACsJy8DF49PJtv41vZEOX0fLg4U1+m6JEW28+iYD6jJxGctEzg@mail.gmail.com> <CAJo=hJv_NnZyGnedTQBL_mj3baS8O5Z2wiEbZCvv8305No4ehA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Aug 17 04:50:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QtWDD-0002vL-LF
	for gcvg-git-2@lo.gmane.org; Wed, 17 Aug 2011 04:50:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753228Ab1HQCub (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Aug 2011 22:50:31 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:62117 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752974Ab1HQCua (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2011 22:50:30 -0400
Received: by bke11 with SMTP id 11so375487bke.19
        for <git@vger.kernel.org>; Tue, 16 Aug 2011 19:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ysBN5oCV5ef26x5wVpfXL/z833gveXjp6K2EFAcsjlA=;
        b=EzVo6tWjA3hvV0Ajg9uDnlFHya+B8nMLxXzU6MMPW2whXyrhbcertyhoCGlEr+QlMy
         sDZ9rwR0cfP4S8O6ZvyTc8+0pigxk4EgUaHyoPimUCXP8FjZgrEaHmgJ3sGnY0y1yyqt
         Rj5Tj5tq0hwl3VqZcyTuGVvlZcZdyfMTjdT8Q=
Received: by 10.204.200.194 with SMTP id ex2mr171101bkb.19.1313549429212; Tue,
 16 Aug 2011 19:50:29 -0700 (PDT)
Received: by 10.204.156.19 with HTTP; Tue, 16 Aug 2011 19:49:59 -0700 (PDT)
In-Reply-To: <CAJo=hJv_NnZyGnedTQBL_mj3baS8O5Z2wiEbZCvv8305No4ehA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179500>

On Tue, Aug 16, 2011 at 12:16 AM, Shawn Pearce > Yes, I think a user
who is making a shallow clone should only get the
> HEAD branch to the depth specified, nothing else. If they want
> additional branches, they should either pass them on the command line
> to a new flag for clone, or modify their fetch configuration
> after-the-fact and fetch those separately.

I'd like maintain all refs of the repo, even though we though we only
have objects for one branch. If I do a shallow clone and want to
change branch, I could just list available branch locally instead of
going to gitweb.somewhere for the branch name.

Do we have someway to represent a ref placeholder?
-- 
Duy
