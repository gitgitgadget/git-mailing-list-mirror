From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: git branch --track to link existing local branch to remote?
Date: Tue, 25 May 2010 21:53:03 +0200
Message-ID: <20100525195303.GA8174@atjola.homenet>
References: <AANLkTinxohzZE6uinzYPIAx3iVjw7afDLsr9MPMUAvHj@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: skillzero@gmail.com
X-From: git-owner@vger.kernel.org Tue May 25 21:53:56 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OH0CK-00025k-DW
	for gcvg-git-2@lo.gmane.org; Tue, 25 May 2010 21:53:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932981Ab0EYTxm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 May 2010 15:53:42 -0400
Received: from mail.gmx.net ([213.165.64.20]:54043 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932843Ab0EYTxl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 May 2010 15:53:41 -0400
Received: (qmail invoked by alias); 25 May 2010 19:53:17 -0000
Received: from i59F5B90E.versanet.de (EHLO atjola.homenet) [89.245.185.14]
  by mail.gmx.net (mp007) with SMTP; 25 May 2010 21:53:17 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX18evt1iMGAe5usxadTkQAWP58/4SLBjNPAsJt76EI
	yZcfGzmqyM98rO
Content-Disposition: inline
In-Reply-To: <AANLkTinxohzZE6uinzYPIAx3iVjw7afDLsr9MPMUAvHj@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147725>

On 2010.05.25 12:40:40 -0700, skillzero@gmail.com wrote:
> However, the branches aren't linked in the config file so I can't jus=
t
> do git pull.
[...]
> So what I've had to do is create a temp branch, switch to it, do git
> branch -f --track master origin/master, and then delete the temp
> branch. Is there a better way?

With git v1.7.0 or newer:
git branch --set-upstream master origin/master

Bj=F6rn
