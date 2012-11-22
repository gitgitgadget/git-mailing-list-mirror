From: Angelo Borsotti <angelo.borsotti@gmail.com>
Subject: git bash does not access drive f:
Date: Thu, 22 Nov 2012 08:07:55 +0100
Message-ID: <CAB9Jk9Ae46PNRex9QrEy9gTgqAbn8KUFifmxQU4s5K5mDDmDZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Nov 22 21:22:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TbdHu-0000S7-SS
	for gcvg-git-2@plane.gmane.org; Thu, 22 Nov 2012 21:22:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756787Ab2KVUWC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2012 15:22:02 -0500
Received: from mail-pa0-f46.google.com ([209.85.220.46]:54587 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756704Ab2KVUWA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2012 15:22:00 -0500
Received: by mail-pa0-f46.google.com with SMTP id bh2so3077241pad.19
        for <git@vger.kernel.org>; Thu, 22 Nov 2012 12:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=wklpf14tcF6AnaHiP+y2hyDthzJf9W1d49AePtvQvQw=;
        b=JTMqHIulnHADgfjbQYwar/HgdoxyUuiNbdChjbAhiLch+QCV8XkLDzPfd3aNRoc1CK
         nAI04fel2Y1E1YuSLZxIPCuzL3PLRoqjnfaDzog/ifrpy1pnkfbItMBQPjzP3yqRGmJ2
         rIMh6R/+ptmZj5YjjLCLBtTGLhT6cRPhbbDQNQ+GNACmSKVvrglZA2eOyznEWl4Unj5i
         0WiaMIEu8/A8hiHa7Js20j0VT2fhVcQVyKLI/IrgwSUMwqEJzfmmHypufKw4bPPa0gP0
         Qd6NhHr1QqbMrURibW/1N+cyxVF7NQwHY2p6VWwegjX9nKLQmyE0/N14kL6H/76OuKcV
         7Fug==
Received: by 10.68.135.101 with SMTP id pr5mr1965519pbb.140.1353568075679;
 Wed, 21 Nov 2012 23:07:55 -0800 (PST)
Received: by 10.67.3.101 with HTTP; Wed, 21 Nov 2012 23:07:55 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210209>

Hi

I have attached an external disc, which appears on Windows as drive f:
in Windows Explorer.
Right-clicking on it displays a context menu showing (among other
items) Git Init Here, Git Gui and
Git Bash. The first two work properly on that drive.
However, the git bash does not. Not even the one that is run from the icon:

$ cd f:
sh.exe": cd: f:: No such file or directory


Is there any way to make it access drive f?

-Angelo Borsotti
