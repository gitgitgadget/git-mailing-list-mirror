From: Sasha Khapyorsky <sashak@voltaire.com>
Subject: Re: [PATCH] git-svnimport.perl: fix for 'arg list too long...'
Date: Wed, 1 Feb 2006 23:54:54 +0200
Message-ID: <20060201215454.GB31711@sashak.voltaire.com>
References: <20060201155331.GE18078@sashak.voltaire.com> <7v64nybz9m.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matthias Urlichs <smurf@smurf.noris.de>
X-From: git-owner@vger.kernel.org Wed Feb 01 22:56:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4Pvk-0003Ti-Dw
	for gcvg-git@gmane.org; Wed, 01 Feb 2006 22:54:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422964AbWBAVyW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Feb 2006 16:54:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422965AbWBAVyV
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Feb 2006 16:54:21 -0500
Received: from taurus.voltaire.com ([193.47.165.240]:28312 "EHLO
	taurus.voltaire.com") by vger.kernel.org with ESMTP
	id S1422964AbWBAVyV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Feb 2006 16:54:21 -0500
Received: from sashak ([172.25.5.107]) by taurus.voltaire.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 1 Feb 2006 23:54:19 +0200
Received: by sashak (sSMTP sendmail emulation); Wed,  1 Feb 2006 23:54:54 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v64nybz9m.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 01 Feb 2006 21:54:19.0693 (UTC) FILETIME=[0DC1B5D0:01C6277A]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15453>

On 12:27 Wed 01 Feb     , Junio C Hamano wrote:
> Sasha Khapyorsky <sashak@voltaire.com> writes:
> 
> > This fixes 'arg list too long..' problem with git-ls-files.
> 
> I wonder if feeding the list into a pipe to 'update-index --stdin' 
> would be an option.

This can be option for git-update-index, but my problem was with
git-ls-files, git-update-index was ok (arg list processing were splitted
already).

> 
> BTW, please do not do this:
> 
>         Mail-Followup-To: Junio C Hamano <junkio@cox.net>,
>                 Matthias Urlichs <smurf@smurf.noris.de>, git@vger.kernel.org
> 
> It is simply rude.

OK, will not. Thanks for pointing.

Sasha.
