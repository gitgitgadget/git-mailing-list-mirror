From: Daniele Segato <daniele.bilug@gmail.com>
Subject: Re: how to skip branches on git svn clone/fetch when there are
 errors
Date: Mon, 07 Sep 2009 19:55:40 +0200
Message-ID: <1252346140.8992.36.camel@localhost>
References: <9accb4400908310126v15b08c7fr425c9daff26012f3@mail.gmail.com>
	 <9accb4400909070230n413c6ecfqef8238422dd5d3b@mail.gmail.com>
	 <9accb4400909070634oee46b78g9270586a2b0eb4b9@mail.gmail.com>
	 <4d8e3fd30909070853u6f4bc179qac96edae5c83a864@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 07 19:55:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MkiRW-0001RR-C1
	for gcvg-git-2@lo.gmane.org; Mon, 07 Sep 2009 19:55:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751941AbZIGRzo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Sep 2009 13:55:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751407AbZIGRzo
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Sep 2009 13:55:44 -0400
Received: from mail-fx0-f217.google.com ([209.85.220.217]:56279 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751197AbZIGRzo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Sep 2009 13:55:44 -0400
Received: by fxm17 with SMTP id 17so2135855fxm.37
        for <git@vger.kernel.org>; Mon, 07 Sep 2009 10:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=AuUHc4PSEXle4PRTtgYnJQEsGU5d3RrYDxVG9yZ3TQg=;
        b=R0t6/sx3f9KG1Q9+kmkyYdRm9cU1xCzrA8ex8yaHmarYLjIrB+d6CEdmsYJOmKN+ox
         riR2/u2RdR/yYM8B5d01qy9JncuDidM357sLq7eHcAi9eaE+hy007XjtRBBuifuYAb17
         +jzYUCegG2E1J5Xb72uxOk8y7ZCFzZMikwxK8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=rRN4Cy90wFITV0oL0AsqYyxqGaR82sc7PbpSBqWc+Vb9z5xNhXX9H+kORA2Hl1yDA4
         zXtBcjUPclDwJ0IlJlrzcNkTqy1PLvG7+Uw/d4uQKQZICgIakAX9su1y55S04aC88xYr
         uEhmkoAfWUwfiYg6LqqbyzHXLaVBOHayWxU2w=
Received: by 10.103.125.17 with SMTP id c17mr6232737mun.16.1252346144351;
        Mon, 07 Sep 2009 10:55:44 -0700 (PDT)
Received: from ?192.168.1.2? (host98-2-dynamic.52-82-r.retail.telecomitalia.it [82.52.2.98])
        by mx.google.com with ESMTPS id e10sm12475425muf.27.2009.09.07.10.55.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 07 Sep 2009 10:55:43 -0700 (PDT)
In-Reply-To: <4d8e3fd30909070853u6f4bc179qac96edae5c83a864@mail.gmail.com>
X-Mailer: Evolution 2.24.5 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127939>

Il giorno lun, 07/09/2009 alle 17.53 +0200, Paolo Ciarrocchi ha scritto:
> > I don't know if this is the best solution to solve the issue but it does
> > let me download the repo skipping the problematics paths
> 
> Usually these lines are for the commit message, I guess you don't want
> to store these two lines in git.git :-)

no
that was my local commit
(and I initially copied the wrong one....)

If my patch will be accepted (and I really doubt this will be the case)
I'll fix that with a git commit amend / git rebase -i following the git
developers guide-lines :)
