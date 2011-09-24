From: "Frans Klaver" <fransklaver@gmail.com>
Subject: Re: More Beginning Git Questions
Date: Sat, 24 Sep 2011 22:53:52 +0200
Message-ID: <op.v2byz2p80aolir@keputer.lokaal>
References: <4E7C9AAD.7060209@gmail.com>
 <m3ipojqhpm.fsf@localhost.localdomain> <4E7CCCA0.50909@gmail.com>
 <14gm3o851q0ad.1uoossmxgfyit.dlg@40tude.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 24 22:54:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R7ZEX-0005iV-DO
	for gcvg-git-2@lo.gmane.org; Sat, 24 Sep 2011 22:54:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752115Ab1IXUx4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Sep 2011 16:53:56 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:34639 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752015Ab1IXUx4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Sep 2011 16:53:56 -0400
Received: by eya28 with SMTP id 28so2869485eya.19
        for <git@vger.kernel.org>; Sat, 24 Sep 2011 13:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=content-type:to:subject:references:date:mime-version
         :content-transfer-encoding:from:message-id:in-reply-to:user-agent;
        bh=dZsuZWyG7yAv/rehj7qhe6eG+p5In+a3qXRCQ6fibUU=;
        b=NFalwHhieAO69kw9Mn9XK4HT0a6sjEC3aorMC6A62G2yuZaJ/b/AEsNnttXC9Mt45m
         VhRLbkcJkvZo+LvCmIdjTh4F3rjNyhG5TnPLKJf2DkR/96Sgl+LqhFmhPUedif83MS1X
         AVk1BHGEM+IIbfCShhgf/B4IATkjGtq9r/t80=
Received: by 10.14.17.7 with SMTP id i7mr1607177eei.147.1316897634784;
        Sat, 24 Sep 2011 13:53:54 -0700 (PDT)
Received: from keputer.lokaal (82-136-253-149.ip.telfort.nl. [82.136.253.149])
        by mx.google.com with ESMTPS id b3sm44497731eec.7.2011.09.24.13.53.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 24 Sep 2011 13:53:53 -0700 (PDT)
In-Reply-To: <14gm3o851q0ad.1uoossmxgfyit.dlg@40tude.net>
User-Agent: Opera Mail/12.00 (Win32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182042>

On Sat, 24 Sep 2011 22:22:31 +0200, tactical <a5158017@nepwk.com> wrote:

> Mercurial allows this, and it's a very powerful feature.  After reading
> this thread, I could not believe Git didn't pulling with local changes,  
> and so I tried it, and also asked on IRC -- and it seems that Git really
> doesn't.

Git doesn't do it implicitly. Be explicit about it

$ git stash
$ git pull
$ git stash pop

seems to do exactly what you want.

Cheers,
Frans
