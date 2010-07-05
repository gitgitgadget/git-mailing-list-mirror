From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: help moving boost.org to git
Date: Mon, 05 Jul 2010 16:48:52 +0200
Message-ID: <4C31F0D4.1040207@viscovery.net>
References: <4C31E944.30801@boostpro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Eric Niebler <eric@boostpro.com>
X-From: git-owner@vger.kernel.org Mon Jul 05 16:49:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OVmyq-0005Ut-TV
	for gcvg-git-2@lo.gmane.org; Mon, 05 Jul 2010 16:49:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756267Ab0GEOs4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jul 2010 10:48:56 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:25287 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755778Ab0GEOsz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jul 2010 10:48:55 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1OVmya-0004kP-Jb; Mon, 05 Jul 2010 16:48:53 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 559FE1660F;
	Mon,  5 Jul 2010 16:48:52 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.10) Gecko/20100512 Thunderbird/3.0.5
In-Reply-To: <4C31E944.30801@boostpro.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150272>

Am 7/5/2010 16:16, schrieb Eric Niebler:
> I have a question about the best approach to take for refactoring a
> large svn project into git. The project, boost.org, is a collection of
> C++ libraries (>100) that are mostly independent. (There may be
> cross-library dependencies, but we plan to handle that at a higher
> level.) After the move to git, we'd like each library to be in its own
> git repository.

You could use svn2git: http://gitorious.org/svn2git
KDE uses it to split its SVN repository into pieces. The tool is driven by
a "ruleset" that specifies SVN subdirectories and revision numbers that
make up a module.

-- 
"Atomic objects are neither active nor radioactive." --
Programming Languages -- C++, Final Committee Draft (Doc.N3092)
