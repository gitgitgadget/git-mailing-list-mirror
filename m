From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: repo.or.cz renovation
Date: Mon, 17 Mar 2008 14:09:01 -0700 (PDT)
Message-ID: <m3iqzlvz11.fsf@localhost.localdomain>
References: <20080313231413.27966.3383.stgit@rover>
	<76718490803131707g34fd40d4q21c69391c2597bc@mail.gmail.com>
	<20080314002205.GL10335@machine.or.cz>
	<1205454999.2758.14.camel@localhost.localdomain>
	<20080317174934.GC6803@machine.or.cz>
	<1205779482.2758.52.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: "J.H." <warthog19@eaglescrag.net>
X-From: git-owner@vger.kernel.org Mon Mar 17 22:10:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JbMay-00062D-QD
	for gcvg-git-2@gmane.org; Mon, 17 Mar 2008 22:10:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753638AbYCQVJK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2008 17:09:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753388AbYCQVJI
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Mar 2008 17:09:08 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:19660 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752292AbYCQVJH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2008 17:09:07 -0400
Received: by fg-out-1718.google.com with SMTP id l27so1953415fgb.17
        for <git@vger.kernel.org>; Mon, 17 Mar 2008 14:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=l957WzxoS9Cku5dON2YscPtHjA4BjGvslRJAXv8Nqcw=;
        b=g/pASBcdjwKZl/vljqIbZoDBGIV1OYMCn1aXlux8ZrEBL+Ib0DcQ6SV2O9ssth0vAsZSYmBRw6nxWE+3E3V2LPTiBfxRWSWzaSWfh7Ka4z8R7ZN6/Bj0tL23WeOGp0xC24cRsfhULWJZ3fmIy0G4CsyWSRJCMIq+YxwIl6gJMq0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=CNxkpX9GjtEfBpfvGe+Mwik7fzisxMotn0LLOU5vHWchH21ZBMF/riRkVw7lg50FsMG7qt0YO0cMpkP9+8COkwobcMjnNwPT5PohctmFo1G2Rq4tGsQ4rlnoY/BR53JUIvGttU9FZMJ2Dfmt9YkMrFoMRdZyTg3Rb0qSKz8ITH8=
Received: by 10.86.98.18 with SMTP id v18mr9227597fgb.52.1205788142323;
        Mon, 17 Mar 2008 14:09:02 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.213.235])
        by mx.google.com with ESMTPS id d4sm20001264fga.2.2008.03.17.14.08.59
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 17 Mar 2008 14:09:01 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m2HL8xSl016791;
	Mon, 17 Mar 2008 22:09:00 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m2HL8wne016788;
	Mon, 17 Mar 2008 22:08:58 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1205779482.2758.52.camel@localhost.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77465>

"J.H." <warthog19@eaglescrag.net> writes:

> BTW I'm about halfway through refactoring my tree from multiple files
> back to one, which at that point means I can start bringing it back into
> mainline and getting a patch series ready for submission.

BTW it would be nice to have a merge strategy (blame-based perhaps?)
which would allow to merge changes to split project easily into
original, single file one...  But I guess you are not interested in
writing such a merge strategy just for this ;-)

-- 
Jakub Narebski
Poland
ShadeHawk on #git
