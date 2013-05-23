From: Jeremy Rosen <jeremy.rosen@openwide.fr>
Subject: Re: first parent, commit graph layout, and pull merge direction
Date: Thu, 23 May 2013 12:07:52 +0200 (CEST)
Message-ID: <1639906933.2666673.1369303672919.JavaMail.root@openwide.fr>
References: <CAEBDL5WqYPYnU=YoCa2gMzcJCxeNbFmFgfWnHh=+HuouXLLsxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Andreas Krey <a.krey@gmx.de>
To: John Szakmeister <john@szakmeister.net>
X-From: git-owner@vger.kernel.org Thu May 23 12:07:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfSRC-0006j7-O8
	for gcvg-git-2@plane.gmane.org; Thu, 23 May 2013 12:07:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757975Ab3EWKHz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 May 2013 06:07:55 -0400
Received: from zimbra3.corp.accelance.fr ([213.162.49.233]:54035 "EHLO
	zimbra3.corp.accelance.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757935Ab3EWKHy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 May 2013 06:07:54 -0400
Received: from localhost (localhost [127.0.0.1])
	by zimbra3.corp.accelance.fr (Postfix) with ESMTP id AF1A1280A6;
	Thu, 23 May 2013 12:07:53 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra3.corp.accelance.fr
Received: from zimbra3.corp.accelance.fr ([127.0.0.1])
	by localhost (zimbra3.corp.accelance.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DjJ2f9bl0r4L; Thu, 23 May 2013 12:07:53 +0200 (CEST)
Received: from zimbra2.corp.accelance.fr (zimbra2.corp.accelance.fr [213.162.49.232])
	by zimbra3.corp.accelance.fr (Postfix) with ESMTP id 3AD12280A1;
	Thu, 23 May 2013 12:07:53 +0200 (CEST)
In-Reply-To: <CAEBDL5WqYPYnU=YoCa2gMzcJCxeNbFmFgfWnHh=+HuouXLLsxg@mail.gmail.com>
X-Originating-IP: [213.162.49.238]
X-Mailer: Zimbra 7.2.2_GA_2852 (ZimbraWebClient - GC27 (Linux)/7.2.2_GA_2852)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225232>


----- Mail original -----
> On Thu, May 23, 2013 at 5:06 AM, Andreas Krey <a.krey@gmx.de> wrote:
> [snip]
> > ...
> >> Don't do that, then.
> >
> > :-) Problem is, in this case 'I' expands to about
> >     1<<7 people I need to educate on this.
> 
> This is a feature of `git pull` that I really despise.  I really wish
> `git pull` treated the remote as the first parent in its merge
> operation.
> 

seconded...

github's network pages (which display the commit graph of projects) seems to follow the "first parent at the top" rule and the pull merges are standing out as "wrong" because of that...
