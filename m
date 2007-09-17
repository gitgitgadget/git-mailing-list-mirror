From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/8] repack -A -d: use --keep-unreachable when repacking
Date: Mon, 17 Sep 2007 10:29:55 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709171027400.28586@racer.site>
References: <11900186941912-git-send-email-gitster@pobox.com>
 <11900187002882-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 17 11:30:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXCwM-0003ci-Mt
	for gcvg-git-2@gmane.org; Mon, 17 Sep 2007 11:30:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754162AbXIQJao (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2007 05:30:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753977AbXIQJao
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 05:30:44 -0400
Received: from mail.gmx.net ([213.165.64.20]:56006 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753826AbXIQJan (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 05:30:43 -0400
Received: (qmail invoked by alias); 17 Sep 2007 09:30:41 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp048) with SMTP; 17 Sep 2007 11:30:41 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18GLNNw1K4GEPC/kLGghpufPnL7YXFPqYORK2i6y+
	a4ZsCV4rESASqB
X-X-Sender: gene099@racer.site
In-Reply-To: <11900187002882-git-send-email-gitster@pobox.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58408>

Hi,

On Mon, 17 Sep 2007, Junio C Hamano wrote:

> -USAGE='[-a] [-d] [-f] [-l] [-n] [-q] [--max-pack-size=N] [--window=N] [--window-memory=N] [--depth=N]'
> +USAGE='[-a|-A] [-d] [-f] [-l] [-n] [-q] [--max-pack-size=N] [--window=N] [--window-memory=N] [--depth=N]'

Would "[-a] [-A]" not be better?  In other usage lines, we have the "|" 
for alternative forms of the _same_ option, like "[-m|--merge]".

> +	-A)	all_into_one=t
> +		keep_unreachable=t ;;

Why not "keep_unreachable=--keep-unreachable" and use "$args 
$keep_unreachable" later?

Ciao,
Dscho
