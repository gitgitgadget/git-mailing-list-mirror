From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: rebase fails mid way through due to locally modified file?
Date: Thu, 11 Oct 2012 12:35:22 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.1210111234150.2378@ds9.cixit.se>
References: <CANRUUDNoUNMy1qHkYt-_wwxGtWrRY9vi8-CjzY8WhJ2gur+zTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Git Mailing List <git@vger.kernel.org>
To: skillzero@gmail.com
X-From: git-owner@vger.kernel.org Thu Oct 11 13:35:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TMH3C-0008BU-Qu
	for gcvg-git-2@plane.gmane.org; Thu, 11 Oct 2012 13:35:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758562Ab2JKLf2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Oct 2012 07:35:28 -0400
Received: from upper-gw.cixit.se ([92.43.32.133]:47280 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1758403Ab2JKLf1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Oct 2012 07:35:27 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-9.4) with ESMTP id q9BBZMvN015024
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 11 Oct 2012 13:35:22 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id q9BBZMqs015021;
	Thu, 11 Oct 2012 13:35:22 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <CANRUUDNoUNMy1qHkYt-_wwxGtWrRY9vi8-CjzY8WhJ2gur+zTg@mail.gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.3.7 (mail.cixit.se [127.0.0.1]); Thu, 11 Oct 2012 13:35:22 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207473>

skillzero@gmail.com:

> I frequently see rebase fail after applying several commits because
> git thinks there are local changes.

What operating system are you running on? I have seen simlar issues on 
Windows, which has a case-insensitive file system, in repositories 
where file names have either changed just the casing of their names, 
or there has been several files where the only difference in names 
were only character casing.

-- 
\\// Peter - http://www.softwolves.pp.se/
