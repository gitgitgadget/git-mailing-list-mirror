From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [msysGit] [PATCH/RFC] alias: use run_command api to execute
 aliases
Date: Fri, 7 Jan 2011 02:17:19 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1101070216390.1542@bonsai2>
References: <1294341187-3956-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, msysgit@googlegroups.com, j6t@kdbg.org
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 07 02:17:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pb0xM-0003Kw-VR
	for gcvg-git-2@lo.gmane.org; Fri, 07 Jan 2011 02:17:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755176Ab1AGBRY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jan 2011 20:17:24 -0500
Received: from mailout-de.gmx.net ([213.165.64.22]:59134 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1754849Ab1AGBRX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jan 2011 20:17:23 -0500
Received: (qmail invoked by alias); 07 Jan 2011 01:17:21 -0000
Received: from pD9EB23F8.dip0.t-ipconnect.de (EHLO noname) [217.235.35.248]
  by mail.gmx.net (mp066) with SMTP; 07 Jan 2011 02:17:21 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19cKAgRtBJcfE8Dl3g0yp2luqxfREYZ5TYpO4laMp
	IMb5uz83w2zTLg
X-X-Sender: gene099@bonsai2
In-Reply-To: <1294341187-3956-1-git-send-email-kusmabite@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164692>

Hi,

On Thu, 6 Jan 2011, Erik Faye-Lund wrote:

> On Windows, system() executes with cmd.exe instead of /bin/sh. This
> means that aliases currently has to be batch-scripts instead of
> bourne-scripts. On top of that, cmd.exe does not handle single quotes,
> which is what the code-path currently uses to handle arguments with
> spaces.
> 
> To solve both problems in one go, use run_command_v_opt() to execute
> the alias. It already does the right thing prepend "sh -c " to the
> alias.

Would this not break setups where aliases were defined to execute batch 
scripts?

If this is true, I'm of two minds here.

Ciao,
Dscho
