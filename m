From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Introduce <branch>@{tracked} as shortcut to the tracked
 branch
Date: Thu, 10 Sep 2009 17:24:00 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0909101723260.8306@pacific.mpi-cbg.de>
References: <20090905140127.GA29037@atjola.homenet> <20090905142841.GB15631@coredump.intra.peff.net> <7vfxaz9wfi.fsf@alter.siamese.dyndns.org> <20090907084324.GB17997@coredump.intra.peff.net> <alpine.DEB.1.00.0909071126040.8306@pacific.mpi-cbg.de>
 <20090909104550.GA20108@coredump.intra.peff.net> <7vzl93cncn.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.0909100941330.8306@pacific.mpi-cbg.de> <alpine.DEB.1.00.0909101135590.8306@pacific.mpi-cbg.de> <20090910141618.GB4942@coredump.intra.peff.net>
 <20090910142628.GA7275@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-15?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Pete Wyckoff <pw@padd.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 10 17:22:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MllTl-0004Vn-Pw
	for gcvg-git-2@lo.gmane.org; Thu, 10 Sep 2009 17:22:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751770AbZIJPWZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Sep 2009 11:22:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751709AbZIJPWY
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Sep 2009 11:22:24 -0400
Received: from mail.gmx.net ([213.165.64.20]:58497 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751068AbZIJPWY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Sep 2009 11:22:24 -0400
Received: (qmail invoked by alias); 10 Sep 2009 15:22:26 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp070) with SMTP; 10 Sep 2009 17:22:26 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19cQw0YuQpcK4QwHecEwH6AjdPPCfZZeYEQDaKZAp
	HBoyMuCfHivuDN
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090910142628.GA7275@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128120>

Hi,

On Thu, 10 Sep 2009, Jeff King wrote:

> On Thu, Sep 10, 2009 at 10:16:18AM -0400, Jeff King wrote:
> 
> diff --git a/sha1_name.c b/sha1_name.c
> index a886846..ef4ec11 100644
> --- a/sha1_name.c
> +++ b/sha1_name.c
> @@ -276,7 +276,7 @@ static char *substitute_branch_name(const char **string, int *len)
>  		struct branch *tracking = branch_get(*ref ? ref : NULL);
>  
>  		free(ref);
> -		if (tracking->merge && tracking->merge[0]->dst) {
> +		if (tracking && tracking->merge && tracking->merge[0]->dst) {

Almost.

My version dies if tracking is NULL.

Ciao,
Dscho
