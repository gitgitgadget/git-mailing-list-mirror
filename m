From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Re* git remote --mirror bug?
Date: Tue, 18 Mar 2008 15:04:15 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0803181503240.3200@eeepc-johanness>
References: <1205499956.7589.4.camel@gentoo-jocke.transmode.se> <1205604534.7589.20.camel@gentoo-jocke.transmode.se> <7v1w6bj7f9.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: joakim.tjernlund@transmode.se, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 18 15:04:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JbcQy-0000gH-D0
	for gcvg-git-2@gmane.org; Tue, 18 Mar 2008 15:04:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753082AbYCROEO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Mar 2008 10:04:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752959AbYCROEO
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Mar 2008 10:04:14 -0400
Received: from mail.gmx.net ([213.165.64.20]:34597 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752852AbYCROEN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Mar 2008 10:04:13 -0400
Received: (qmail invoked by alias); 18 Mar 2008 14:04:11 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO [192.168.0.59]) [132.187.25.128]
  by mail.gmx.net (mp032) with SMTP; 18 Mar 2008 15:04:11 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/je4cMth3j27f3LZptyk1IiPDIXZfgAIhy0onDQq
	WkFe8xOtI8vEam
X-X-Sender: user@eeepc-johanness
In-Reply-To: <7v1w6bj7f9.fsf_-_@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77501>

Hi,

On Sun, 16 Mar 2008, Junio C Hamano wrote:

> Joakim Tjernlund <joakim.tjernlund@transmode.se> writes:
> 
> >> git remote show os2kernel 
> >> * remote os2kernel
> >>   URL: /usr/local/src/os2kernel
> >> Warning: unrecognized mapping in remotes.os2kernel.fetch: +refs/*:refs/*
> 
> This is very unfortunate.
>
> [...]
>
>  builtin-check-ref-format.c |    2 +-
>  git-parse-remote.sh        |    9 +++++++--
>  remote.c                   |   16 +++++++++++++---
>  3 files changed, 21 insertions(+), 6 deletions(-)

Thanks for the fix, and sorry for not being available to fix it myself.

Ciao,
Dscho
