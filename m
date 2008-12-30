From: Anders Melchiorsen <mail@cup.kalibalik.dk>
Subject: Re: many git sites homepages megabytes big
Date: Tue, 30 Dec 2008 12:01:54 +0100
Message-ID: <4959FFA2.4050403@cup.kalibalik.dk>
References: <87r63r374j.fsf@jidanni.org> <m31vvqcvzp.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, jidanni@jidanni.org,
	pasky@ucw.cz
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 30 12:03:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHcNZ-0003WW-Du
	for gcvg-git-2@gmane.org; Tue, 30 Dec 2008 12:03:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751921AbYL3LB4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2008 06:01:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751893AbYL3LB4
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Dec 2008 06:01:56 -0500
Received: from mail.hotelhot.dk ([77.75.163.100]:38054 "EHLO mail.hotelhot.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751880AbYL3LB4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2008 06:01:56 -0500
Received: from mail.hotelhot.dk (localhost [127.0.0.1])
	by mail.hotelhot.dk (Postfix) with ESMTP id D1D4130490;
	Tue, 30 Dec 2008 12:04:04 +0100 (CET)
Received: from [192.168.0.201] (unknown [192.168.0.201])
	by mail.hotelhot.dk (Postfix) with ESMTP id B48F53016A;
	Tue, 30 Dec 2008 12:04:04 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (X11/20081125)
In-Reply-To: <m31vvqcvzp.fsf@localhost.localdomain>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104173>

Jakub Narebski wrote:
> jidanni@jidanni.org writes:
>
>   
>> I notice the web interfaces to many git sites are very risky to just
>> click on. E.g., just clicking http://repo.or.cz/ sends megabytes to
>> the users browser. At least the homepage of such sites should be
>> something lighter in weight.
>>     
>
> That is a bit of historical artifact. Currently the "index" page for
> gitweb installation is 'projects_list' page with _all_ the projects
> hosted. It is not split into pages, like for example 'log' or 'heads'
> views are; there were some patches for that, but would have to be
> redone as the area changed a bit since. It could have been replaced by
> projects search page...
>
> It is a bit of historical reason.
>   

For the specific case of repo.or.cz, I guess that turning on HTTP 
compression might help a lot.


Anders.
