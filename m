From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add --ff-only flag to git-merge
Date: Wed, 28 Jan 2009 14:26:07 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901281425180.3586@pacific.mpi-cbg.de>
References: <1233147238-30082-1-git-send-email-nothingmuch@woobling.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Yuval Kogman <nothingmuch@woobling.org>
X-From: git-owner@vger.kernel.org Wed Jan 28 14:27:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSARn-0002z4-Eo
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 14:27:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751625AbZA1NZu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 08:25:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751541AbZA1NZt
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 08:25:49 -0500
Received: from mail.gmx.net ([213.165.64.20]:53142 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751037AbZA1NZt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 08:25:49 -0500
Received: (qmail invoked by alias); 28 Jan 2009 13:25:46 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp001) with SMTP; 28 Jan 2009 14:25:46 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19nRe0oAeZnOb+bSBJdMUWUMOc/qXn3qHNn5pGlUS
	dtcmG7xUVI+Tkx
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1233147238-30082-1-git-send-email-nothingmuch@woobling.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107534>

Hi,

On Wed, 28 Jan 2009, Yuval Kogman wrote:

> @@ -1012,6 +1015,9 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
>  		finish(o->sha1, msg.buf);
>  		drop_save();
>  		return 0;
> +	} else if ( only_fast_forward ) {
> +		printf("Merge is non fast forward, aborting.\n");
> +		return 1;
>  	} else if (!remoteheads->next && common->next)

If you compare the two if() lines, you will see that you mixed style.

Ciao,
Dscho
