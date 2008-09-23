From: John Freeman <jfreeman@cs.tamu.edu>
Subject: Re: clone fails: Could not get the current working directory
Date: Tue, 23 Sep 2008 09:45:57 -0500
Message-ID: <48D90125.3090703@cs.tamu.edu>
References: <48D59A30.5020403@cs.tamu.edu>	 <81b0412b0809230539x340bd579q3489d5e257b9740@mail.gmail.com>	 <48D8EDDA.3050804@cs.tamu.edu> <81b0412b0809230712u4a1cbe0fo69f558cbe9a26aae@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 23 16:48:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ki9Bf-0005F4-Qz
	for gcvg-git-2@gmane.org; Tue, 23 Sep 2008 16:48:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754314AbYIWOqU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2008 10:46:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754270AbYIWOqT
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Sep 2008 10:46:19 -0400
Received: from smtp-relay.tamu.edu ([165.91.22.120]:41589 "EHLO
	sr-8-int.cis.tamu.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754206AbYIWOqS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2008 10:46:18 -0400
Received: from localhost (localhost.tamu.edu [127.0.0.1])
	by sr-8-int.cis.tamu.edu (Postfix) with ESMTP id 3489B124D9;
	Tue, 23 Sep 2008 09:46:17 -0500 (CDT)
X-Virus-Scanned: amavisd-new at tamu.edu
Received: from [192.168.10.200] (r74-192-200-91.bcstcmta02.clsttx.tl.dh.suddenlink.net [74.192.200.91])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by sr-8-int.cis.tamu.edu (Postfix) with ESMTPSA id 65E5612799;
	Tue, 23 Sep 2008 09:46:16 -0500 (CDT)
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
In-Reply-To: <81b0412b0809230712u4a1cbe0fo69f558cbe9a26aae@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96573>

Alex Riesen wrote:
> Saw them. .bashrc (/etc/bashrc too) is not used for non-interactive 
> sessions,
> like yours (of course, you can source them from
> .profile/.bash_login/.bash_profile).
>
> Have you tried the commands exactly? (Even more interesting would be to try
> a simple getpwd program which prints errno)
>   

I have.  I'm convinced that the problem is not missing commands; if it 
were, I'd be getting a "missing command," or "file not found," or 
similar error.  Like I've said, I am able to get this to work when the 
repo is in my home directory.  It only fails when the repo is on another 
path in the system for which I do not have read privileges all the way 
down - only at the end.

- John
