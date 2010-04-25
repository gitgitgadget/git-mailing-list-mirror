From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: Case sensitivity on Windows for absolute paths.
Date: Sun, 25 Apr 2010 20:08:27 +0200
Message-ID: <201004252008.27823.j6t@kdbg.org>
References: <o2v7eeb06461004230712i2c8c1e61l4c50a73a4f6c83d@mail.gmail.com> <201004232146.56424.j6t@kdbg.org> <j2y7eeb06461004250033ue4434a41j7b9a752dea1f5fe1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Ricky Clarkson <ricky.clarkson@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 25 20:11:14 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O66IO-0003Zv-IN
	for gcvg-git-2@lo.gmane.org; Sun, 25 Apr 2010 20:11:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753678Ab0DYSLB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Apr 2010 14:11:01 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:19896 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753652Ab0DYSLA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Apr 2010 14:11:00 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id D9C6B10011;
	Sun, 25 Apr 2010 20:10:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id E2CCC19F70C;
	Sun, 25 Apr 2010 20:08:27 +0200 (CEST)
User-Agent: KMail/1.9.10
In-Reply-To: <j2y7eeb06461004250033ue4434a41j7b9a752dea1f5fe1@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145754>

On Sonntag, 25. April 2010, Ricky Clarkson wrote:
> It would be good if git automatically uppercased the drive letter,
> yes.  However, I found the real root of my problem.  Git Bash
> (msysgit) sets the working directory to c:\foo for programs launched
> if the working directory within it is /c/foo.

I don't understand what you mean. Git Bash cannot influence whether git sees 
the drive letter in the working directory in uppercase or lowercase. Unless 
by "working directory" you mean something else than what getcwd() returns.

-- Hannes
