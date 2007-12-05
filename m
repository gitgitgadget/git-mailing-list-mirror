From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 3/6] Test "git remote show" and "git remote prune"
Date: Wed, 05 Dec 2007 22:59:26 +0100
Message-ID: <47571F3E.1060903@lsrfire.ath.cx>
References: <Pine.LNX.4.64.0712051858270.27959@racer.site> <Pine.LNX.4.64.0712051901550.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Dec 05 23:08:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J02PJ-00038v-2m
	for gcvg-git-2@gmane.org; Wed, 05 Dec 2007 23:07:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751968AbXLEWHc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2007 17:07:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751909AbXLEWHc
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 17:07:32 -0500
Received: from india601.server4you.de ([85.25.151.105]:46748 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751882AbXLEWHc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2007 17:07:32 -0500
X-Greylist: delayed 466 seconds by postgrey-1.27 at vger.kernel.org; Wed, 05 Dec 2007 17:07:31 EST
Received: from [10.0.1.201] (p57B7F926.dip.t-dialin.net [87.183.249.38])
	by india601.server4you.de (Postfix) with ESMTP id 754B32F8113;
	Wed,  5 Dec 2007 22:59:42 +0100 (CET)
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <Pine.LNX.4.64.0712051901550.27959@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67202>

Johannes Schindelin schrieb:
> While at it, also fix a few instances where a cd was done outside of a
> subshell.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  t/t5505-remote.sh |   34 ++++++++++++++++++++++++++++++++++
>  1 files changed, 34 insertions(+), 0 deletions(-)

It seems to me the patch only adds tests, but doesn't fix existing ones.
 And looking at t5505-remote.sh, every call of cd is already done inside
of a subshell, so there doesn't seem to be anything to fix either. :-?
