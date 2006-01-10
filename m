From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] Remember and use GIT_EXEC_PATH on exec()'s
Date: Tue, 10 Jan 2006 20:55:01 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0601102054200.27363@wbgn013.biozentrum.uni-wuerzburg.de>
References: <1136849678.11717.514.camel@brick.watson.ibm.com>
 <1136849810.11717.518.camel@brick.watson.ibm.com> <7vwth8bxqd.fsf@assigned-by-dhcp.cox.net>
 <1136900174.11717.537.camel@brick.watson.ibm.com> <43C3CC4A.4030805@op5.se>
 <1136910406.11717.579.camel@brick.watson.ibm.com> <7vzmm36f1x.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Michal Ostrowski <mostrows@watson.ibm.com>,
	Andreas Ericsson <ae@op5.se>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 10 20:55:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EwPaX-0001gQ-He
	for gcvg-git@gmane.org; Tue, 10 Jan 2006 20:55:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932545AbWAJTzF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jan 2006 14:55:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932544AbWAJTzF
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jan 2006 14:55:05 -0500
Received: from wrzx35.rz.uni-wuerzburg.de ([132.187.3.35]:64978 "EHLO
	wrzx35.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932540AbWAJTzC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jan 2006 14:55:02 -0500
Received: from amavis.mail (amavis2.rz.uni-wuerzburg.de [132.187.3.47])
	by wrzx35.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id ED6B2E4261; Tue, 10 Jan 2006 20:55:01 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by amavis.mail (Postfix) with ESMTP id DEB931893;
	Tue, 10 Jan 2006 20:55:01 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by amavis.mail (Postfix) with ESMTP id C3946188B;
	Tue, 10 Jan 2006 20:55:01 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 0E63D14135E; Tue, 10 Jan 2006 20:55:01 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vzmm36f1x.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
X-Spam-Status: No, hits=0.0 tagged_above=0.0 required=8.0 tests=
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14443>

Hi,

On Tue, 10 Jan 2006, Junio C Hamano wrote:

> Michal Ostrowski <mostrows@watson.ibm.com> writes:
> 
> > git programs exec other git programs, but they also exec non-git
> > programs.  I think it is not appropriate to change PATH (via
> > prepend_to_path) because this may result in unexpected behavior when
> > exec'ing non-git programs:
> 
> This is a valid concern.

Why? If what is prepended to PATH only contains git programs?

Ciao,
Dscho
