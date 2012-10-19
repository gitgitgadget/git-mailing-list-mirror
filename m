From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: L10n regression in 1.8.0.rc2: diffstat summary (git diff --stat,
 git format-patch)
Date: Sat, 20 Oct 2012 00:38:42 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.1210200035220.15821@ds9.cixit.se>
References: <alpine.DEB.2.00.1210171145360.12699@ds9.cixit.se> <CACsJy8CS9TKGaT8+MQ_JOEQD+fgnc9HVAbr1pjQ3JE_3ZjE9=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Git Mailing List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 20 01:39:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TPM9e-0001PO-1m
	for gcvg-git-2@plane.gmane.org; Sat, 20 Oct 2012 01:39:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932285Ab2JSXiu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2012 19:38:50 -0400
Received: from upper-gw.cixit.se ([92.43.32.133]:41251 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754309Ab2JSXit (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2012 19:38:49 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-9.4) with ESMTP id q9JNchwq016304
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 20 Oct 2012 01:38:43 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id q9JNcg7S016301;
	Sat, 20 Oct 2012 01:38:42 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <CACsJy8CS9TKGaT8+MQ_JOEQD+fgnc9HVAbr1pjQ3JE_3ZjE9=A@mail.gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.3.7 (mail.cixit.se [127.0.0.1]); Sat, 20 Oct 2012 01:38:43 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208076>

Nguyen Thai Ngoc Duy:

> It's the result of this discussion [1]. I don't remember exactly the
> open issues. But I think it involves drawing a line between team
> language vs local language, whether team language can be anything
> other than English, the maintenance cost for supporting it

Like I said, I can see that defaulting format-patch to output English 
is a good idea (since its output is "protocol data" and not something 
for human consumption), it is the output from diff and show that I 
want to have localized.

I'll see if I can come up with a patch that cater for both use-cases. 
Maybe I can also fix so that log output is fully localized at the same 
time (translating "commit", "author", "date" and outputting locale 
dates (although my locale usess ISO dates, so I can get proper 
formatting there already)).

-- 
\\// Peter - http://www.softwolves.pp.se/
