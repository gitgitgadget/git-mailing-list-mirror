From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: Update *.po with git.pot?
Date: Sat, 19 Mar 2016 07:53:12 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.11.1603190750550.16189@perkele.intern.softwolves.pp.se>
References: <CAN0XMO+8PQNXPRgROd9oVqHzTsgLo_k1yP-MLpqK5N44+1ShDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Xin Jiang <worldhello.net@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?VISCII?Q?Tr=A5n_Ng=F7c_Qu=E2n?= <vnwildman@gmail.com>,
	DJm00n@mail.ru, Marco Sousa <marcomsousa@gmail.com>,
	cwryu@debian.org, Marco Paolone <marcopaolone@gmail.com>,
	=?ISO-8859-15?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	=?ISO-8859-15?Q?Jean-No=EBl_Avila?= <jn.avila@free.fr>,
	Alex Henrie <alexhenrie24@gmail.com>,
	Alexander Shopov <ash@kambanaria.org>,
	git <git@vger.kernel.org>
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 19 07:59:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahAqo-00035p-Oq
	for gcvg-git-2@plane.gmane.org; Sat, 19 Mar 2016 07:59:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751113AbcCSG65 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Mar 2016 02:58:57 -0400
Received: from lamora.getmail.no ([84.210.184.7]:51635 "EHLO lamora.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750823AbcCSG65 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Mar 2016 02:58:57 -0400
X-Greylist: delayed 341 seconds by postgrey-1.27 at vger.kernel.org; Sat, 19 Mar 2016 02:58:57 EDT
Received: from localhost (localhost [127.0.0.1])
	by lamora.getmail.no (Postfix) with ESMTP id C9361C9D0C;
	Sat, 19 Mar 2016 07:53:12 +0100 (CET)
Received: from lamora.getmail.no ([127.0.0.1])
	by localhost (lamora.get.c.bitbit.net [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 1v_CNvQmK7KG; Sat, 19 Mar 2016 07:53:12 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lamora.getmail.no (Postfix) with ESMTP id 4A7FBC9DD7;
	Sat, 19 Mar 2016 07:53:12 +0100 (CET)
X-Virus-Scanned: amavisd-new at lamora.get.c.bitbit.net
Received: from lamora.getmail.no ([127.0.0.1])
	by localhost (lamora.get.c.bitbit.net [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ue7LRDVwmvCu; Sat, 19 Mar 2016 07:53:12 +0100 (CET)
Received: from perkele.intern.softwolves.pp.se (cm-84.215.167.145.getinternet.no [84.215.167.145])
	by lamora.getmail.no (Postfix) with ESMTPSA id 12AB2C9F2A;
	Sat, 19 Mar 2016 07:53:12 +0100 (CET)
Received: from peter (helo=localhost)
	by perkele.intern.softwolves.pp.se with local-esmtp (Exim 4.84)
	(envelope-from <peter@softwolves.pp.se>)
	id 1ahAl6-0004EU-6M; Sat, 19 Mar 2016 07:53:12 +0100
In-Reply-To: <CAN0XMO+8PQNXPRgROd9oVqHzTsgLo_k1yP-MLpqK5N44+1ShDQ@mail.gmail.com>
User-Agent: Alpine 2.11 (DEB 23 2013-08-11)
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289287>

Ralf Thielow:

> Since translations are made in one commit, this commit is messed up 
> with the msgmerge update so when you look at the commit later, 
> you'll have a hard time to find out what the actual changes in 
> translations were.

You can always use something like podiff 
<http://man.gnu.org.ua/manpage/?1+podiff> to find the actual changes 
in each update.

> It will make the history of *.po-files much more readable.

Unfortunately, it also makes merging changes more difficult. I sometimes 
queue up bugfixes between translation runs, and having the po file be 
reformatted in commits I do not control means I would have to manually 
re-add those as there is no good merge driver than can handle that 
reformatting.

-- 
\\// Peter - http://www.softwolves.pp.se/
