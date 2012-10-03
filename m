From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: erratic behavior commit --allow-empty
Date: Wed, 03 Oct 2012 09:12:55 +0200
Message-ID: <506BE577.900@viscovery.net>
References: <CAB9Jk9BynCunFHRFhGKoyDA-qof1iu6w952sAgSs2_JWb8+U3A@mail.gmail.com> <506AA51E.9010209@viscovery.net> <7vzk449449.fsf@alter.siamese.dyndns.org> <CAB9Jk9CSW0ObJtgsfSwjf+k438=V8i7dP0p+YUehqdh2Z0k6tA@mail.gmail.com> <7vhaqc7in6.fsf@alter.siamese.dyndns.org> <CAB9Jk9D-eJ8goYx7LWqGcWcLgRDS8+qLZVUsvvJ+QOtryP9-zg@mail.gmail.com> <506BCF19.7020800@viscovery.net> <CAB9Jk9DH4Gx-8oJzb8H=ytohhZnMbA92pwj5P25AehmZ3PMmcg@mail.gmail.com> <506BDADE.4010803@viscovery.net> <CAB9Jk9AgtNQfWDr31CWbXf2ag=11du-aruu-0+nOZ3KaaG9=og@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Angelo Borsotti <angelo.borsotti@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 03 09:13:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJJ8r-0007GU-Im
	for gcvg-git-2@plane.gmane.org; Wed, 03 Oct 2012 09:13:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755635Ab2JCHND (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2012 03:13:03 -0400
Received: from so.liwest.at ([212.33.55.24]:5759 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755504Ab2JCHNB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2012 03:13:01 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1TJJ8Z-0004QE-W8; Wed, 03 Oct 2012 09:12:56 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id B45021660F;
	Wed,  3 Oct 2012 09:12:55 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:15.0) Gecko/20120907 Thunderbird/15.0.1
In-Reply-To: <CAB9Jk9AgtNQfWDr31CWbXf2ag=11du-aruu-0+nOZ3KaaG9=og@mail.gmail.com>
X-Enigmail-Version: 1.4.4
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206860>

Cc restored; please reply to all.

Am 10/3/2012 8:32, schrieb Angelo Borsotti:
> Hi Hannes,
> 
> well, I thought I replied to your question:
> 
>    "What is the point in insisting that there is a *really*
>    new commit when the one commit that already existed has exactly the
>    content that you wanted?"
> 
> I wanted to create an orphan branch. I did it with a git checkout
> --orphan sources.
> This command alone does not create a branch; it needs a commit to be done on
> it, but a "real" one. If it is not a "real" one, the branch is
> created, but it is not an
> orphan one.

When you do 'git checkout --orphan sources', you request (nothing more and
nothing less than) that the next commit you make on the new branch
"sources" does not have a parent. But this is exactly what happens: The
next commit you make does not have a parent.

Perhaps you are confused by the fact that the commit you made first does
not have a parent, either. But that is just a "side effect" that it
happened to be the very first commit that you made after 'git init'.

IOW, the second commit that you made has all properties that you
requested. (It just so happens that it is exactly identical to the first
commit you made.) Your case does not demonstrate a bug in git.

Why don't you use a different commit message to ensure that there is a
difference between the commits?

-- Hannes
