From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: git status internals and line endings
Date: Fri, 13 Nov 2009 10:40:17 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.0911131039130.11302@ds9.cixit.se>
References: <4AFC70CE.5020106@syntevo.com> <20091113001547.GB28836@sigill.intra.peff.net> <4AFD1414.6030907@syntevo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
To: Marc Strapetz <marc.strapetz@syntevo.com>
X-From: git-owner@vger.kernel.org Fri Nov 13 10:40:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8se0-0001PM-CL
	for gcvg-git-2@lo.gmane.org; Fri, 13 Nov 2009 10:40:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755517AbZKMJka (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Nov 2009 04:40:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755493AbZKMJk3
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Nov 2009 04:40:29 -0500
Received: from upper-gw.cixit.se ([92.43.32.133]:45430 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755302AbZKMJk2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Nov 2009 04:40:28 -0500
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-5) with ESMTP id nAD9eHqO020166
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 13 Nov 2009 10:40:17 +0100
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id nAD9eHwn020162;
	Fri, 13 Nov 2009 10:40:17 +0100
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <4AFD1414.6030907@syntevo.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-3.0 (mail.cixit.se [127.0.0.1]); Fri, 13 Nov 2009 10:40:17 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132828>

Marc Strapetz:

>> Sounds like the core.autocrlf setting (see "git help config"), which I 
>> believe is set by default on Windows.

> I have checked both $GIT_DIR/config and ~/.gitconfig and autocrlf has not 
> been set.

It is usually set by default by the installer. Look at 
%INSTALLDIR%\etc\gitconfig, it should contain

   [core]
    autoCRLF = true

among other things.

-- 
\\// Peter - http://www.softwolves.pp.se/
