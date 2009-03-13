From: John Tapsell <johnflux@gmail.com>
Subject: Re: Not pushing all branches?
Date: Fri, 13 Mar 2009 08:25:05 +0000
Message-ID: <43d8ce650903130125m6335d189obbcdb86ec9036083@mail.gmail.com>
References: <alpine.DEB.2.00.0903130846410.17450@perkele.intern.softwolves.pp.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Fri Mar 13 09:27:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Li2k5-0004Iu-33
	for gcvg-git-2@gmane.org; Fri, 13 Mar 2009 09:27:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753698AbZCMIZK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Mar 2009 04:25:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752714AbZCMIZJ
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Mar 2009 04:25:09 -0400
Received: from rv-out-0506.google.com ([209.85.198.232]:36592 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752736AbZCMIZH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Mar 2009 04:25:07 -0400
Received: by rv-out-0506.google.com with SMTP id g9so459697rvb.5
        for <git@vger.kernel.org>; Fri, 13 Mar 2009 01:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=KkevBR3Hl46jRLe2mN0Wt4dOqSR7tFtFRIbNXG5f7Bg=;
        b=otd/tWjMPFPNk0+UuuVxRpby1ychYM/o2AdnsyWUkit9E0nud7WCV3bgW85c2jucfx
         YSHmxWRZfSej6W/NA2pozse5N1ENa0tHmIajUhMVgBp065QvW7eVKKo9eFMXjX/+47yy
         6lIrMyZELYwHJeRVoNfss2h422+4t21wdlqqA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=xAr5ScLFv8wFpFArrrXbaRHRJQFlss21rb/YHFVzDfwYvtWtkAoQNhK3DB3k4M+aVo
         tCPTRQMpnMRXXZlyLlFs6mq9DcUkZvU3ej6rwwDfQS7+Gn5HzXhvd5nOqNOBVP5nAxZv
         8Eyw2f01DahCol9MxS1rvjXRTY1xIYGV7bCbc=
Received: by 10.142.172.20 with SMTP id u20mr18236wfe.286.1236932705551; Fri, 
	13 Mar 2009 01:25:05 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.0903130846410.17450@perkele.intern.softwolves.pp.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113157>

2009/3/13 Peter Krefting <peter@softwolves.pp.se>:
> Hi!
>
> Doing "git push remote" pushes all my local branches by default. Is there a
> way to set it to *not* do that, and (for this particular remote repository)
> just push the current branch?

> Or failing that, not allow me to run "git
> push" without specifying a branch?

I've been pushing for this behaviour, and there was a patch a few days
ago to do this.  I'm not sure if it is/will be committed.

John Tapsell
