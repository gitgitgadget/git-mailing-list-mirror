From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git-clone works with ssh but not with http/https/git
Date: Tue, 24 Jun 2008 05:25:22 -0700 (PDT)
Message-ID: <m3abhbkoe2.fsf@localhost.localdomain>
References: <ce513bcc0806240415h669d1725uf7b6e495995ab459@mail.gmail.com>
	<1214306517.6441.10.camel@localhost>
	<ce513bcc0806240445x6d00323g303f218504d2df53@mail.gmail.com>
	<alpine.DEB.1.00.0806241246500.9925@racer>
	<ce513bcc0806240507q58c2a3y5fe8f0e8033353ad@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Matthias Kestenholz" <mk@spinlock.ch>, git@vger.kernel.org
To: "Erez Zilber" <erezzi.list@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 24 14:26:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KB7bO-0005M1-V3
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 14:26:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760336AbYFXMZ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 08:25:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760323AbYFXMZ2
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 08:25:28 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:13347 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760216AbYFXMZ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 08:25:27 -0400
Received: by nf-out-0910.google.com with SMTP id d3so3516nfc.21
        for <git@vger.kernel.org>; Tue, 24 Jun 2008 05:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=skdCK7Yd5yQlOUyXmGM/7G9LTJEuFpMRJYYd+WmUZuE=;
        b=kK4tWcZUP0kOKeNsu0l2oAXQ/0Q8kZYndfzeo0qkNRsespUG/Kc4CnekAlDAD7SS+m
         InP/ZV00lPV50JmK3InocWy/Bd9dW5K0ZcPJeEB5SA9Yb8PWsRUjuQQTeNE7IjZYBdw1
         1JEooeU4vV7rI0w9bY42qKkMLngB+6i/1+ICM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=jbZ0vVLDF0tMcMzqf3mFsHr8YmhvJdEY1SSf8fBPUMnq9zL4wl341Jn+usnZkES0RW
         K0UxFJCl0JkKGeWYHka7GNQYh527iRuw78k/Uaruc3X3nhGayQcixCstD+/ccPXjhyOT
         HCjG2UX1Sx32rWc+7dVlYgfxt6kq0imYo15HA=
Received: by 10.210.34.2 with SMTP id h2mr126491ebh.122.1214310323746;
        Tue, 24 Jun 2008 05:25:23 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.195.249])
        by mx.google.com with ESMTPS id b33sm10332520ika.2.2008.06.24.05.25.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Jun 2008 05:25:22 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m5OCStgZ007479;
	Tue, 24 Jun 2008 14:28:56 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m5OCSrXi007475;
	Tue, 24 Jun 2008 14:28:53 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <ce513bcc0806240507q58c2a3y5fe8f0e8033353ad@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86044>

"Erez Zilber" <erezzi.list@gmail.com> writes:

> I think that I'm using the right repository for git-clone because it's
> the same path that I used for git push:
> 
> [root@kd001 my_test.git]# git-push --all
> ssh://erez.zilber@kites/pub/git/erez.zilber/my_test.git

[...]
> looks like git-update-server-info did some work (added the refs file).
> 
> Back to the client:
> 
> [root@kd001 t]# git-clone http://kites/pub/git/erez.zilber/my_test.git
> Initialized empty Git repository in /home/erez.zilber/work/tmp/t/my_test/.git/
> Cannot get remote repository information.
> Perhaps git-update-server-info needs to be run there?
> 
> The path is the same path that was used for pushing the repository.
> What did I miss here?

First, obvious question: do you have web server enabled?

Second, less obvious: how this server maps pathname information from
URL into path in the filesystem?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
