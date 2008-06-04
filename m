From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: list all the untrack files in a git respo
Date: Wed, 04 Jun 2008 07:19:48 -0700 (PDT)
Message-ID: <m3abi1z3if.fsf@localhost.localdomain>
References: <75b57c110806040705mc324d9dx9ce099593ce967dd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Gerb Stralko" <gerb.stralko@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 04 16:21:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3tr4-0003b8-P6
	for gcvg-git-2@gmane.org; Wed, 04 Jun 2008 16:20:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753228AbYFDOTx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2008 10:19:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753179AbYFDOTx
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jun 2008 10:19:53 -0400
Received: from gv-out-0910.google.com ([216.239.58.190]:22156 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753071AbYFDOTw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2008 10:19:52 -0400
Received: by gv-out-0910.google.com with SMTP id e6so36944gvc.37
        for <git@vger.kernel.org>; Wed, 04 Jun 2008 07:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=SfXCpO2Yg6aDF0z3SkqPQCaeyw0LQOn5bugGDD4wMh8=;
        b=khrDJte2IANQ/CF9PlSS5jPR5AhB3B85hKImhgyeejH+cSg+zApzl8nuLrlj8M05rf
         59lTiyJ9cbWWUKnLsp9+RzDYGhp7VJdJQTeqKUVpoG+5dr3Y1fFrgqZkzoYhBw5medJk
         ld3ZJ4W38+JJUxepr3UQL6wWJ1WyYYclve680=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=od5QEz2/Vhl95hWcohwBb6SO5tilCVEr7NHcJFhPJDTaXfq6fTGntxIBz26eieII2Y
         2MOD2viGQG2gLCFBGROWRnH4IToLc/8jBAB766ObnbVW9QV70iiNkGRQGg5yqsvoaGlc
         wzfkc95O/8gWhfOC+e665NFVP+T34k/PFiV7I=
Received: by 10.78.134.6 with SMTP id h6mr41306hud.68.1212589190707;
        Wed, 04 Jun 2008 07:19:50 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.210.131])
        by mx.google.com with ESMTPS id 30sm997961hue.55.2008.06.04.07.19.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 04 Jun 2008 07:19:48 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m54EJgEv009191;
	Wed, 4 Jun 2008 16:19:43 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m54EJajr009188;
	Wed, 4 Jun 2008 16:19:36 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <75b57c110806040705mc324d9dx9ce099593ce967dd@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83782>

"Gerb Stralko" <gerb.stralko@gmail.com> writes:

> Is there a way to list only the untracked files in git? git status
> works, but i need to do some parsing in order to get a list of
> untracked files.  Something like git status --show-only-untracked?

git-status is porcelain, meant for human consumption.  For list
of untracked files use

  $ git ls-files --other --exclude-standard

-- 
Jakub Narebski
Poland
ShadeHawk on #git
