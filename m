From: Daniele Segato <daniele.bilug@gmail.com>
Subject: Re: Locally manage user/branch setting files without pushing them 
	remotely
Date: Thu, 12 Nov 2009 10:29:46 +0100
Message-ID: <9accb4400911120129h54609846jac9eb3b6cb07b792@mail.gmail.com>
References: <9accb4400911110401g5c44d011u50cafcfe736a2ec6@mail.gmail.com>
	 <20091111192449.GH27518@vidovic>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Thu Nov 12 10:30:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8W0t-0007Yi-TX
	for gcvg-git-2@lo.gmane.org; Thu, 12 Nov 2009 10:30:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751979AbZKLJ3p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Nov 2009 04:29:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751941AbZKLJ3o
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Nov 2009 04:29:44 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:54974 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751806AbZKLJ3o (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Nov 2009 04:29:44 -0500
Received: by bwz27 with SMTP id 27so1970175bwz.21
        for <git@vger.kernel.org>; Thu, 12 Nov 2009 01:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=6u61KYUdkBT6A7i2gndJwExSG4/Y9t/MIr0Q/R9LOqo=;
        b=oy8RL1T3KQ8soqPmU1iPXJsXEtTVMwcyAMdvHz4MQeU8nkXQxApBx1MWl5XGq1H4GN
         R+dUF/404bLpEHNzW48FOZsZXr9anh2f7WRSibJ0NmL2++7cJFa4WEKmdQmqWdhV/8qv
         BZBtTDL2lr9HuLU71lqqRgFv4JQQ7R9kmyVn4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=jTJbpA0fZpMYk7VVxcSAZeFQ3loELoc8u6OM45Kqm7OEIlT/42ewR/dvLpKBwUumjT
         6doS5zGKPICRj1wJI7zsqzM577crW9SpG0k8R6SDYpoyVejlDR3CcXBq1C6YeHTxIl/0
         Wo5Dvww1/aJJE3XIR0zwQbd5hjznP+Nt/NdPU=
Received: by 10.204.33.193 with SMTP id i1mr2859933bkd.75.1258018187588; Thu, 
	12 Nov 2009 01:29:47 -0800 (PST)
In-Reply-To: <20091111192449.GH27518@vidovic>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132751>

On Wed, Nov 11, 2009 at 8:24 PM, Nicolas Sebrecht <nicolas.s.dev@gmx.fr> wrote:
> This looks to _not_ be a piece of the development project. Settings used
> for the tests suites, company where you work, etc _are_ clones (from the
> abstract POV, at least) of the maintainer public repository.
>
> If you want to track changes of settings in a per-production-repo basis,
> you should do it _out_ of your main development repository. The latter
> should have a publishable template instead (eg. "user = user_login",
> "password = set_your_password").

you are probably right but even if I place this files outside my
repository I still have to modify them manually..
it's the same of having them into the repo but in .gitignore

we are customizing a third party product and I can't change the way it
is build up.

I don't think that this situation is so uncommon anyway.

Regards,
Daniele
