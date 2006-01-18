From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: "tla missing -s" equivalent with git/cogito
Date: Thu, 19 Jan 2006 08:07:27 +1300
Message-ID: <46a038f90601181107h57e6fb73peb199689349aec41@mail.gmail.com>
References: <43CE5666.90502@itaapy.com>
	 <46a038f90601180956r69ba5dffl2106f697a6be4750@mail.gmail.com>
	 <20060118185542.GT28365@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: luis@itaapy.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 18 20:07:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EzIea-00066x-K5
	for gcvg-git@gmane.org; Wed, 18 Jan 2006 20:07:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030281AbWARTH3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jan 2006 14:07:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030355AbWARTH3
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jan 2006 14:07:29 -0500
Received: from wproxy.gmail.com ([64.233.184.204]:7462 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030281AbWARTH2 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jan 2006 14:07:28 -0500
Received: by wproxy.gmail.com with SMTP id 70so13176wra
        for <git@vger.kernel.org>; Wed, 18 Jan 2006 11:07:27 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=W9am2ovt3jUf2jaHqDEGyDKYJVxQQK1KjeHdAcp9rax+r8XbDRpiexyiSnOXrs6VXnorxnjC7337AeQ+YEd8SK+sWGg97qZ9K6RcwLt7vSyyHp98HXzGZVefIj1Od1cLfZdKOrr/ZSKiRS4eXtshj23GJngPgcVf+4sInt3OgwY=
Received: by 10.54.93.7 with SMTP id q7mr7745717wrb;
        Wed, 18 Jan 2006 11:07:27 -0800 (PST)
Received: by 10.54.127.13 with HTTP; Wed, 18 Jan 2006 11:07:27 -0800 (PST)
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060118185542.GT28365@pasky.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14858>

On 1/19/06, Petr Baudis <pasky@suse.cz> wrote:
> Now you want to merge the branch as a whole. Cherrypicking-aware VCS
> would just merge the patch2, but you are taking the whole diff:
...
> And you get a conflict instead of b\nc.

While I haven't tested your particular example, it looks to me like
git-cherry would identify it correctly. So far my experience has been
that git-cherry's strategy detects my cherry-picked patches pretty
well.

Why would it not work in your example? Patch 1 has clearly been
applied in both branches, and git-cherry would normally detect that
alright.

btw, when is cg-merge switching to use git-merge? :-p



martin
