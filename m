From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git branch diagram
Date: Sun, 20 Apr 2008 17:30:21 -0700 (PDT)
Message-ID: <m3fxtgqcbr.fsf@localhost.localdomain>
References: <911589C97062424796D53B625CEC0025E460C3@USCOBRMFA-SE-70.northamerica.cexp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: <Patrick.Higgins@cexp.com>
X-From: git-owner@vger.kernel.org Mon Apr 21 02:31:11 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jnjw6-0003gm-Tq
	for gcvg-git-2@gmane.org; Mon, 21 Apr 2008 02:31:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753678AbYDUAaZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Apr 2008 20:30:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753624AbYDUAaZ
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Apr 2008 20:30:25 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:51889 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753550AbYDUAaY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Apr 2008 20:30:24 -0400
Received: by fg-out-1718.google.com with SMTP id l27so1555640fgb.17
        for <git@vger.kernel.org>; Sun, 20 Apr 2008 17:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=WEm8vxNwFZSicGioEzDQXvAZjqsOweK7aX6QQhGV4E4=;
        b=aqV/H/XyQaY39+Af0fWqiPn67vRPO1lqPn24sFQOQtYISuTynloUttXYg9dgRTR4lSvS4y14KTWGqMZPTzlGslzGxFaKqNWtMYwLn5/a/oG9ITcvZ58ehAPAVz5kEEsSqboSDqFxoa9vZPvqxkRqmz64dBHz0ZIL9SjEGPs73gw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=fuutGwge6g8S/UL4Nmn/L+uI23d1qZipNFe4F2IjPMWkPmohTU852iHJT97whJwvseLQtiKu71nxQhfNSuJuZBKuzs1cMXv89AmisG+91cUryO0mY8MQyhM20+95XCzqF7lhZ+Ljb/yhPv3gLsmHVsy69Tyw7u6fRQ9FGpwkztk=
Received: by 10.86.4.2 with SMTP id 2mr11779690fgd.27.1208737822500;
        Sun, 20 Apr 2008 17:30:22 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.192.60])
        by mx.google.com with ESMTPS id z40sm5671599ikz.4.2008.04.20.17.30.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 20 Apr 2008 17:30:21 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m3L0UIYf024792;
	Mon, 21 Apr 2008 02:30:19 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m3L0UHAM024788;
	Mon, 21 Apr 2008 02:30:17 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <911589C97062424796D53B625CEC0025E460C3@USCOBRMFA-SE-70.northamerica.cexp.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80007>

<Patrick.Higgins@cexp.com> writes:

> I am trying to get my employer to start using git and have found the
> distributed model and git's branching to be one of the hardest parts
> to explain and understand. 

Take a look at description of version control and distributed version
control at BetterExplained, and slides from presentations / seminars
which you can find in GitLinks page at git wiki.

> I put together the attached diagram (done with graphviz so some
> things are not in the most logical place) to help explain things to
> my coworkers.
> 
> Unfortunately, I don't understand things well enough myself to know
> if the diagram is correct or not. I read in the stgit docs that
> developing directly in the master branch is discouraged by
> convention, but I don't really understand why. The git tutorial
> shows work happening directly in master, so I wasn't sure if that's
> a convention that only makes sense for stgit or for plain git, too.
> 
> Does my diagram make sense? Are there any suggestions or corrections?

It is much too complicated. IMHO it would be better to explain the
idea of remote branches first (separate diagram), then simplify
diagram by showing only relationships between repositories:
relationship between branches is impled.

Perhaps adding what branches are supposed to be found at given
repository...

BTW. do all transfer is pull (or fetch) only, or are there pushes and
exchanging patches via email?

> In my diagram, I am assuming that most developers work in master,
> and make branches for their own long-lived projects and experimental
> things.

For example git itself, as a project, uses three long-lived branches:
'maint', 'master' and 'next', uses 'pu' (proposed updates) branch as
propagation / review mechanism for short-lived tipic branches.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
