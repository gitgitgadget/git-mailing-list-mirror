From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/8] Switch to run_command_v_opt in revert
Date: Sat, 10 Mar 2007 17:55:44 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703101755090.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20070310082728.GA4133@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Mar 10 17:55:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQ4rI-0001NJ-TH
	for gcvg-git@gmane.org; Sat, 10 Mar 2007 17:55:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767884AbXCJQzq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Mar 2007 11:55:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933498AbXCJQzq
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Mar 2007 11:55:46 -0500
Received: from mail.gmx.net ([213.165.64.20]:37431 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933491AbXCJQzp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Mar 2007 11:55:45 -0500
Received: (qmail invoked by alias); 10 Mar 2007 16:55:43 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO wbgn013.biozentrum.uni-wuerzburg.de) [132.187.25.13]
  by mail.gmx.net (mp025) with SMTP; 10 Mar 2007 17:55:43 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/QQDpjerXQ2HV3eRFPDWMl/ujxmHTJLj3tTz9GN8
	U9qNiV6uc1dgUL
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20070310082728.GA4133@spearce.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41870>

Hi,

On Sat, 10 Mar 2007, Shawn O. Pearce wrote:

> Another change by me is removing the va_list variants of run_command,
> one of which is used by builtin-revert.c.  To avoid compile errors
> I'm refactoring builtin-revert to use the char** variant instead,
> as that variant is staying.
> 
> Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
> ---
> 
>  This is on top of Dscho's builtin revert topic, currently in next.
>  The rest of this series is however on top of master.

ACK.

I did not realize that -revert and -cherry-pick would be the only users...

Ciao,
Dscho
