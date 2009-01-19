From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Provide pessimistic defaults for cross compilation
 tests.
Date: Tue, 20 Jan 2009 00:39:44 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901200037510.3586@pacific.mpi-cbg.de>
References: <loom.20090115T123123-915@post.gmane.org> <20090116094110.GD25275@ins.uni-bonn.de> <20090119203400.GA3539@ins.uni-bonn.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Julius Naperkowski <j.nap@gmx.de>, git@vger.kernel.org
To: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jan 20 00:41:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LP3jv-00058y-DI
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 00:41:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754812AbZASXjo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2009 18:39:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754734AbZASXjn
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jan 2009 18:39:43 -0500
Received: from mail.gmx.net ([213.165.64.20]:57198 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754170AbZASXjm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jan 2009 18:39:42 -0500
Received: (qmail invoked by alias); 19 Jan 2009 23:39:40 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp062) with SMTP; 20 Jan 2009 00:39:40 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19DBjBeS/1D/h7xSia9aT4pjPwMWjXONwGJveCeuk
	WVzixnzPJFGrGy
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090119203400.GA3539@ins.uni-bonn.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106406>

Hi,

On Mon, 19 Jan 2009, Ralf Wildenhues wrote:

> In a cross compile setup, configure tests that run programs
> cannot be executed; in that case, provide pessimistic default
> values.

You may want to note in the subject that this patch is about configure.

How do you deal with the hardcoded limitation that uname_S is defined to 
be the output of "uname -s" on the _build_ system, and that quite a large 
part of the Makefile sets variables dependent on this?

IOW are you certain that configure (with your patch) will override _all_ 
uname_S dependent settings?

Ciao,
Dscho
