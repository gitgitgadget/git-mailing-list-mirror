From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: Git 1.1.6.g4d44 make test FAILURE report
Date: Fri, 10 Feb 2006 17:37:23 -0800
Message-ID: <43ED3FD3.7020005@gmail.com>
References: <43ED0368.7020204@gmail.com> <7vhd76vqrg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 11 02:37:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F7jhp-0003y1-2F
	for gcvg-git@gmane.org; Sat, 11 Feb 2006 02:37:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750721AbWBKBhc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Feb 2006 20:37:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750762AbWBKBhc
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Feb 2006 20:37:32 -0500
Received: from pproxy.gmail.com ([64.233.166.178]:43616 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750721AbWBKBhb (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Feb 2006 20:37:31 -0500
Received: by pproxy.gmail.com with SMTP id o67so347112pye
        for <git@vger.kernel.org>; Fri, 10 Feb 2006 17:37:31 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=FJwrbjWwZpYYx5zqOEb6dDHOpaISEsLDrawgs8LLx1WhKyBVD7MaSy+ls8fFNSg5cg17hqnAhCG4Xjd4SovqmmjMwlN/v7LAf0gujNAUs9pCP6Dr7YS+1r69QXDfD/QIC+mtVd4g1Al+vCjlxhrKc3JXo5IYJ3yOvQtk9At82Cc=
Received: by 10.35.84.12 with SMTP id m12mr536890pyl;
        Fri, 10 Feb 2006 17:37:30 -0800 (PST)
Received: from ?10.0.0.6? ( [68.234.172.144])
        by mx.gmail.com with ESMTP id n62sm192071pyf.2006.02.10.17.37.24;
        Fri, 10 Feb 2006 17:37:30 -0800 (PST)
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vhd76vqrg.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15912>

Junio C Hamano wrote:
> Thanks; good catch.  I think we should export GIT_*_{NAME,EMAIL}
> variables explicitly for this particular problem.  We probably
> do _not_ want to do the same for GIT_*_DATE though.

Also, git-var complains when used by an account with an empty gcos 
field; thereby, breaking all the non-C git commands even when the user 
is not committing.

If the _intent_ was to force commiters and author names in commits, why 
was the test not placed only in commit-tree.c?
