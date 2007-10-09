From: Peter Karlsson <peter@softwolves.pp.se>
Subject: Re: Merge problems with git-mingw
Date: Tue, 9 Oct 2007 08:06:17 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <Pine.LNX.4.64.0710090800220.26773@ds9.cixit.se>
References: <Pine.LNX.4.64.0710081203020.29715@ds9.cixit.se> 
 <8c5c35580710080500n78259210v1b087e1ef506c0ee@mail.gmail.com> 
 <Pine.LNX.4.64.0710081333350.29715@ds9.cixit.se> 
 <8c5c35580710080610y739fb51aga82964e212c7917f@mail.gmail.com> 
 <Pine.LNX.4.64.0710081555480.29570@ds9.cixit.se>
 <8c5c35580710081259j6d7e8587r546d4c35d42a67a6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <j.sixt@viscovery.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 09 09:06:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1If9Ap-0007BJ-0b
	for gcvg-git-2@gmane.org; Tue, 09 Oct 2007 09:06:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751759AbXJIHGV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2007 03:06:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750934AbXJIHGV
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Oct 2007 03:06:21 -0400
Received: from ds9.cixit.se ([193.15.169.228]:51824 "EHLO ds9.cixit.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751358AbXJIHGU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2007 03:06:20 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id l9976InQ028372
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 9 Oct 2007 09:06:18 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id l9976I4K028366;
	Tue, 9 Oct 2007 09:06:18 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <8c5c35580710081259j6d7e8587r546d4c35d42a67a6@mail.gmail.com>
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (ds9.cixit.se [127.0.0.1]); Tue, 09 Oct 2007 09:06:18 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60364>

HI!

> Does 'git var -l' work as expected?

Hmm, it also gives an error message:

$ git var -l
usage: git-var [-l | <variable>]

> Also, could you try the latest git-package provided by the cygwin
> installer? If CRLF-handling was your problem, take a look at the
> description of core.autocrlf with 'git help config'.

I tried it with Git 1.5.3.2 from Cygwin, and the problem I'm having is
not with the CRLF handling in the checked out files, but rather in the
repository database itself. Cloning a repository with Cygwin-Git
produced various errors about the object database being corrupt.
Mingw-Git does not produce those errors.

> [This does look like an issue with running mingw.git under Cygwin.
> Johannes, is this even supposed to work?]

I get the same error running mingw-git from a regular cmd.exe prompt,
so it doesn't seem to be related to Cygwin at all.

-- 
\\// Peter - http://www.softwolves.pp.se/
