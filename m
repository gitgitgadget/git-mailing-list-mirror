From: Michal Rokos <michal.rokos@nextsoft.cz>
Subject: Re: [Patch] Using 'perl' in *.sh
Date: Mon, 10 Jul 2006 07:41:26 +0200
Organization: NextSoft
Message-ID: <200607100741.26377.michal.rokos@nextsoft.cz>
References: <200607081732.04273.michal.rokos@nextsoft.cz> <200607091441.16161.michal.rokos@nextsoft.cz> <7v4pxqfri7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 10 07:42:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FzoWZ-00010k-0v
	for gcvg-git@gmane.org; Mon, 10 Jul 2006 07:41:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751343AbWGJFle convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 10 Jul 2006 01:41:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751344AbWGJFle
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Jul 2006 01:41:34 -0400
Received: from s3.icr.cz ([82.142.72.7]:18889 "EHLO s3.icr.cz")
	by vger.kernel.org with ESMTP id S1751343AbWGJFle convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jul 2006 01:41:34 -0400
Received: (from root@localhost)
	by s3.icr.cz (8.11.4/8.11.4) id k6A5fR430757;
	Mon, 10 Jul 2006 07:41:27 +0200
Received: from michal.rokos.cz (mx1.evangnet.cz [88.83.237.35] (may be forged))
	by s3.icr.cz (8.11.4/8.11.4) with ESMTP id k6A5fQS30717;
	Mon, 10 Jul 2006 07:41:26 +0200
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.9.3
In-Reply-To: <7v4pxqfri7.fsf@assigned-by-dhcp.cox.net>
X-scanner: scanned by Inflex 1.0.10 - (http://pldaniels.com/inflex/)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23591>

Hi,

On Sunday 09 July 2006 22:33, Junio C Hamano wrote:
> Invocation of perl _in_ scripts can be controlled by user's
> PATH, but #! cannot be.  As Merlyn says 'env' is a nice hack,
> but we configure the scripts we install to have #!  pointing at
> the right interpreter as a more cleaner (than using 'env', that
> is) workaround anyway, so #! pointing at PERL_PATH and scripts
> relying on user's $PATH would be the right thing to do.

I don't se the point. If you ask me, I'd say it should be either:
- controlled fully via env: which means 'perl' in scripts and /usr/bin/=
env in=20
*.perl; or
- set during install: which means 'full perl path' in scripts as well a=
s in=20
*.perl

Any mixture of above makes no sence to me. I'm afraid that any consensu=
s will=20
be hard to reach, but I don't see any other way round. (Well maybe some=
 git=20
specific exec wrapper to come over some broken 'env' commands)

M.

--=20
Michal Rokos

NextSoft s.r.o.
Vysko=C4=8Dilova 1/1410
140 21 Praha 4
phone:  +420 267 224 311
fax:    +420 267 224 307
mobile: +420 736 646 591
e-mail: michal.rokos@nextsoft.cz
