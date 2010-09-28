From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [msysGit] Re: Pull request for msysGit patches
Date: Tue, 28 Sep 2010 23:11:01 +0200
Message-ID: <201009282311.01703.j6t@kdbg.org>
References: <87ocbitd33.fsf@fox.patthoyts.tk> <7vocbhsn03.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: msysgit@googlegroups.com,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 28 23:11:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0hS9-0008BZ-MC
	for gcvg-git-2@lo.gmane.org; Tue, 28 Sep 2010 23:11:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753265Ab0I1VLE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Sep 2010 17:11:04 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:9958 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751786Ab0I1VLD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Sep 2010 17:11:03 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id EF6671000B;
	Tue, 28 Sep 2010 23:11:01 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id C527B19F5C4;
	Tue, 28 Sep 2010 23:11:01 +0200 (CEST)
User-Agent: KMail/1.9.10
In-Reply-To: <7vocbhsn03.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157474>

On Dienstag, 28. September 2010, Junio C Hamano wrote:
> git-merge-octopus.sh
>
> Why isn't upcasing necessary for all the other uses of environment
> variables?  For example, we pass reflog action by exporting a variable,
> and we use GIT_AUTHOR_NAME and friends to override configuration
> variables.  Do they get upcased?

It is the environment variable *names* that get upper-cased, not the values. 
The variable name that was set for use by git-merge-octopus is of the form 
GITHEAD_deadbeef, but inside git-merge-octopus, the name is GITHEAD_DEADBEEF. 
Only MSYS programs like bash, but not native Windows programs like git, 
suffer from this.

-- Hannes
