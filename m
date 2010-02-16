From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [msysGit] [PATCH] Skip t1300.70 and 71 on msysGit.
Date: Tue, 16 Feb 2010 10:27:41 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1002161027040.20986@pacific.mpi-cbg.de>
References: <87r5omghop.fsf@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: msysgit@googlegroups.com, git@vger.kernel.org
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Tue Feb 16 10:21:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhJcJ-0002iA-SO
	for gcvg-git-2@lo.gmane.org; Tue, 16 Feb 2010 10:21:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756805Ab0BPJVI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2010 04:21:08 -0500
Received: from mail.gmx.net ([213.165.64.20]:52718 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755620Ab0BPJVG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2010 04:21:06 -0500
Received: (qmail invoked by alias); 16 Feb 2010 09:21:01 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp037) with SMTP; 16 Feb 2010 10:21:01 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+lCaBRQEul+ddD/xzuJKGoPBSRiylWKl+aNWThKF
	/u8l7YKY1ogK6C
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <87r5omghop.fsf@users.sourceforge.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.68000000000000005
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140087>

Hi Pat,

On Mon, 15 Feb 2010, Pat Thoyts wrote:

> These two tests fail on msysGit because /dev/null is an alias for nul on 
> Windows and when reading the value back from git config the alias does 
> not match the real filename. Also the HOME environment variable has a 
> unix-style path but git returns a native equivalent path for '~'.  As 
> these are platform-dependent equivalent results it seems simplest to 
> skip the test entirely.
> 
> Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
> ---

Can you push this to 4msysgit's 'devel' branch?

Thank you,
Dscho
