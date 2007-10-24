From: bdowning@lavos.net (Brian Downing)
Subject: Re: UI and git-completion.sh
Date: Tue, 23 Oct 2007 19:57:11 -0500
Message-ID: <20071024005711.GD24924@lavos.net>
References: <20071023234617.45a4fc64@paolo-desktop> <471E6EF0.2060403@midwinter.com> <86ve8x9z1f.fsf@blue.stonehenge.com> <vpqir4xgzep.fsf@bauges.imag.fr> <86prz59y9s.fsf@blue.stonehenge.com> <471E91C9.3000004@midwinter.com> <86d4v59wvt.fsf@blue.stonehenge.com> <20071024005549.GC24924@lavos.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Grimm <koreth@midwinter.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	git@vger.kernel.org
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
X-From: git-owner@vger.kernel.org Wed Oct 24 03:07:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkUiE-0003Hd-S3
	for gcvg-git-2@gmane.org; Wed, 24 Oct 2007 03:07:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752830AbXJXBG7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2007 21:06:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752807AbXJXBG7
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Oct 2007 21:06:59 -0400
Received: from mxsf04.insightbb.com ([74.128.0.74]:61644 "EHLO
	mxsf04.insightbb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752784AbXJXBG6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2007 21:06:58 -0400
X-IronPort-AV: E=Sophos;i="4.21,320,1188792000"; 
   d="scan'208";a="87142134"
Received: from unknown (HELO asav01.insightbb.com) ([172.31.249.124])
  by mxsf04.insightbb.com with ESMTP; 23 Oct 2007 20:57:22 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Aq4HANA0HkdKhvkY/2dsb2JhbACBWo5k
X-IronPort-AV: E=Sophos;i="4.21,320,1188792000"; 
   d="scan'208";a="88493670"
Received: from 74-134-249-24.dhcp.insightbb.com (HELO mail.lavos.net) ([74.134.249.24])
  by asav01.insightbb.com with ESMTP; 23 Oct 2007 20:57:22 -0400
Received: by mail.lavos.net (Postfix, from userid 1000)
	id CE4C1309F21; Tue, 23 Oct 2007 19:57:11 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <20071024005549.GC24924@lavos.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62181>

On Tue, Oct 23, 2007 at 07:55:49PM -0500, Brian Downing wrote:
> I dunno the "right" way to do it, but I had this in my .zshrc file that
> I presumably cargo-culted from somewhere:
> 
>     fpath=( $HOME/.zsh/compfuncs $fpath )

I think this has to come before "compinit" or whatever starts up the new
completion engine.

-bcd
