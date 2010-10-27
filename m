From: Peter van der Does <peter@ourvirtualhome.com>
Subject: Re: What's cooking in git.git (Oct 2010, #02; Tue, 26)
Date: Wed, 27 Oct 2010 10:33:52 -0400
Message-ID: <20101027103352.32ffccaf@MonteCarlo>
References: <7v62woduyp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 27 17:30:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PB7xa-0004GD-VI
	for gcvg-git-2@lo.gmane.org; Wed, 27 Oct 2010 17:30:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753895Ab0J0Pah (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Oct 2010 11:30:37 -0400
Received: from bellona.lunarservers.com ([74.50.21.190]:38448 "EHLO
	bellona.lunarservers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752763Ab0J0Pag (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Oct 2010 11:30:36 -0400
X-Greylist: delayed 3395 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Oct 2010 11:30:36 EDT
Received: from c-69-248-103-68.hsd1.nj.comcast.net ([69.248.103.68] helo=monza.grandprix.int)
	by bellona.lunarservers.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <peter@ourvirtualhome.com>)
	id 1PB74d-0005Mo-L8; Wed, 27 Oct 2010 07:33:55 -0700
Received: from MonteCarlo (montecarlo.grandprix.int [192.168.1.102])
	by monza.grandprix.int (Postfix) with ESMTPA id 335C3101F82;
	Wed, 27 Oct 2010 10:33:53 -0400 (EDT)
In-Reply-To: <7v62woduyp.fsf@alter.siamese.dyndns.org>
X-Mailer: Claws Mail 3.7.6 (GTK+ 2.22.0; i486-pc-linux-gnu)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bellona.lunarservers.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - ourvirtualhome.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160090>

On Tue, 26 Oct 2010 23:13:18 -0700
Junio C Hamano <gitster@pobox.com> wrote:

> * ml/completion-zsh (2010-09-06) 1 commit
>   (merged to 'next' on 2010-09-22 at d62d10e)
>  + completion: make compatible with zsh
> 
> Reported as breaking people with "set -u".
> 

With the patch "Make git-completion Bash 4 compatible" in mind, it
might be useful to start looking into a different way to distribute the
completion script to accommodate different shells. Adding compatibility
for each shell into one script can get nasty. We could have a different
completion script for each shell.

As of right now the completion script is compatible with Bash 3 and
zsh. I don't know if the new code provided with the proposed patch "Make
git-completion Bash 4 compatible" is zsh compatible.

-- 
Peter van der Does

GPG key: E77E8E98
Twitter: @petervanderdoes
