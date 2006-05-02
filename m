From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-bisect broken in 1.2.4
Date: Tue, 2 May 2006 12:42:52 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0605021241300.3795@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060501181020.GA21263@suse.de> <20060502070155.GA861@informatik.uni-freiburg.de>
 <7vpsiwopkv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Olaf Hering <olh@suse.de>, git@vger.kernel.org,
	Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>
X-From: git-owner@vger.kernel.org Tue May 02 12:43:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FasLK-00025g-4D
	for gcvg-git@gmane.org; Tue, 02 May 2006 12:42:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932146AbWEBKmz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 May 2006 06:42:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932174AbWEBKmz
	(ORCPT <rfc822;git-outgoing>); Tue, 2 May 2006 06:42:55 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:64957 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932146AbWEBKmy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 May 2006 06:42:54 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id 47E7F1C66;
	Tue,  2 May 2006 12:42:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 3BCAE1C10;
	Tue,  2 May 2006 12:42:53 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 0C8DFFD3;
	Tue,  2 May 2006 12:42:53 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vpsiwopkv.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19414>

Hi,

On Tue, 2 May 2006, Junio C Hamano wrote:

> Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de> writes:
> 
> > You can rebuild git with USE_SYMLINK_HEAD if you really want the old
> > behaviour.
> 
> That probably is a sane thing to do.
> 
> We should introduce prefer_symlink_refs configuration to work
> with projects whose older version of build infrastructure
> depends on symlink refs.
> 
> The patch is on top of post 1.3.1 git, but .c and .h part should
> apply more-or-less cleanly to older code base.  You should 
> be able to say:
> 
> 	[core]
>         prefersymlinkrefs = true

Why not just use the existing method:

	[core]
		onlyusesymrefs = false

Hmm?

Ciao,
Dscho
