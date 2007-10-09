From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Re: [PATCH] Support cvs via git-shell
Date: Wed, 10 Oct 2007 00:35:38 +0200
Message-ID: <20071009223538.GG31659@planck.djpig.de>
References: <200710051453.47622.wielemak@science.uva.nl> <Pine.LNX.4.64.0710091531360.4174@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, hjemli@gmail.com,
	Jan Wielemaker <wielemak@science.uva.nl>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Oct 10 00:36:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfNgH-0005A8-US
	for gcvg-git-2@gmane.org; Wed, 10 Oct 2007 00:36:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752506AbXJIWfw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2007 18:35:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752049AbXJIWfw
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Oct 2007 18:35:52 -0400
Received: from planck.djpig.de ([85.10.192.180]:1107 "EHLO planck.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751381AbXJIWfv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2007 18:35:51 -0400
Received: from localhost (localhost [127.0.0.1])
	by planck.djpig.de (Postfix) with ESMTP id E0E8A88231;
	Wed, 10 Oct 2007 00:35:48 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at planck.djpig.de
Received: from planck.djpig.de ([127.0.0.1])
	by localhost (planck.djpig.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id K9VTW7LKQ0Nr; Wed, 10 Oct 2007 00:35:39 +0200 (CEST)
Received: by planck.djpig.de (Postfix, from userid 1000)
	id 09B7D88232; Wed, 10 Oct 2007 00:35:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0710091531360.4174@racer.site>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60454>

On Tue, Oct 09, 2007 at 03:33:25PM +0100, Johannes Schindelin wrote:
>  static struct commands {
>  	const char *name;
>  	int (*exec)(const char *me, char *arg);
>  } cmd_list[] = {
>  	{ "git-receive-pack", do_generic_cmd },
>  	{ "git-upload-pack", do_generic_cmd },
> +	{ "cvs", do_cvs_cmd },
>  	{ NULL },

Maybe this should also allow git-cvsserver for completeness' sake?

Gruesse,
-- 
Frank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
