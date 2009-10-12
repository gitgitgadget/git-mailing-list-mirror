From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-gui: Fixed _main window_ for screen height equal
 600 px
Date: Mon, 12 Oct 2009 09:35:44 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0910120934420.4985@pacific.mpi-cbg.de>
References: <1255329194-2757-1-git-send-email-vietor@vxwo.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Vietor Liu <vietor@vxwo.org>
X-From: git-owner@vger.kernel.org Mon Oct 12 09:35:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxFQn-0006ES-2J
	for gcvg-git-2@lo.gmane.org; Mon, 12 Oct 2009 09:34:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754524AbZJLHd4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 03:33:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754513AbZJLHd4
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 03:33:56 -0400
Received: from mail.gmx.net ([213.165.64.20]:38245 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754231AbZJLHdz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 03:33:55 -0400
Received: (qmail invoked by alias); 12 Oct 2009 07:33:08 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp071) with SMTP; 12 Oct 2009 09:33:08 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19VqgE/I65VrqmgX20BBeTtRW2507Hg9xTeJx01vs
	t0UjorsYRnqTUw
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1255329194-2757-1-git-send-email-vietor@vxwo.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129993>

Hi,

On Mon, 12 Oct 2009, Vietor Liu wrote:

> When the screen height equal 600 px(e.g. Asus EeePC 1024x600), The
> _main window_ should be hide the _Push button_ and _Status bar_.

Your commit message disagrees with the patch:

>  set ui_diff .vpane.lower.diff.body.t
>  text $ui_diff -background white -foreground black \
>  	-borderwidth 0 \
> -	-width 80 -height 15 -wrap none \
> +	-width 80 -height 5 -wrap none \
>  	-font font_diff \

So what you _actually_ do is reduce the space for the diff, no?

Ciao,
Dscho
