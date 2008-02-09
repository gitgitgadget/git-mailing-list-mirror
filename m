From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH] Improve git-help--browse browser support under OS X
Date: Sat, 9 Feb 2008 23:20:20 +0300
Message-ID: <20080209202020.GD30368@dpotapov.dyndns.org>
References: <1202505794-13409-1-git-send-email-jaysoffian+git@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jay Soffian <jaysoffian@gmail.com>
To: jaysoffian+git@gmail.com
X-From: git-owner@vger.kernel.org Sat Feb 09 21:21:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNwCB-0006rJ-7P
	for gcvg-git-2@gmane.org; Sat, 09 Feb 2008 21:21:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755578AbYBIUUe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2008 15:20:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755543AbYBIUUe
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 15:20:34 -0500
Received: from fg-out-1718.google.com ([72.14.220.153]:25374 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755532AbYBIUUd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2008 15:20:33 -0500
Received: by fg-out-1718.google.com with SMTP id e21so3272821fga.17
        for <git@vger.kernel.org>; Sat, 09 Feb 2008 12:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        bh=glgur6MSl1I2BWtD6gwuDkD1hyGtBBqv222lZ1DoDIw=;
        b=hISyT05RmyhWOrk+B4+tse671yqNPUjxvKdDBlXPD3EW/ctl6V0DwYJCQVdynTzXamV0OmKfMXmDi0KKz2np3+CGC0FB4+JJvkrLxIqI6rzNljbl+e79bw6xYFDvc2fGiRRq+60oBg40gK+yRQJo9tNPmQbA0zMYNfLxqfZRwMQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=dzRUi7j0Oo29l6NgbxVddldQdhIy6AWxVLrjzUisBcRth/4inskRZZXZOScQHrenpLb+ZoWhmla4doV90jNXzyuy+U/hauyOgd5TTrf0upLSs4tGMCoD16HhH2vwrvUXTEGkl0a3jMQh2Q/kcAbaFKozproq3ma/PPLm4yTFRdg=
Received: by 10.86.53.8 with SMTP id b8mr13208173fga.32.1202588429280;
        Sat, 09 Feb 2008 12:20:29 -0800 (PST)
Received: from localhost ( [85.140.169.229])
        by mx.google.com with ESMTPS id e11sm4252629fga.5.2008.02.09.12.20.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 09 Feb 2008 12:20:28 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1202505794-13409-1-git-send-email-jaysoffian+git@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73261>

On Fri, Feb 08, 2008 at 04:23:14PM -0500, jaysoffian+git@gmail.com wrote:
> /usr/bin/open <document> is used under OS X to open a document just as if the
> user had double-clicked on the file's icon. In other words, this will open HTML
> files with the user's default browser. Note however that whether the document
> opens in a new window, or in a new tab depends upon the browser configuration.

This is OS X specific, so the change should be made in such a way that it
will not affect anyone else. Because people on other platforms may have
"open" to do different things. For example, on Linux, the "open" command
is used to open a new virtual terminal. At the same time, other systems
may have their own ways to start the default browser. For instance, on
Debian based systems, it is usually x-www-browser for X and www-browser
for terminal.

Dmitry
