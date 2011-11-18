From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: A flaw in dep generation with gcc -MMD?
Date: Thu, 17 Nov 2011 21:41:42 -0600
Message-ID: <20111118034142.GA25228@elie.hsd1.il.comcast.net>
References: <CACsJy8BZMDyf4MCiKxPJ5Z+XS+C-MC82SpMFyWgiXmb9xCnScw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 18 04:42:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RRFL6-0003Nj-OT
	for gcvg-git-2@lo.gmane.org; Fri, 18 Nov 2011 04:42:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756106Ab1KRDlz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Nov 2011 22:41:55 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:43598 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755910Ab1KRDlz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Nov 2011 22:41:55 -0500
Received: by ghbz2 with SMTP id z2so74146ghb.19
        for <git@vger.kernel.org>; Thu, 17 Nov 2011 19:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=SlQa9WzkvY1oSKVcAfGx1PFimyo5H7lJXGJX13BhAPI=;
        b=cUd+d1rLJd3z8Xk1ApUg35vwyvQUEyxcVnX6s3/IoaqJbV+htVmRAENpMmoyNQc0ag
         /2QqDUOg6gdN+VprHX3OZ5DA8IoIivPWJ1EE7FBuvz3LMNfiqseRRvcU2f25bgU8RBFk
         Yx2tJX7Wj9mziJ/CfPBE+YUIHm91qj2dLiCqM=
Received: by 10.236.76.136 with SMTP id b8mr2129658yhe.9.1321587714744;
        Thu, 17 Nov 2011 19:41:54 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id j25sm9125885yhm.12.2011.11.17.19.41.53
        (version=SSLv3 cipher=OTHER);
        Thu, 17 Nov 2011 19:41:54 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CACsJy8BZMDyf4MCiKxPJ5Z+XS+C-MC82SpMFyWgiXmb9xCnScw@mail.gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185627>

Nguyen Thai Ngoc Duy wrote:

> My builtin/.depend/add.o.d says
>
> add.o: .... cache.h ...

Interesting.  What compiler do you use?

Thanks for finding it,
Jonathan

 $ head -1 builtin/.depend/add.o.d
 builtin/add.o: builtin/add.c cache.h git-compat-util.h compat/bswap.h \
 $ gcc --version | head -1
 gcc (Debian 4.6.2-4) 4.6.2
