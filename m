From: David Aguilar <davvid@gmail.com>
Subject: Re: how to see full file with diff marks
Date: Mon, 26 Jan 2009 21:42:33 -0800
Message-ID: <20090127054232.GA6521@gmail.com>
References: <497E92C1.80102@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Ittay Dror <ittay.dror@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 27 06:43:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRgjM-0001yv-FO
	for gcvg-git-2@gmane.org; Tue, 27 Jan 2009 06:43:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751612AbZA0Fl7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 00:41:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751035AbZA0Fl6
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 00:41:58 -0500
Received: from rv-out-0506.google.com ([209.85.198.232]:38197 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750739AbZA0Fl6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 00:41:58 -0500
Received: by rv-out-0506.google.com with SMTP id k40so6236250rvb.1
        for <git@vger.kernel.org>; Mon, 26 Jan 2009 21:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=iGF65uSGvWRMxp6jvCwZ43cF8bmGfnlc7lWRb842Vfg=;
        b=wC/7f+X8FuLB6z1aeqM/kDhLemVKPJ5+0Z4MgUql+VFCZEPy6KAxfskA04FsvNffbw
         7+cT4hqtSZQok5V705h2FhedP+a0UMkJH7wz8QqV6DcqmkBwiDgsCxJ5pItpgZRgJ2DF
         0HO9wNf7RDSq/zgads+R9PPvT+YCogBDEPaIg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=a+gwDYO1Pv72CRDHYmOUCFnNkzgTjc2WjYvbNBu+lO89SlEiPbcBpNqlyV9e8bsP51
         jdHxhx9Uw9J84v6qvc4efsmbaHApgc1uqfKJ4LriVsP5ZJIu1qJRXUrYWxGZOyl+bQ7Y
         Uaf17h0WF+6QK7lbKeStnRpulbFjfQm81ZXYQ=
Received: by 10.140.162.21 with SMTP id k21mr214916rve.256.1233034916955;
        Mon, 26 Jan 2009 21:41:56 -0800 (PST)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id g31sm91618rvb.2.2009.01.26.21.41.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 26 Jan 2009 21:41:56 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <497E92C1.80102@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107312>

On  0, Ittay Dror <ittay.dror@gmail.com> wrote:
> Hi,
>
> I have a large file and I want to view the changes between two commits,  
> but in the context of the whole file, not just hunks. How can I do that?
>
> Thanks
> Ittay

In git.git's contrib/difftool directory there's a script
called 'git-difftool' that can show you changes using our
good friends xxdiff, kdiff3, tkdiff, meld, vimdiff, emerge,
etc.


-- 

	David
