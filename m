From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: git describe oddity: ignoring recent tags...
Date: Mon, 23 Nov 2009 13:30:48 +0100
Message-ID: <20091123123048.GA10172@atjola.homenet>
References: <46a038f90911230401sb2b1dd7u21b5d7edefe510eb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 23 13:31:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCY4M-0006O6-A9
	for gcvg-git-2@lo.gmane.org; Mon, 23 Nov 2009 13:31:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757178AbZKWMau (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Nov 2009 07:30:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757124AbZKWMau
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Nov 2009 07:30:50 -0500
Received: from mail.gmx.net ([213.165.64.20]:56320 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756997AbZKWMat (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Nov 2009 07:30:49 -0500
Received: (qmail invoked by alias); 23 Nov 2009 12:30:53 -0000
Received: from i59F5765B.versanet.de (EHLO atjola.homenet) [89.245.118.91]
  by mail.gmx.net (mp011) with SMTP; 23 Nov 2009 13:30:53 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1/VPMZEQMzVqAi8TipovubrVcAZxDmIqRrWvhtLnS
	Ln3uMZYXXZ62Uz
Content-Disposition: inline
In-Reply-To: <46a038f90911230401sb2b1dd7u21b5d7edefe510eb@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133500>

On 2009.11.23 13:01:51 +0100, Martin Langhoff wrote:
> Clone this repo: git://dev.laptop.org/projects/olpc-update -- or just
> check visually the recent history here
> http://dev.laptop.org/git/projects/olpc-update/log/
> 
> git describe origin/master will respond olpc-update-2.16-20-g2d4e4b8
> when it is fairly clear to me that it should be
> olpc-update-2.19-1g<hash>.
> 
> For some reason, recent tags are being ignored -- and cgit even
> displays them differently in
> http://dev.laptop.org/git/projects/olpc-update/log/ though it is
> unclear to me why.
> 
> These tags are not 'lightweight', and no tags are signed either.
> Passing --tags and --debug has not helped much.

They are lightweight:
$ git cat-file -t olpc-update-2.19
commit

And using --tags "helps" here:
$ git describe 
olpc-update-2.16-20-g2d4e4b8

$ git describe --tags
olpc-update-2.19-3-g2d4e4b8

Bjoern
