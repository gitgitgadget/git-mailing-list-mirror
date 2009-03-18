From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: Missing trailing newline with git log --pretty=format
Date: Wed, 18 Mar 2009 22:56:43 +0100
Message-ID: <200903182256.43817.markus.heidelberg@web.de>
References: <200903182223.58800.agruen@suse.de>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Andreas Gruenbacher <agruen@suse.de>
X-From: git-owner@vger.kernel.org Wed Mar 18 23:00:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lk3o8-00087M-FP
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 23:00:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755368AbZCRV5R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2009 17:57:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760892AbZCRV5P
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Mar 2009 17:57:15 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:57608 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760910AbZCRV5O (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2009 17:57:14 -0400
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate01.web.de (Postfix) with ESMTP id 70816FEB42BA;
	Wed, 18 Mar 2009 22:56:44 +0100 (CET)
Received: from [89.59.91.167] (helo=.)
	by smtp08.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1Lk3ki-0001sV-00; Wed, 18 Mar 2009 22:56:44 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <200903182223.58800.agruen@suse.de>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1/PfdPPvQBy0+hRtbbBEA8HTfepIQBpuDUJDsHl
	UMLTB8/0aFZ0HSHaU8jY6AhKVRJPWdpDD3F/CGqRXe9/QmkKvm
	cRyauN8fExthhgUffEGw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113686>

Andreas Gruenbacher, 18.03.2009:
> Hello,
> 
> with the latest version of git from right now (e986ceb):
> 
> While trying to get a reverse list of commit ids, I noticed that git log 
> prints newlines between commits, but not at the end. This results in two 
> joined lines with:
> 
> 	$ git log --pretty=format:%h HEAD^^..HEAD | tac
> 	aab3b9a7d4e3a7
> 	e986ceb
> 
> Any chance of getting this fixed?

Use tformat instead of format. Or better for a script use

	$ git rev-list HEAD^^..HEAD

But somehow --abbrev or --abbrev-commit don't work. Am I doing
something wrong?

Markus
