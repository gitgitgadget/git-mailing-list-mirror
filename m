From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: Re: git multisite setup
Date: Tue, 17 Nov 2009 01:13:20 +0100
Message-ID: <20091117001320.GA13074@vidovic>
References: <13f0168a0911161018r6fc67d29n781cca670a66815b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
To: Matt Di Pasquale <liveloveprosper@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 17 01:13:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NABhO-0001Oc-V8
	for gcvg-git-2@lo.gmane.org; Tue, 17 Nov 2009 01:13:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754818AbZKQANY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Nov 2009 19:13:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754730AbZKQANY
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Nov 2009 19:13:24 -0500
Received: from ey-out-2122.google.com ([74.125.78.25]:48470 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754517AbZKQANX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Nov 2009 19:13:23 -0500
Received: by ey-out-2122.google.com with SMTP id 9so2107188eyd.19
        for <git@vger.kernel.org>; Mon, 16 Nov 2009 16:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=vd0DRUaaTB3jPwVz2vzkdghWAVBj2Ct9fC1hptNDkr4=;
        b=g2sNlsFcXD+EJqLlZaq5CDQU3qZvoR72596mysIuV/bBLQsFinrwBmVYggrbD202C3
         gsxl2K0iK+E0WGuRVARpD805ZN8pBSXlppJwoXF3DC7z7NkADaYuiVipg3R7ZGqKyuRz
         Ip3RK/EbrLjmWgUKjHjSd1Dj6PUAWyaWPIfig=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=irNUEyZRmo9LdYYp52VMNnlNZKjIsb4Cvyg/8xPDcNLmN6bFjDM47FATCxBeR+u8zX
         HZIv7iMz/OpVyB8WQpUYDTkeFf4gKistAoGj3nXw+tBT1SSNDBUuVv8Jfa2RofbTX+hy
         M6p42kWPmO6uomA7oTeDruiaZliJ47sCUNlTc=
Received: by 10.213.110.206 with SMTP id o14mr2182003ebp.6.1258416808700;
        Mon, 16 Nov 2009 16:13:28 -0800 (PST)
Received: from @ (91-164-137-149.rev.libertysurf.net [91.164.137.149])
        by mx.google.com with ESMTPS id 7sm2336026eyg.41.2009.11.16.16.13.22
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 16 Nov 2009 16:13:26 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <13f0168a0911161018r6fc67d29n781cca670a66815b@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133043>

The 16/11/09, Matt Di Pasquale wrote:

> In my sites folder i have folders for different sites of mine:
> example.com example2.com, and i also have generic files like an
> includes dir and a .htaccess file that all sites use. what is the best
> way to track the generic files and the different sites?
> 
> i was thinking each site has its own .git repo. and then make a .git
> repo for my sites folder but ignore the individual sites dirs.
> actually that's what i'm doing now.

This looks good to me. Why would you like to change?

-- 
Nicolas Sebrecht
