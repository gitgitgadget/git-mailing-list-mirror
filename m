From: Richard Hartmann <richih.mailinglist@gmail.com>
Subject: Revisiting metadata storage
Date: Mon, 14 Nov 2011 01:07:16 +0100
Message-ID: <CAD77+gQB+0zJG62jrtPn_MwLLR7zgH=5gBtkvPxrKgiLPZsbsw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 14 01:07:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RPk5Q-00058O-Rv
	for gcvg-git-2@lo.gmane.org; Mon, 14 Nov 2011 01:07:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752130Ab1KNAHj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Nov 2011 19:07:39 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:58224 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753298Ab1KNAHj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Nov 2011 19:07:39 -0500
Received: by ggnb2 with SMTP id b2so5669869ggn.19
        for <git@vger.kernel.org>; Sun, 13 Nov 2011 16:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=lF5NzDpL2u2O5ojvQk40Hssm5bT4bglprlTrd1cnpJc=;
        b=L49pMXfTQt8BdC8Lju2PIz8ok68kfJb0hDFpasP0AUGEZRfxDLo+w3EHMA/kv63m5K
         kzZW63asljr/NmuTXWdK1i9Z30gTncOuv1JyhpfJslZmNp/PeOB54peUQoXqeubtm70F
         63j8NDrqkOjYRcAeR4e+hQhKD5KvU9Px+Nm/k=
Received: by 10.182.31.78 with SMTP id y14mr4532964obh.25.1321229258293; Sun,
 13 Nov 2011 16:07:38 -0800 (PST)
Received: by 10.182.56.135 with HTTP; Sun, 13 Nov 2011 16:07:16 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185356>

Hi all,

every few months, a thread seems to pop up regarding metadata storage,
be it owner, mtime, xattr or what have you.

As of today there is (ttbomk) still no sane way to carry & restore
metadata across different repositories.

metastore[1] is closest to a working solution but its storage format
is binary and merge-unfriendly and it does not store mtime which is a
deal-breaker, for me.
I tried extend & fix metastore, but failed. Others looked at it,
deemed it possible and lost interest and/or their development box.

I know from Joey Hess [2] that the GitTogether 2011 saw some
discussion about metadata, but I was unable to find any follow-up to
this issue.


To make a long story short: Does anyone have a working solution,
today? If not, is anyone working on one? If not, is anyone interested
in working on one? And is there any follow-up to the GitTogether
discussion?

The feature set of any solution should probably include save, display,
diff, and apply on a per-metadata and per-file basis.


Thanks,
Richard

[1] http://david.hardeman.nu/software.php
[2] http://kitenet.net/~joey/blog/entry/GitTogether2011/
