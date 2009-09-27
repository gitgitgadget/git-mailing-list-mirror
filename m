From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: Deciding between Git/Mercurial
Date: Sun, 27 Sep 2009 21:34:54 +0200
Message-ID: <40aa078e0909271234l227e9d27i71fcdc788a78c850@mail.gmail.com>
References: <81b0412b0909271144o26743e05uac3132cdc5b530b@mail.gmail.com>
	 <585748.13758.qm@web27802.mail.ukl.yahoo.com>
	 <h9odqq$ig9$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: newsgroups@catchall.shelter13.net
X-From: git-owner@vger.kernel.org Sun Sep 27 21:36:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MrzXx-0006I9-9M
	for gcvg-git-2@lo.gmane.org; Sun, 27 Sep 2009 21:36:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751107AbZI0Tew (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Sep 2009 15:34:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750999AbZI0Tew
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Sep 2009 15:34:52 -0400
Received: from mail-bw0-f210.google.com ([209.85.218.210]:59875 "EHLO
	mail-bw0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750699AbZI0Tev (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Sep 2009 15:34:51 -0400
Received: by bwz6 with SMTP id 6so886317bwz.37
        for <git@vger.kernel.org>; Sun, 27 Sep 2009 12:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=6LjxzDxidxZXb0hEeSyAPnLvTO+XFOcTjo+UZ5/DLeo=;
        b=W9m1WVPiI1xoEx9L50OOuOLnJ9FJVfCOG3KpCGPLDd7plsVsNAMjORoU2uyjT1ftHh
         cH798mEcHI1y6dh+TMSJziO7pXwL1yDVTzZpT36Bs4s01SzXxZihtsPr9ygzzsKjyVbQ
         pzmhrg2d8jP5p4VuMaiT0RybH3k98Anz6W64o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=ayHZM5e3KnWazkkSx88bIX/kQwOOP3CUu0PkNfKsK/aE77IWSaLErlZyezEvKNRMZb
         AqrpeQ7DRxxbP7/Yr1bL0lvntf+FSobSoarkotcLdvVvmQv+/1r7FjmqO1RuVTEiWOQo
         eLuh0dDrIlSWQBE7cQFHragMwe7GYWIETzbys=
Received: by 10.204.19.145 with SMTP id a17mr2295169bkb.64.1254080094220; Sun, 
	27 Sep 2009 12:34:54 -0700 (PDT)
In-Reply-To: <h9odqq$ig9$1@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129218>

On Sun, Sep 27, 2009 at 9:18 PM, Anteru
<newsgroups@catchall.shelter13.net> wrote:
> Don't get me wrong with Git+msysgit on Windows, the point is simply if
> we switch to git, can we expect that Windows will be supported for the
> foreseeable future or is it possible that git may simply drop Windows
> support completely? For Mercurial, this is a non-issue, as it is written
> in Python, and Python will support both Windows and Linux.

The chance of Windows support being dropped from git is very unlikely
- there's way too many people depending on git for Windows already for
that to happen. Besides, git is open source, so you can always fix
Windows issues yourself.

As for Mercurial, Python programs aren't automatically portable to
Windows either. But I expect that they have the same very close to
zero chance of having Windows support dropped as git has.

> As I said, I'm happy with using msysgit, but I cannot find any roadmap
> etc. which helps me to determine how git and Windows is going to
> continue (for instance, I can find some complaints that git's
> performance is bad on Windows due to cygwin's fork()/exec(), is this
> likely to get ever "fixed"? I guess git# will solve this as soon as it's
> ready?)

Git (neither mainline nor msysgit) doesn't have any official roadmap
as far as I know. People just hack away on what they feel is
important. If you want to make sure something gets done, chip in the
development-time yourself.

As for the fork()-performance, this is only an issue for some tools
(if any at all - I don't think this issue exists in msysgit). In my
experience, git on Windows is faster than any other VCS I've ever used
on Windows.

-- 
Erik "kusma" Faye-Lund
kusmabite@gmail.com
(+47) 986 59 656
