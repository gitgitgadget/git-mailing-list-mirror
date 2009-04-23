From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: auto commit merge using the default merge message
Date: Thu, 23 Apr 2009 09:57:18 +0200
Message-ID: <81b0412b0904230057k1653d039vfc3962e6affda584@mail.gmail.com>
References: <81bfc67a0904230046j48ed06b7s5693406332ee52dc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Caleb Cushing <xenoterracide@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 23 10:00:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwtrW-0000dN-MP
	for gcvg-git-2@gmane.org; Thu, 23 Apr 2009 10:00:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757917AbZDWH5X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Apr 2009 03:57:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758071AbZDWH5V
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Apr 2009 03:57:21 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:7816 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757917AbZDWH5U (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Apr 2009 03:57:20 -0400
Received: by yw-out-2324.google.com with SMTP id 5so263847ywb.1
        for <git@vger.kernel.org>; Thu, 23 Apr 2009 00:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=qyZybQlY+IOZhn3o91DHREK4BWaTtiUpE/SzF0yW0RE=;
        b=k4/sNXeT2+0hFRg3qsQoBRhKeCTz5b0YO2RjmBi9TgJbEX9OiD39SdOhiFlSz2Qs1P
         m0hvVQK9NHb+UxCKCpfPmIORItxp45Xz0UKIxw0Z/7ZFwNRKZ0DgoRS1xKh0hzRTpIX/
         VM1k8BM2ceyPkxUIJrJJbKurDKE2KDoGeJM6U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Yy4jWHQr2AjmLZrGm999Ilq5lcn3vCS2aydhscunMytfZk6mWU4WZaCZgHH+oxMPED
         WTusH8Cob6Sko4bMkUnyMHeEwLXZfnnj6VYUrrt02dnbmh/zl4TpaHCvzq1FJbl+23FB
         eVl3yw8W41ei+zQv6Ui60l0Z2SoGuKYjhYJyE=
Received: by 10.151.134.13 with SMTP id l13mr239253ybn.159.1240473438853; Thu, 
	23 Apr 2009 00:57:18 -0700 (PDT)
In-Reply-To: <81bfc67a0904230046j48ed06b7s5693406332ee52dc@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117307>

2009/4/23 Caleb Cushing <xenoterracide@gmail.com>:
> so I do the same merge all the time... sorta, I'm not sure rerere
> would actually work because the file is different each time... I just
> have to delete it each time. and I want to automate the process.
> checkout merge rm commmit, problem is commit brings and editor up, I
> want to commit with the 'auto inserted merge message' that is
> generated, without seeing the editor, how do I do this?

See git commit -C <commit-with-fitting-description>,
git commit -F <message-file> and git commit -m "message text".
