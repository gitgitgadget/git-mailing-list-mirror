From: Mauro Carvalho Chehab <mchehab@redhat.com>
Subject: Re: Linux 3.1-rc5
Date: Mon, 05 Sep 2011 17:26:39 -0300
Message-ID: <4E65307F.5020103@redhat.com>
References: <CA+55aFxDjVJwbpP5YT4o=qud=OcxtT3Ry4HfCtW-FvNdj+RFeQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Sep 05 22:27:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0flS-0002bq-N0
	for gcvg-git-2@lo.gmane.org; Mon, 05 Sep 2011 22:27:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753842Ab1IEU1R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Sep 2011 16:27:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:4055 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753780Ab1IEU1Q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Sep 2011 16:27:16 -0400
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p85KQgjY002589
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Mon, 5 Sep 2011 16:26:42 -0400
Received: from [10.11.8.165] (vpn-8-165.rdu.redhat.com [10.11.8.165])
	by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id p85KQdsN031247;
	Mon, 5 Sep 2011 16:26:40 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0) Gecko/20110812 Thunderbird/6.0
In-Reply-To: <CA+55aFxDjVJwbpP5YT4o=qud=OcxtT3Ry4HfCtW-FvNdj+RFeQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180758>

Em 04-09-2011 20:27, Linus Torvalds escreveu:

> One thing to note: If you just do
> 
>    git pull https://github.com/torvalds/linux.git
> 
> you probably won't get the tags, since it's not your origin branch. So do
> 
>    git fetch --tags<...>
> 
> too, so that you get not only the actual changes, but the tag that you
> can verify too.
> 

It would be great if "git remote update" could also verify the tag
signature (if present), as most of us just do a "git remote update".

Maybe an extra parameter for git config remote.tagopt?

Ok, if in doubt, we can always use git tag -v <new tag>, but doing
it automagically would help us to detect if a git tag got mangled
by some  at the moment we update our trees, with seems to be
a good idea.

Thanks,
Mauro
