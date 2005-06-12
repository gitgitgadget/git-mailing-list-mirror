From: Dan Holmsand <holmsand@gmail.com>
Subject: Re: [PATCH] cg-Xlib: make showdate show timezone
Date: Sun, 12 Jun 2005 19:37:06 +0200
Message-ID: <42AC72C2.8000807@gmail.com>
References: <42AC1F49.9010808@gmail.com> <20050612115259.GD6620@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 12 19:33:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DhWKe-0003p1-7I
	for gcvg-git@gmane.org; Sun, 12 Jun 2005 19:33:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262659AbVFLRhU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Jun 2005 13:37:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262660AbVFLRhT
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Jun 2005 13:37:19 -0400
Received: from wproxy.gmail.com ([64.233.184.201]:63861 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262659AbVFLRhP (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Jun 2005 13:37:15 -0400
Received: by wproxy.gmail.com with SMTP id 68so1358026wra
        for <git@vger.kernel.org>; Sun, 12 Jun 2005 10:37:15 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=AFhX4K2TJe2dGpBOKprwe2sVYEP+NUuPCNQkHJU5o0pJeO+1+aX1cHmk3W1E9KE2PDcDkKAC2lHZizAShunJW0pFRXFDeNIOojaNN+lZoqKzVlj9cZVtWY9nevXHz3FlJzO3n1wfkYZrVU/FRCTJ5hUXcnBEsOT4UiJXZZNKwjs=
Received: by 10.54.25.52 with SMTP id 52mr2297288wry;
        Sun, 12 Jun 2005 10:37:14 -0700 (PDT)
Received: from ?213.114.31.152? ([213.114.31.152])
        by mx.gmail.com with ESMTP id 13sm3344626wrl.2005.06.12.10.37.13;
        Sun, 12 Jun 2005 10:37:14 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050404)
X-Accept-Language: en-us, en
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050612115259.GD6620@pasky.ji.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Petr Baudis wrote:
> Thanks, applied. But what's the point of calling date with LANG=C? If
> the user wants his locale to get used, why prevent him?

Because otherwise, you won't get an RFC-2822 date (which is what you 
explicitly wanted a couple of days ago, and what we had before).

Also, it would look pretty awkward to have parts of the output localized 
  (the date string), and all other parts not ("author", "date", whatnot).

/dan
