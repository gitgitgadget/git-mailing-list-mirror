From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: BUG: mergetool fails on gitignore:d files
Date: Sat, 30 May 2009 18:38:08 +0200
Message-ID: <200905301838.09081.markus.heidelberg@web.de>
References: <e87cdfda0905300830t6b332533g9a4298f6b8005b9e@mail.gmail.com>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Erik Sandberg <mandolaerik@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 30 18:38:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MARZc-0000Kh-A7
	for gcvg-git-2@gmane.org; Sat, 30 May 2009 18:38:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932328AbZE3QiL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 May 2009 12:38:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932110AbZE3QiK
	(ORCPT <rfc822;git-outgoing>); Sat, 30 May 2009 12:38:10 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:35359 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757756AbZE3QiJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 May 2009 12:38:09 -0400
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate02.web.de (Postfix) with ESMTP id 7A0DB1015D5EE;
	Sat, 30 May 2009 18:38:10 +0200 (CEST)
Received: from [89.59.100.180] (helo=.)
	by smtp05.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1MARZR-00069F-00; Sat, 30 May 2009 18:38:10 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <e87cdfda0905300830t6b332533g9a4298f6b8005b9e@mail.gmail.com>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1/FKHy8HRYCQL16N7OxclOCOkcReIPUN6Klogjg
	WExPu2FLooI4G0v/gLok+Hw8fmJYrrsSLqy5OQec+dfnFkrAb4
	pXtk927DbWrbBO8Fk8Kw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120358>

Erik Sandberg, 30.05.2009:
> If a version-controlled file is ignored by git, and a conflict arises
> on the file, and I use mergetool to resolve the conflict, then
> mergetool fails with a message like:
> 
> The following paths are ignored by one of your .gitignore files:
> a
> Use -f if you really want to add them.
> 
> The problem disappears if I edit the git-mergetool script to always
> pass -f to "git add", but I'm not sure if that's the right fix; I have
> a vague feeling that "git-update-index --add" could be more correct.
> 
> I have attached a script that reproduces the problem.

The script would have been more readable if you haven't given both the
file and the branch name as well as the file content and the commit
message the same string "a".

Apart from that I wonder if your real repo also ignores the file 'a'
although it is tracked in every branch. If so, why do you ignore it?

Markus
