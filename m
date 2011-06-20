From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH/RFC] Move contents of libgit.a to lib subdirectory
Date: Sun, 19 Jun 2011 18:06:24 -0700
Message-ID: <BANLkTimjixOT=j9Xf=Ti-04cRw2noC0NiQ@mail.gmail.com>
References: <alpine.LNX.2.00.1106192014410.41113@linux.foleyremote.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Peter Foley <pefoley2@verizon.net>
X-From: git-owner@vger.kernel.org Mon Jun 20 03:06:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYSx0-0002q1-B8
	for gcvg-git-2@lo.gmane.org; Mon, 20 Jun 2011 03:06:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751232Ab1FTBGp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jun 2011 21:06:45 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:56918 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750961Ab1FTBGo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jun 2011 21:06:44 -0400
Received: by gyh3 with SMTP id 3so1223365gyh.19
        for <git@vger.kernel.org>; Sun, 19 Jun 2011 18:06:44 -0700 (PDT)
Received: by 10.150.1.17 with SMTP id 17mr3186200yba.308.1308532004115; Sun,
 19 Jun 2011 18:06:44 -0700 (PDT)
Received: by 10.147.35.2 with HTTP; Sun, 19 Jun 2011 18:06:24 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1106192014410.41113@linux.foleyremote.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176043>

On Sun, Jun 19, 2011 at 17:50, Peter Foley <pefoley2@verizon.net> wrote:
> This patch tries to organize the git source tree by moving the files which
> make up libgit.a to a lib subdirectory.
> Before this patch the toplevel source directory contained 285 files.
> After this patch the root directory will contain 167 files and
> the lib subdirectory will contain 119 files
...

Thanks. But why is this amount of churn necessary or being
recommended? What problem does this address? Is that worth the pain
this puts on every other in-flight change that is still being
developed, or is already in the review pipeline?

-- 
Shawn.
