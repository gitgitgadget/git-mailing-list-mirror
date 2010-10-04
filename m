From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Useful tracking branches and auto merging
Date: Mon, 4 Oct 2010 15:46:25 -0500
Message-ID: <20101004204625.GH6466@burratino>
References: <AANLkTimq0sKUavKiXepDOz+DvrymuRAVUyAyV+FzbCBD@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 04 22:50:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2rzW-0001LM-E2
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 22:50:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932737Ab0JDUtr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Oct 2010 16:49:47 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:47259 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757085Ab0JDUto (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 16:49:44 -0400
Received: by ewy23 with SMTP id 23so2235971ewy.19
        for <git@vger.kernel.org>; Mon, 04 Oct 2010 13:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=ImKZSAucdmr/vt/l9t6olfQgTMZvtzW3zLk/hgDjZrE=;
        b=ZKGkJ+FZsDzNbyDj0laln0sZMcIu2kXS/RkB+yOMVJdgmrGL5e0UqwXAlJ7VIduxin
         TbwQ9drEQiwdKDDkvGOydX6Ic+6ruu7UeHXHbSXEDKSHVZisKeuXFi8Ad5XQihGxT38Q
         8zClljlnECKs68JPKZl6DiMIVQwiC17/SOK3Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=AkWCXyVefKowXnepGVOSbFHaPE7Nj6UaNzFVRHaI3cC5x/ZLZT8EioXBP6PWtjnrun
         TdSOM+v8/rxsj95yLj0wqelfdP3brqKxgACAAhi+ukE+ElHCgBs7jJmKES3Sys3XSujd
         F0OxR6/LMyI/EhYf5Ao56d9M3SgqZyfwcdTHg=
Received: by 10.223.105.71 with SMTP id s7mr9686520fao.8.1286225382903;
        Mon, 04 Oct 2010 13:49:42 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id a6sm2491291faa.20.2010.10.04.13.49.40
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 04 Oct 2010 13:49:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTimq0sKUavKiXepDOz+DvrymuRAVUyAyV+FzbCBD@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158112>

Felipe Contreras wrote:

>  Your branch is behind 'origin/master' by 17 commits, and can be fast-forwarded.
> 
> This message doesn't tell me _how_ I can 'fast-forward', I do 'git
> merge origin/master' but if git already knows 'master' is tracking
> 'origin/master' why should I specify that? Perhaps 'git merge
> --tracking'.

git merge @{u}

> But, while we are on that, why not automatically merge the tracking
> branches?

Maybe 'git pull --all' could be taught to eventually do this?  That
would be incompatible with its current behavior of fetching everything
and merging some random branch, but I don't think anyone is relying
on that.
