From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Which module contains SVN/Core.pm in CPAN
Date: Mon, 18 Feb 2008 03:54:33 -0800 (PST)
Message-ID: <m3ve4ma39o.fsf@localhost.localdomain>
References: <389581.75818.qm@web31805.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: ltuikov@yahoo.com
X-From: git-owner@vger.kernel.org Mon Feb 18 12:55:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JR4aW-0007xa-Jp
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 12:55:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758139AbYBRLyh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 06:54:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758125AbYBRLyh
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 06:54:37 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:51937 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758084AbYBRLyg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 06:54:36 -0500
Received: by ug-out-1314.google.com with SMTP id z38so310112ugc.16
        for <git@vger.kernel.org>; Mon, 18 Feb 2008 03:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=anbgPfuHI4xG5e2KBNOcsDmo217Ep4aHAsj60eTjoXM=;
        b=KnBM03crJZ7YisxJWpFhbZ3wNW0AmXgMRpJe1sJvyELYinJ1HkYFW4dOHnk+ZKzOfCtX65qTzW+SuVYVu3cZCVR5CSVIztj3OBuF7KjBhcHAxWwPWT+K0En+uYj7ANLbaBrwIpzpOZL0FD8eqQSCtj7vhPEuZ4JZO9bNZm5w6HQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=ahPYABlN9iJ4XZyQ4BphCkxrX1pKB9CL4QNDofiroGOCTedbFpnYgy5iyd+AaCRU8bRNpI85OMEsFa/4UOGqXj/ww+txXaVpr6RuUz3oJYrBfWfZOsuT+UMYI0+yZPQmTAhQ2kQaJd8uMKaHQwR19TJ3dVgD7CKn4qmJ8QSg0l8=
Received: by 10.66.251.3 with SMTP id y3mr3061742ugh.88.1203335674817;
        Mon, 18 Feb 2008 03:54:34 -0800 (PST)
Received: from localhost.localdomain ( [83.8.214.240])
        by mx.google.com with ESMTPS id t35sm1571973uge.81.2008.02.18.03.54.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 18 Feb 2008 03:54:33 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m1IBsSfl004312;
	Mon, 18 Feb 2008 12:54:29 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m1IBsRgt004309;
	Mon, 18 Feb 2008 12:54:27 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <389581.75818.qm@web31805.mail.mud.yahoo.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74270>

Luben Tuikov <ltuikov@yahoo.com> writes:

> Example:
> 
> $git-svn clone ...
> Can't locate SVN/Core.pm in @INC (@INC contains: ...
> 
> "i /SVN" gives a hefty list.
> 
> Which module(s) in CPAN gives the minimal set to run "git-svn"?

This module is from Perl bindings distributed with Subversion.
For RPM based systems it is in subversion-perl package; I think
it is similar for Debian based distributions (deb based).

P.S. I was also first tring to find it in CPAN...
-- 
Jakub Narebski
Poland
ShadeHawk on #git
