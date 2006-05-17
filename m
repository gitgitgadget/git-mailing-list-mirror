From: Pavel Roskin <proski@gnu.org>
Subject: Re: "git add $ignored_file" fail
Date: Wed, 17 May 2006 15:56:56 -0400
Message-ID: <1147895816.30618.6.camel@dv>
References: <8aa486160605161507w3a27152dq@mail.gmail.com>
	 <Pine.LNX.4.64.0605161526210.16475@g5.osdl.org>
	 <8aa486160605161542u704ccf03w@mail.gmail.com>
	 <Pine.LNX.4.63.0605171306400.19012@wbgn013.biozentrum.uni-wuerzburg.de>
	 <81b0412b0605170604i689a8f7axa5aeb7752dc72072@mail.gmail.com>
	 <8aa486160605170641p2ab8704o@mail.gmail.com> <e4f9eo$b60$1@sea.gmane.org>
	 <1147893786.16654.5.camel@dv>
	 <20060517153903.6b896fdd.seanlkml@sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: jnareb@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 17 21:57:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgS8w-00023b-T5
	for gcvg-git@gmane.org; Wed, 17 May 2006 21:57:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751060AbWEQT5M (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 May 2006 15:57:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751058AbWEQT5M
	(ORCPT <rfc822;git-outgoing>); Wed, 17 May 2006 15:57:12 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:49092 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1751047AbWEQT5L
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 May 2006 15:57:11 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1FgS8s-0006Fo-HO
	for git@vger.kernel.org; Wed, 17 May 2006 15:57:10 -0400
Received: from proski by dv.roinet.com with local (Exim 4.62)
	(envelope-from <proski@dv.roinet.com>)
	id 1FgS8f-0007yo-7G; Wed, 17 May 2006 15:56:57 -0400
To: Sean <seanlkml@sympatico.ca>
In-Reply-To: <20060517153903.6b896fdd.seanlkml@sympatico.ca>
X-Mailer: Evolution 2.6.1 (2.6.1-3) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20235>

On Wed, 2006-05-17 at 15:39 -0400, Sean wrote:
> On Wed, 17 May 2006 15:23:06 -0400
> Pavel Roskin <proski@gnu.org> wrote:
> 
> Shouldn't git just always respect the ignore rules?  Forcing someone to
> remove a file from the .gitignore or employ the other work around
> mentioned earlier doesn't seem too bad.  How often are people adding
> files that are explicitly ignored?

That's a good idea!  And the implementation should be easy - if the file
is present, but git-ls-file doesn't show it, tell the user to
adjust .gitignore or to use some flag like --force.

Libification of git-ls-files would allow even more precise messages.

-- 
Regards,
Pavel Roskin
