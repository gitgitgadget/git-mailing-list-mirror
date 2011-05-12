From: Eric Frederich <eric.frederich@gmail.com>
Subject: fast forward a branch from another
Date: Thu, 12 May 2011 10:40:16 -0400
Message-ID: <BANLkTi=PtkDp8PNdMNi3hTwHPjFg+Jtftw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 12 16:40:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKX3x-0007gv-B4
	for gcvg-git-2@lo.gmane.org; Thu, 12 May 2011 16:40:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757829Ab1ELOkS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2011 10:40:18 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:57700 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757819Ab1ELOkR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2011 10:40:17 -0400
Received: by wya21 with SMTP id 21so1218209wya.19
        for <git@vger.kernel.org>; Thu, 12 May 2011 07:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=Y+yCX8QhmFM0G2YdVFbz99xoX4T08kcdtJtKoMeOFA8=;
        b=Cuho1pE0KhSeR+dTEKGOSAoDT7SP7B4LQx+J6D8KyiQj+qHL59eicOalHyDTf0Dh7V
         7N4zaXqK13F4IhSoRBvHt9CnkDrfEGkwvBPf93+uhoVKYrjA8NnMbkGfvnDrfWMunJz7
         Rly8dCDBTkvZNJLibU14BxQkzSfg+7ZtejDO0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=NAJy8PMxyPsrXG8bUiceZysJR+92I8URONzFiGgfkAMgJjteK+Zd4/fnwxW516EDOd
         JCNxmoLofVoSqS14G45j/FsARqP67rX9mPOp+LSX+jTsTsvUtvj4VvQsNLHlrkRjEvpY
         vUQarikKzfpB4ccKbKhP86Hp56lNH2tPUoAbk=
Received: by 10.227.39.88 with SMTP id f24mr280657wbe.88.1305211216145; Thu,
 12 May 2011 07:40:16 -0700 (PDT)
Received: by 10.227.157.73 with HTTP; Thu, 12 May 2011 07:40:16 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173472>

Often times I get into a situation where I have a "development" branch
that gets ahead of say a "stable" branch.
When I am ready to call the development branch stable this is what I do.

$ git checkout stable
$ git merge development
$ git checkout development

The problem here is that the act of going backwards (via checking out
stable) really messes up my IDE and or Text editors.
Is there any way to do this without switching branches, which modifies
my working directory, which messes up my IDE?

Thanks,
~Eric
