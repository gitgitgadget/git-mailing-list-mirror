From: Jeremy Rosen <jeremy.rosen@openwide.fr>
Subject: Re: Questions/investigations on git-subtree and tags
Date: Thu, 7 Mar 2013 13:50:11 +0100 (CET)
Message-ID: <1721159119.197038.1362660611167.JavaMail.root@openwide.fr>
References: <CALeLG_k=8S0Q-89CUvNPQT91gkJm1NdDN6YtCkdTQZZi9RUjWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Paul Campbell <pcampbell@kemitix.net>
X-From: git-owner@vger.kernel.org Thu Mar 07 13:50:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDaHT-0004Ov-3c
	for gcvg-git-2@plane.gmane.org; Thu, 07 Mar 2013 13:50:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755822Ab3CGMuO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Mar 2013 07:50:14 -0500
Received: from zimbra3.corp.accelance.fr ([213.162.49.233]:52954 "EHLO
	zimbra3.corp.accelance.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752772Ab3CGMuN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Mar 2013 07:50:13 -0500
Received: from localhost (localhost [127.0.0.1])
	by zimbra3.corp.accelance.fr (Postfix) with ESMTP id 1A906281DE;
	Thu,  7 Mar 2013 13:50:12 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra3.corp.accelance.fr
Received: from zimbra3.corp.accelance.fr ([127.0.0.1])
	by localhost (zimbra3.corp.accelance.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5Qj7ZR7wMGoU; Thu,  7 Mar 2013 13:50:11 +0100 (CET)
Received: from zimbra2.corp.accelance.fr (zimbra2.corp.accelance.fr [213.162.49.232])
	by zimbra3.corp.accelance.fr (Postfix) with ESMTP id 5612E280AD;
	Thu,  7 Mar 2013 13:50:11 +0100 (CET)
In-Reply-To: <CALeLG_k=8S0Q-89CUvNPQT91gkJm1NdDN6YtCkdTQZZi9RUjWA@mail.gmail.com>
X-Originating-IP: [213.162.49.238]
X-Mailer: Zimbra 7.2.2_GA_2852 (ZimbraWebClient - GC25 (Linux)/7.2.2_GA_2852)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217595>

> >>
> >> Git subtree ignores tags from the remote repo.
> >>
> >
> > is that a design decision or a case of "not implemented yet"
> 
> I'm not sure. If you imported all the tags from all your subtrees
> repos, you could easily end up with duplicate tags from different
> repos. They could be namespaced, but there is no concept of namespace
> in git-subtree. That even assumes that you can tag a subtree (I've
> not
> tried).
> 

Ok, I can understand that you don't want to import tags for namespace reason, but in that case shouldn't 
git subtree add refuse to create a subtree when the tag isn't a commit

or if it allows it, what would be the gracefull way to handle that ?

i'm quite new to git's internals, so I don't really know if/what the right approch would be.

note that all those problems seems to disapear when squash is not used
