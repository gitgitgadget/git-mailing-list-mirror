From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] pull: introduce a pull.rebase option to enable
 --rebase
Date: Sat, 5 Nov 2011 10:55:52 -0500 (CDT)
Message-ID: <alpine.DEB.1.00.1111051054380.32316@s15462909.onlinehome-server.info>
References: <1320507358-3407-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1784107012-1464368307-1320508552=:32316"
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Eric Herman <eric@freesa.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Fernando Vezzosi <buccia@repnz.net>
To: =?ISO-8859-15?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 05 16:56:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMibA-0006Uf-2V
	for gcvg-git-2@lo.gmane.org; Sat, 05 Nov 2011 16:56:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752916Ab1KEPzz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Nov 2011 11:55:55 -0400
Received: from mailout-de.gmx.net ([213.165.64.23]:60315 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751641Ab1KEPzz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Nov 2011 11:55:55 -0400
Received: (qmail invoked by alias); 05 Nov 2011 15:55:52 -0000
Received: from s15462909.onlinehome-server.info (EHLO s15462909.onlinehome-server.info) [87.106.4.80]
  by mail.gmx.net (mp011) with SMTP; 05 Nov 2011 16:55:52 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+a469pB3Saq9bl2qEoopnu0VYo2wy1VgHULy0OrX
	Rrm6PgU0GI7G5T
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <1320507358-3407-1-git-send-email-avarab@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184855>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1784107012-1464368307-1320508552=:32316
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

On Sat, 5 Nov 2011, Ævar Arnfjörð Bjarmason wrote:

> Currently we either need to set branch.<name>.rebase for existing 
> branches if we'd like "git pull" to mean "git pull --rebase", or have 
> the forethought of setting "branch.autosetuprebase" before we create the 
> branch.
> 
> But there's no way to globally configure "git pull" to mean "git pull 
> --rebase" for existing branches, introduce a "pull.rebase" option to do 
> that.
> 
> This option will be considered at a lower priority than 
> branch.<name>.rebase, i.e. we could set pull.rebase=true and 
> branch.<name>.rebase=false and the latter configuration option would 
> win.

Nice.

Ciao,
Johannes
--1784107012-1464368307-1320508552=:32316--
