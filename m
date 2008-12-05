From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/4] git-am: propagate -C<n>, -p<n> options as well
Date: Fri, 5 Dec 2008 13:21:43 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0812051320170.7062@intel-tinevez-2-302>
References: <1228443780-3386-1-git-send-email-gitster@pobox.com> <1228443780-3386-2-git-send-email-gitster@pobox.com> <1228443780-3386-3-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 05 13:23:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L8ZiO-0001SE-DY
	for gcvg-git-2@gmane.org; Fri, 05 Dec 2008 13:23:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751870AbYLEMWH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Dec 2008 07:22:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751674AbYLEMWG
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Dec 2008 07:22:06 -0500
Received: from mail.gmx.net ([213.165.64.20]:42417 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751138AbYLEMWF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Dec 2008 07:22:05 -0500
Received: (qmail invoked by alias); 05 Dec 2008 12:22:01 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp036) with SMTP; 05 Dec 2008 13:22:01 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19lf2QVnLRl+81JRAHetLQwGRLsAHrL4r6Kct8+ln
	qzCSFjRkpUf4fK
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <1228443780-3386-3-git-send-email-gitster@pobox.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6899999999999999
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102400>

Hi,

On Thu, 4 Dec 2008, Junio C Hamano wrote:

> -	echo " $ws" >"$dotest/whitespace"
> +	echo " $git_apply_opt" >"$dotest/apply_opt_extra"

>From the other scripts, it appears we have sort of a convention to use 
dashes instead of underscores for file names (see e.g. 
$dotest/patch-merge-tmp-dir).

Other than that, the whole series looks good to me.

Thanks for the work, especially the tests,
Dscho
