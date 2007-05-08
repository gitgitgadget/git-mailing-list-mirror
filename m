From: "Dave Hanson" <drh@drhanson.net>
Subject: Re: importing multi-project svn repositories
Date: Mon, 7 May 2007 20:48:26 -0700
Message-ID: <9fb1551c0705072048u3ff85ea7n5166596855b8f322@mail.gmail.com>
References: <C05C5EF4-EC68-490B-946E-630117393F4E@drhanson.net>
	 <463F6A95.30207@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Steven Grimm" <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Tue May 08 05:49:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlGhA-0002u3-Eb
	for gcvg-git@gmane.org; Tue, 08 May 2007 05:49:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967729AbXEHDs3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 May 2007 23:48:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967719AbXEHDs3
	(ORCPT <rfc822;git-outgoing>); Mon, 7 May 2007 23:48:29 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:65014 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967729AbXEHDs2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2007 23:48:28 -0400
Received: by ug-out-1314.google.com with SMTP id 44so35751uga
        for <git@vger.kernel.org>; Mon, 07 May 2007 20:48:27 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=FlwyIpbjd8eyPNtmXZ7W2xQe4cJrFNhDrKrx6naj1H3rHVKrqjf7YKSnwP9cd1EHwYqHGGsPqV168c3OQVeL3px+1Kxs09Ssh2mV4aGUPEf8JMXsNqxas8U77ugTafsVug6R/0YPnoLRwbLHekIYMRT2AVgJYGB9ih8DDQAMXY4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=VEzY2rbSzaUobIjbZWyNc7OPmSvf3osDPwJVO+pPyAC1DA1pt/JDYBZNbgKkv4mXcNI9cJTzlqEG/c8qcy5G90HLgBAoHhhPmLkD6YX/y0BDYjRj0o1Bkn8Za5Ie5G/WMho64/2EPzyoedbTCO1UY6Ab4fh2PRVs00QW235PWT4=
Received: by 10.82.136.4 with SMTP id j4mr10974660bud.1178596106910;
        Mon, 07 May 2007 20:48:26 -0700 (PDT)
Received: by 10.82.107.19 with HTTP; Mon, 7 May 2007 20:48:26 -0700 (PDT)
In-Reply-To: <463F6A95.30207@midwinter.com>
Content-Disposition: inline
X-Google-Sender-Auth: cf527ba579250c65
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46531>

On 5/7/07, Steven Grimm <koreth@midwinter.com> wrote:
> David Hanson wrote:
> > I'd like to import calc at the top level, put calc/tags/foo in git's
> > tags/calc/foo and calc/branches/baz in git's heads/calc/baz. Ditto for
> > calendar, spreadsheet, etc.
>
> Try git-svn rather than git-svnimport. The latter, AFAIK, is no longer
> really maintained. ...

Thanks for the tip. I was running git 1.5.0, which didn't support
"clone" to git-svn. I upgraded to 1.5.1.3 and followed your
suggestions.

If I decide to flush the svn repository in favor of git, I'll probably
do some manual rearrangement so that commands like "git tag -l" gives
useful results.
thanks,
dave h
