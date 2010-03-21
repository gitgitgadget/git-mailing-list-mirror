From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: [PATCH v3] git checkout: create unparented branch by --orphan
Date: Sun, 21 Mar 2010 18:14:31 +0100
Message-ID: <20100321171431.GE2557@m62s10.vlinux.de>
References: <1269185678-3039-1-git-send-email-erick.mattos@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Erick Mattos <erick.mattos@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 21 18:14:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtOjZ-0002Vo-Ia
	for gcvg-git-2@lo.gmane.org; Sun, 21 Mar 2010 18:14:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752431Ab0CUROg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Mar 2010 13:14:36 -0400
Received: from mail.gmx.net ([213.165.64.20]:55337 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752272Ab0CUROg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Mar 2010 13:14:36 -0400
Received: (qmail invoked by alias); 21 Mar 2010 17:14:33 -0000
Received: from m62s10.vlinux.de (EHLO m62s10.vlinux.de) [83.151.21.204]
  by mail.gmx.net (mp040) with SMTP; 21 Mar 2010 18:14:33 +0100
X-Authenticated: #1252284
X-Provags-ID: V01U2FsdGVkX1/dqdxv7GLdyQ8ypZv1KhXJ4pXaDw/3e6PvjnRjDo
	zXPTbxFG0nFF3Y
Received: by m62s10.vlinux.de (Postfix, from userid 1000)
	id DAA03D4006; Sun, 21 Mar 2010 18:14:31 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1269185678-3039-1-git-send-email-erick.mattos@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.68000000000000005
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142837>

On Sun, Mar 21, 2010 at 12:34:38PM -0300, Erick Mattos wrote:
> Similar to -b, --orphan creates a new branch, but it starts without any
> commit.  After running "git checkout --orphan newbranch", you are on a
> new branch "newbranch", and the first commit you create from this state
> will start a new history without any ancestry.
> 
> "git checkout --orphan" keeps the index and the working tree files
> intact in order to make it convenient for creating a new history whose
> trees resemble the ones from the original branch.
> 

Sorry to skim in so late but --orphan sounds - at least to me as a non native
speaker - a little strange. Yes, I know it means "without parents", but
actually it would be the *last* thing I would search for after opening the
manpage.

Wouldn't --empty-parent or --no-parent describe the situation better?
It actually has the benefit that it would match on a search for /parent/,
which I would have searched for if I want to create a new empty branch.

--
Peter
