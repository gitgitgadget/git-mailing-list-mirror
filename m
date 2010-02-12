From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: Individual file snapshots
Date: Fri, 12 Feb 2010 13:18:09 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.1002121316260.10583@ds9.cixit.se>
References: <ron1-CD3223.04030512022010@news.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Ron Garret <ron1@flownet.com>
X-From: git-owner@vger.kernel.org Fri Feb 12 13:19:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfuUQ-0001OO-FC
	for gcvg-git-2@lo.gmane.org; Fri, 12 Feb 2010 13:19:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756436Ab0BLMSR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2010 07:18:17 -0500
Received: from upper-gw.cixit.se ([92.43.32.133]:39360 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752670Ab0BLMSQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2010 07:18:16 -0500
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-5) with ESMTP id o1CCI9p7026217
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 12 Feb 2010 13:18:10 +0100
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id o1CCI9Qf026214;
	Fri, 12 Feb 2010 13:18:09 +0100
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <ron1-CD3223.04030512022010@news.gmane.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-3.0 (mail.cixit.se [127.0.0.1]); Fri, 12 Feb 2010 13:18:10 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139692>

Ron Garret:

> I would like to be able to store snapshots of individual files without 
> making a commit on the main branch.

   git hash-object -w filename

will add the file to the object database, outputting it's hash value.

   git tag mytag hashvalue

creates a tag "mytag" pointing to that file.

   git show mytag

will output the file you put in.

-- 
\\// Peter - http://www.softwolves.pp.se/
