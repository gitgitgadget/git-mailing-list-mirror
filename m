From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: "git diff --summary --diff-filter=AD" without --stat does not
 work.
Date: Tue, 3 Oct 2006 22:23:02 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0610032221330.14200@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7v3ba5tdlj.fsf@dee.twinsun.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 03 22:23:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GUqnI-0000t2-5B
	for gcvg-git@gmane.org; Tue, 03 Oct 2006 22:23:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030322AbWJCUXH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Oct 2006 16:23:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030324AbWJCUXH
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Oct 2006 16:23:07 -0400
Received: from mail.gmx.de ([213.165.64.20]:6539 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030322AbWJCUXE (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Oct 2006 16:23:04 -0400
Received: (qmail invoked by alias); 03 Oct 2006 20:23:03 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp040) with SMTP; 03 Oct 2006 22:23:03 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio Hamano <junio@twinsun.com>
In-Reply-To: <7v3ba5tdlj.fsf@dee.twinsun.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28299>

Hi,

On Tue, 3 Oct 2006, Junio Hamano wrote:

> I think it should only show create/delete notes and not even
> diff text.

What exactly is the problem? My tree only has minor patches, which should 
not affect the output of your command, and it does this:

$ git diff --summary --diff-filter=AD next..pu
 create mode 100644 builtin-diff-status.c
 create mode 100644 para-walk.c
 create mode 100644 para-walk.h
 create mode 100644 test-para.c

Ciao,
Dscho
