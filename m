From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [CFH] Remotes conversion script
Date: Sun, 24 Sep 2006 23:49:16 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0609242347090.25371@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060924212142.GB20017@pasky.or.cz> <ef6tt8$2un$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 24 23:49:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRbqj-0000tx-Ea
	for gcvg-git@gmane.org; Sun, 24 Sep 2006 23:49:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751608AbWIXVtT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Sep 2006 17:49:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751611AbWIXVtT
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Sep 2006 17:49:19 -0400
Received: from mail.gmx.de ([213.165.64.20]:51340 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751606AbWIXVtS (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Sep 2006 17:49:18 -0400
Received: (qmail invoked by alias); 24 Sep 2006 21:49:17 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp033) with SMTP; 24 Sep 2006 23:49:17 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <ef6tt8$2un$1@sea.gmane.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27701>

Hi,

On Sun, 24 Sep 2006, Jakub Narebski wrote:

> If I remember correctly currently only some functionality provided by
> remotes file can be provided by [remote] and [branch] sections of git
> config.

... and what might the lacking functionality be?

.git/remotes/<name>    config

URL:                   remote.<name>.url
Pull:                  remote.<name>.fetch
Push:                  remote.<name>.push

You can even have multiple entries in the config, and it behaves as if you 
had multiple lines in .git/remotes/<name>.

Ciao,
Dscho
