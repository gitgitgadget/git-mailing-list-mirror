From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: fatal: git grep: cannot generate relative filenames containing '..'
Date: Fri, 16 Jan 2009 00:04:27 +0100
Message-ID: <200901160004.27956.markus.heidelberg@web.de>
References: <20090115222905.8157.qmail@science.horizon.com>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "George Spelvin" <linux@horizon.com>
X-From: git-owner@vger.kernel.org Fri Jan 16 00:06:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNbHf-00026g-8J
	for gcvg-git-2@gmane.org; Fri, 16 Jan 2009 00:05:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934890AbZAOXD7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2009 18:03:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936955AbZAOXD4
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 18:03:56 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:56766 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936320AbZAOXDy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2009 18:03:54 -0500
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate01.web.de (Postfix) with ESMTP id 356B1FBC2D73;
	Fri, 16 Jan 2009 00:03:53 +0100 (CET)
Received: from [89.59.96.34] (helo=pluto)
	by smtp08.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1LNbFh-0006Xk-00; Fri, 16 Jan 2009 00:03:53 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <20090115222905.8157.qmail@science.horizon.com>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX19vWrS+idMGQ9a7Gp55spWfgVmrJ1b5InIKK2O7
	H8bLRjV02fTLIpT2j5RdAsQ5YbcyIYqHwCi4ruXlSPobNqWsIW
	kCoGoAlwn2AfsAI42Rbg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105893>

George Spelvin, 15.01.2009:
> While you're at it, an option to search the entire git tree rather than
> the current subdirectory would also be useful.  I was thinking about
> a flag like -r (for "root"), but a second idea dawned on me: interpret
> absolute pathnames as relative to the root of the repository.  So I could
> "git grep <pattern> /" or "git grep <pattern> /include" from any subdirectory.

I have never used submodules execpt for trying out, but I think it would
ambigous when calling this command from inside a submodule. It's not
clear, whether the main repo or the submodule should be used.

Markus
