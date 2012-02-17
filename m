From: Peng Yu <pengyu.ut@gmail.com>
Subject: git-completion bug for 'git remote show <TAB>'
Date: Fri, 17 Feb 2012 08:41:30 -0600
Message-ID: <CABrM6w=NZ9OPV-mCjHytp-qtThVp-zfCm-c9fqTG3=xFdmP5og@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 17 15:41:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RyP0C-0001wq-Ck
	for gcvg-git-2@plane.gmane.org; Fri, 17 Feb 2012 15:41:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751576Ab2BQOlb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Feb 2012 09:41:31 -0500
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:51070 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751009Ab2BQOlb (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Feb 2012 09:41:31 -0500
Received: by obcva7 with SMTP id va7so4499569obc.19
        for <git@vger.kernel.org>; Fri, 17 Feb 2012 06:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=LudvF8J7e1e+obgB8//HeA57OxB/5VV5t1dFzoYZ1pc=;
        b=JBc1DSVgrWcfAjqfdT5q9aH3j9QR23MdB+nVXMiDtSfyuC0llNzD82gCtTI22OX590
         LhC89BV8weUy5pQ6fQfX6pmAlJJYn/3aguJIdi/zbonqGFov+J5Dm9K+JqTTKd4UhcTx
         cWpP8BSRm2icWUsnqshWLtTFdDO+QI8c64uo4=
Received: by 10.182.182.100 with SMTP id ed4mr5349948obc.24.1329489690550;
 Fri, 17 Feb 2012 06:41:30 -0800 (PST)
Received: by 10.182.75.202 with HTTP; Fri, 17 Feb 2012 06:41:30 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190960>

Hi,

I got the following error when I try to complete after 'git remote
show'. Could anybody take a look what is the problem?


~/dvcs_src/cron/media$ git remote show -bash: words_: bad array subscript
-bash: words_: bad array subscript


-- 
Regards,
Peng
