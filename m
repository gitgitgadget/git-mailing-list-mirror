From: Philippe Vaucher <philippe.vaucher@gmail.com>
Subject: git reset --merge documentation improvments
Date: Wed, 23 Nov 2011 09:31:06 +0100
Message-ID: <CAGK7Mr59bN8rjhLHAK0Vq=bOBBHG=N02CgGe-np=OBdTyS+rsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 23 09:31:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RT8F4-0004pS-GU
	for gcvg-git-2@lo.gmane.org; Wed, 23 Nov 2011 09:31:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758766Ab1KWIbi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Nov 2011 03:31:38 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:38660 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753337Ab1KWIbh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Nov 2011 03:31:37 -0500
Received: by iage36 with SMTP id e36so1290272iag.19
        for <git@vger.kernel.org>; Wed, 23 Nov 2011 00:31:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=McCuRbF4OZAGVV9FSiPyfVqi819kl/fodMIho9JoJJM=;
        b=BivVkjuJTjM9982KxhTbIAVKJRVJ6Qmuwe+P5NJtaZ4HgNDAQuWnVh0ycwehtOu011
         QFr/TV00zF/yZk491nOPrZ6TR2nKUdZpuSh5yh8zAREy7X0UC63YgZ5aHCfhZBh0WsYK
         8iJFqQYsksnLNgLF0eTzijQ/HVK+L2nDq2vtY=
Received: by 10.231.60.76 with SMTP id o12mr6059386ibh.83.1322037097056; Wed,
 23 Nov 2011 00:31:37 -0800 (PST)
Received: by 10.50.195.199 with HTTP; Wed, 23 Nov 2011 00:31:06 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185826>

Hello,

The current documentation for --merge is:

"Resets the index [1] and updates the files in the working tree that
are different between <commit> and HEAD, but keeps those which are
different between the index [2] and working tree"

I think this is confusing, because [1] is the *after-reset* index and
[2] is the *before-reset* index. If you fail to realise this it looks
like this "resets index (so index is empty) and then updates worktree
but skip files staged from index" --> "but there's nothing staged, the
index was reset!"

I think a better sentence would be:

"Updates the files in the working tree that are different between
<commit> and HEAD, but keeps those which are different between the
index and working tree, and finally resets the index."

Or something along those lines.

Philippe
