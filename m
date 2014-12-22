From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 16/18] fsck: support demoting errors to warnings
Date: Mon, 22 Dec 2014 23:57:13 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1412222356400.21312@s15462909.onlinehome-server.info>
References: <cover.1418055173.git.johannes.schindelin@gmx.de> <cdd5730d0003a7220f659804e9e286e77619b57c.1418055173.git.johannes.schindelin@gmx.de> <xmqqzjavgym5.fsf@gitster.dls.corp.google.com> <alpine.DEB.1.00.1412222319370.21312@s15462909.onlinehome-server.info>
 <xmqq38878gao.fsf@gitster.dls.corp.google.com> <alpine.DEB.1.00.1412222344250.21312@s15462909.onlinehome-server.info> <xmqqtx0n710m.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 22 23:57:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3Buq-0005LQ-SI
	for gcvg-git-2@plane.gmane.org; Mon, 22 Dec 2014 23:57:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752137AbaLVW5Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2014 17:57:24 -0500
Received: from mout.gmx.net ([212.227.15.19]:52773 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751262AbaLVW5Y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2014 17:57:24 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx001) with ESMTPSA (Nemesis) id 0LjIit-1XTauU3QcB-00dZDn;
 Mon, 22 Dec 2014 23:57:13 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <xmqqtx0n710m.fsf@gitster.dls.corp.google.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:EUr4tW1w4su3v6DBXvYImO0tvIhiAWRtl4EPezSWvQbrrLovg/k
 Xyu4g4d0Gub4DnwCkbuRdTmGBYyn8YTfL5nv9ox34cKbr336pPRyvhBwHmUQ6DFFdg5/e9h
 5fGCh0Sd9hOxutbw0MYlfMAOuGBk10ppEZW9WJzFdN47C8PwURR97r/z3HixqWqxLEzd43l
 NAazO/r+hrvR0CdKu0Vzg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261694>

Hi Junio,

On Mon, 22 Dec 2014, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Of course you can say that! ;-) The problem these ugly messages try to
> > solve is to give the user a hint which setting to change if they want to
> > override the default behavior, though...
> 
> Ahh, OK, then dashed form would not work as a configuration variable
> names, so missingTaggerEntry would be the only usable option.

Except that cunning me has made it so that both missing-tagger-entry *and*
missingTaggerEntry work...

Ciao,
Dscho
