From: Eli Woods <eliaswoods@gmail.com>
Subject: GIT GUI - Windows build will open a window on a disconnected display
Date: Thu, 31 Dec 2015 11:46:59 -0500
Message-ID: <CANw98ADVGg0GKXmHbNVrPhqM4fbFL3et_vrY7kcvMt-LaW7Htg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 31 17:47:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aEgOL-0006uw-A5
	for gcvg-git-2@plane.gmane.org; Thu, 31 Dec 2015 17:47:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751003AbbLaQrU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Dec 2015 11:47:20 -0500
Received: from mail-yk0-f169.google.com ([209.85.160.169]:35913 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750726AbbLaQrT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Dec 2015 11:47:19 -0500
Received: by mail-yk0-f169.google.com with SMTP id v14so90264704ykd.3
        for <git@vger.kernel.org>; Thu, 31 Dec 2015 08:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=rS7pF/TlIBKxeM6UOQ8qObFlw1xaTp7eDEETu7KboDo=;
        b=vlQc/QCRBJYXn6NEFT6oiCKmlrvLfqld/KTS4MrroV/4zhz5Xb35U/CZBw6TdnkUXh
         hH9a5k1R1jDvv0CPrEGUhlyaLGuHIx9rVH9Y//+OUIgjQXcRqkXHsGPW+IYwNpG3PwiG
         c2hdvDpX8NNWtJSL1rB1jenGaeR5afjDDScvHncLK/8LsOSFLL9EMVXpgwZ7rGRaR7sl
         ScVmbbhFdMX78bFP+lqGArY+/wTwiXZsDdPAFO8pVu5g4LfgfoNVlC+cXYFr+SUChDex
         YvX8GucV7GWVKdp5bi2sC7WTPXVRRd3NkFPGkgsd/roDiQjih+DwNF9nxmbYDHg9L/7s
         bl4A==
X-Received: by 10.129.56.196 with SMTP id f187mr12723651ywa.111.1451580438966;
 Thu, 31 Dec 2015 08:47:18 -0800 (PST)
Received: by 10.13.226.209 with HTTP; Thu, 31 Dec 2015 08:46:59 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283247>

I use a secondary monitor when at the office and I often will have
applications open on the second display.

The bug happens when I open the Git GUI application without having the
second monitor connected. The dialog window that asks for selection is
displayed properly but the main window is lost on another display.

You can still get around to the window by using windows keyboard
shortcuts but it isn't ideal.

This may not be a bug specifically for Git GUI, it may better be
reported to WISH
 or even Microsoft.

Windows 7
git-gui version 0.20.GITGUI
git version 2.6.3.windows.1
Tcl/Tk version 8.6.4
