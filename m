From: Fredrik Tolf <fredrik@dolda2000.com>
Subject: Re: [PATCH] Ensure that SSH runs in non-interactive mode
Date: Sat, 19 Jul 2008 20:18:32 +0200
Message-ID: <1216491512.3911.9.camel@pc7.dolda2000.com>
References: <1216487215-6927-1-git-send-email-fredrik@dolda2000.com>
	 <1216490252.10694.58.camel@koto.keithp.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Keith Packard <keithp@keithp.com>
X-From: git-owner@vger.kernel.org Sat Jul 19 20:42:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKHOG-0006ze-69
	for gcvg-git-2@gmane.org; Sat, 19 Jul 2008 20:42:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755508AbYGSSlp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jul 2008 14:41:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755423AbYGSSlp
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jul 2008 14:41:45 -0400
Received: from 1-1-3-7a.rny.sth.bostream.se ([82.182.133.20]:59762 "EHLO
	nerv.dolda2000.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755266AbYGSSlo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jul 2008 14:41:44 -0400
X-Greylist: delayed 1376 seconds by postgrey-1.27 at vger.kernel.org; Sat, 19 Jul 2008 14:41:44 EDT
Received: from [IPv6:2002:52b6:8514:200:21d:7dff:fea1:197] ([IPv6:2002:52b6:8514:200:21d:7dff:fea1:197])
	(authenticated bits=0)
	by nerv.dolda2000.com (8.13.8/8.13.8/Debian-3) with ESMTP id m6JIIWv5017389
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 19 Jul 2008 20:18:32 +0200
In-Reply-To: <1216490252.10694.58.camel@koto.keithp.com>
X-Mailer: Evolution 2.22.2 
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-3.0 (nerv.dolda2000.com [IPv6:2002:52b6:8514:200::1]); Sat, 19 Jul 2008 20:18:32 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89126>

On Sat, 2008-07-19 at 10:57 -0700, Keith Packard wrote:
> On Sat, 2008-07-19 at 19:06 +0200, Fredrik Tolf wrote:
> >  By removing the DISPLAY env variable before forking, SSH
> > can thus be forced into non-interactive mode, without any obvious
> > ill effects.
> 
> This will keep ssh-askpass from using any X-based password input
> program.

Ah, right. Would it be OK to add the `-x' flag to ssh instead? I imagine
that that might make git less portable to SSH implementations other than
OpenSSH, but I don't know if that is considered a problem.

Fredrik Tolf
