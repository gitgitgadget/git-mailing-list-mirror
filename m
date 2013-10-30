From: Eugene Sajine <euguess@gmail.com>
Subject: Help creating git alias
Date: Wed, 30 Oct 2013 15:34:13 -0400
Message-ID: <CAPZPVFbiSx8n0W1kcczCdC6ioVuWpwuUQ_pc9T=7i4X_FuZNhg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 30 20:34:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbbX1-0000ii-D9
	for gcvg-git-2@plane.gmane.org; Wed, 30 Oct 2013 20:34:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754006Ab3J3TeP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Oct 2013 15:34:15 -0400
Received: from mail-wi0-f181.google.com ([209.85.212.181]:58139 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752343Ab3J3TeO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Oct 2013 15:34:14 -0400
Received: by mail-wi0-f181.google.com with SMTP id ex4so1984563wid.14
        for <git@vger.kernel.org>; Wed, 30 Oct 2013 12:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=gX9Xd8zMXakrPfCWEehNTU3xAeMvktAiunANW3dPnTY=;
        b=rqd0+QytJ+kDuPByoLz6Xks9P4v7TWSfZiKgyIO2UskBNMu4Zp3HXevVUQiVKMyhpV
         /N/PXTUipGcncSR6Zx6eZ/qxSA/eLnhjG2VBsUlviPeQ8qyWleXmUU3xQgsb+RWSOliT
         hUSJEBiXVnL8pFoam4QpA0303cbIWkesoieVf/FLGep6tRm9ynWK+A3fgrzpsq+HK2vC
         25zRX9+x+1aVEd8LSgskZcVrVG8sBNoyGalCYkia2z/rItlQUmbo1BDn5jCePNcwlCL1
         srnqtkVR1PSor4+x7AUQFzojTp1F2TQfe7bbbt+/Ie2G5Qe9FBXh9FNY5ISBSt8UGhp3
         5Qpw==
X-Received: by 10.181.12.104 with SMTP id ep8mr3604502wid.54.1383161653380;
 Wed, 30 Oct 2013 12:34:13 -0700 (PDT)
Received: by 10.216.123.145 with HTTP; Wed, 30 Oct 2013 12:34:13 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237060>

Hi,

I need some advice about creating the git command alias:

I have this as the command:

git log --pretty=format:"%h %ad %ae %s" --date=short | sed 's/@\S*//g'


The purpose is to cut off the email domain and keep only username.

I'm trying to create this as the alias:


lg = !sh -c 'git log --pretty=format:"%h %ad %ae %s" --date=short |
sed 's/@\S*//g'' -

but it complains about the \S and i'm failing to come up with the
escape sequence to make it work right.

I know i can work around that by creating shell alias, but it is not
what i would like to have.

Any ideas?

Thanks!
