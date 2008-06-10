From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Date parsing
Date: Tue, 10 Jun 2008 17:07:38 +0200
Message-ID: <484E98BA.70808@viscovery.net>
References: <bd6139dc0806100758xb41d08dh18e3051088b707e5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: sverre@rabbelier.nl
X-From: git-owner@vger.kernel.org Tue Jun 10 17:09:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K65Se-0002ej-Js
	for gcvg-git-2@gmane.org; Tue, 10 Jun 2008 17:08:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754111AbYFJPHn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2008 11:07:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753459AbYFJPHn
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jun 2008 11:07:43 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:30625 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752432AbYFJPHm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2008 11:07:42 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1K65Rj-0001sC-8t; Tue, 10 Jun 2008 17:07:39 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id EE4896D9; Tue, 10 Jun 2008 17:07:38 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <bd6139dc0806100758xb41d08dh18e3051088b707e5@mail.gmail.com>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84514>

Sverre Rabbelier schrieb:
> Heya,
> 
> I noticed that we parse
> GIT_COMMITTER_DATE="31-05-2008 11:30pm" as "31st of July at 23:30 +0200"
> whereas we parse
> GIT_COMMITTER_DATE="01-06-2008 11:30pm" as "6th of January at 23:30 +0100"
> 
> Not only is it strange that we accept both orders (since apparently we
> don't resort to the latter order unless the first digit > 12), but
> it's also weird that the timezone changes based on which option was
> chosen! What does the list think about this? Is this "normal"
> behavior? If not, what (if anything) should we do about it?

Since you did not give a timezone, your local timezone is taken,
presumably MET, which has daylight saving time in July, but not in
January. This is OK.

-- Hannes
