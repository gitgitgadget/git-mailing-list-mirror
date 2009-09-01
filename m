From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: What's cooking in git.git (Aug 2009, #06; Sun, 30)
Date: Tue, 1 Sep 2009 16:08:30 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.0909011605400.3883@ds9.cixit.se>
References: <7viqg48nxi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Git Mailing List <git@vger.kernel.org>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Tue Sep 01 17:08:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MiUyU-0006O7-9Y
	for gcvg-git-2@lo.gmane.org; Tue, 01 Sep 2009 17:08:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753772AbZIAPIb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2009 11:08:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753569AbZIAPIb
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Sep 2009 11:08:31 -0400
Received: from upper-gw.cixit.se ([92.43.32.133]:55520 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753507AbZIAPIa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2009 11:08:30 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-5) with ESMTP id n81F8Uqc004136
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 1 Sep 2009 17:08:30 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id n81F8UxH004132;
	Tue, 1 Sep 2009 17:08:30 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <7viqg48nxi.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-3.0 (mail.cixit.se [127.0.0.1]); Tue, 01 Sep 2009 17:08:30 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127540>

Junio C Hamano:

> * pk/import-dirs (2009-08-24) 1 commit
> - Add script for importing bits-and-pieces to Git.
>
> This version makes me suspect that the author might regret the choice of 
> the import format that does not allow escaping of paths, nor does not 
> allow leading blanks for readability without changing semantics, both of 
> which make it somewhat limiting and error prone.  These issues will be 
> hard to rectify without breaking the backward compatibility, for a tool 
> that could otherwise turn out to be useful.

If anyone has suggestions on improvements that can help with these issues, 
feel free to submit additional patches. Backwards compatibility is not an 
issue at the moment since it is new material and I so far is the only user 
of the tool (and since it is meant for one-shot imports, backwards 
compatibility is not very important).

-- 
\\// Peter - http://www.softwolves.pp.se/
