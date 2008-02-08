From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Any tricks for speeding up cvsps?
Date: Fri, 08 Feb 2008 10:57:09 +0100
Message-ID: <47AC2775.5090403@viscovery.net>
References: <47AC1FDC.9000502@glidos.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Paul Gardiner <osronline@glidos.net>
X-From: git-owner@vger.kernel.org Fri Feb 08 10:57:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNPzR-0002dy-76
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 10:57:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932833AbYBHJ5O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 04:57:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932756AbYBHJ5N
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 04:57:13 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:33597 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760786AbYBHJ5M (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 04:57:12 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JNPyS-0000Rx-AY; Fri, 08 Feb 2008 10:56:48 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 204D9A33B; Fri,  8 Feb 2008 10:57:09 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <47AC1FDC.9000502@glidos.net>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73061>

Paul Gardiner schrieb:
> I'm trying to convert a huge cvs repository. I've left cvsps running for
> days. First attempt, stderr filled my disc with warnings about tags that
> couldn't be associated with any one commit, without producing anything
> from stdout. I'm now redirecting stderr to /dev/null, but it still just
> sits there producing nothing.  Is git-cvsimport infeasible for large
> repositories, or are there tricks I might use?

I've used fast-export (not git-fast-export) to convert a CVS repository:

http://repo.or.cz/w/fast-export.git

It worked better than git-cvsimport because the repository was a real mess.

-- Hannes
