From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: Re: update-cache ./test.c
Date: Sun, 1 May 2005 11:04:37 +0200
Message-ID: <20050501090437.GK26663@cip.informatik.uni-erlangen.de>
References: <20050501084145.GA30692@xi.wantstofly.org> <20050501084710.GJ26663@cip.informatik.uni-erlangen.de> <20050501085427.GB30692@xi.wantstofly.org> <20050501085922.GC30692@xi.wantstofly.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun May 01 10:58:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSAHj-0007pm-0x
	for gcvg-git@gmane.org; Sun, 01 May 2005 10:58:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261404AbVEAJEj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 May 2005 05:04:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261567AbVEAJEj
	(ORCPT <rfc822;git-outgoing>); Sun, 1 May 2005 05:04:39 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:9465 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261404AbVEAJEi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2005 05:04:38 -0400
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [131.188.30.103])
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) with ESMTP id j4194bS8010595
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Sun, 1 May 2005 09:04:37 GMT
Received: (from sithglan@localhost)
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) id j4194bZa010594
	for git@vger.kernel.org; Sun, 1 May 2005 11:04:37 +0200 (CEST)
To: GIT <git@vger.kernel.org>
Mail-Followup-To: GIT <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20050501085922.GC30692@xi.wantstofly.org>
X-URL: http://wwwcip.informatik.uni-erlangen.de/~sithglan/
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello,

> --- git/update-cache.c.orig	2005-05-01 10:56:17.859313581 +0200
> +++ git/update-cache.c	2005-05-01 10:57:31.634897508 +0200
> @@ -328,6 +328,7 @@

>  	for (i = 1 ; i < argc; i++) {
>  		char *path = argv[i];
> +		char *_path;

I think there is no need to introduce an extra variable. Just increase
path by two. I knew that it is easy to fix in the code, but I think the
'logic' should go into the frontend not in the backend. But this one is
really easy to fix. Maybe regenerate a patch and sign it off, maybe it
will be included.

Greetings,
	Thomas
