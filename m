From: Peter Karlsson <peter@softwolves.pp.se>
Subject: Re: Git on Windows, CRLF issues
Date: Tue, 22 Apr 2008 09:42:19 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <Pine.LNX.4.64.0804220940320.22731@ds9.cixit.se>
References: <alpine.DEB.1.00.0804212145570.21181@perkele.intern.softwolves.pp.se>
 <480D863B.1040009@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Apr 22 10:44:02 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoE5l-00069w-H0
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 10:43:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756788AbYDVImX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2008 04:42:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756769AbYDVImX
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 04:42:23 -0400
Received: from ds9.cixit.se ([193.15.169.228]:45610 "EHLO ds9.cixit.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756545AbYDVImW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2008 04:42:22 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id m3M8gKBs003002
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 22 Apr 2008 10:42:20 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id m3M8gJvU002996;
	Tue, 22 Apr 2008 10:42:19 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <480D863B.1040009@viscovery.net>
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (ds9.cixit.se [127.0.0.1]); Tue, 22 Apr 2008 10:42:20 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80080>

Johannes Sixt:

> 2. You are still converting repositories? Convert the files in your
> repository to LF.

Or, perhaps, this is the way to go.

Got to figure out how to get CRLF->LF conversion working without having
RCS keyword expansion going haywire. I'm using RCS format as a
middle-man between the old repositories (PVCS) I'm converting and
parsecvs which imports them into Git. The old repository has expanded
keywords, and I must avoid having RCS/CVS expand them as they would
expand in a different manner... :-/

-- 
\\// Peter - http://www.softwolves.pp.se/
