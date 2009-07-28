From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git fast-export: add --no-data option
Date: Tue, 28 Jul 2009 10:01:08 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0907281000360.8306@pacific.mpi-cbg.de>
References: <7f9d599f0907250645s6e6f9b81w3cf20f07eff088eb@mail.gmail.com>  <7vfxcku13i.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.0907251942390.8306@pacific.mpi-cbg.de> <7f9d599f0907270548k15c51a01j1fedba20c66b66f6@mail.gmail.com>
 <alpine.DEB.1.00.0907272042450.6883@intel-tinevez-2-302> <4A6E7A80.9040809@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Geoffrey Irving <irving@naml.us>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 28 10:01:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVhcU-0003JL-F8
	for gcvg-git-2@gmane.org; Tue, 28 Jul 2009 10:01:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751578AbZG1IBC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2009 04:01:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751232AbZG1IBB
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jul 2009 04:01:01 -0400
Received: from mail.gmx.net ([213.165.64.20]:52416 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750862AbZG1IBB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2009 04:01:01 -0400
Received: (qmail invoked by alias); 28 Jul 2009 08:01:00 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp021) with SMTP; 28 Jul 2009 10:01:00 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/++bxTS9L+nSGtSNVi1Ls6Pb8YFx+Gx0811sdb8N
	PM74cvp3bFjxMD
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <4A6E7A80.9040809@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.55
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124218>

Hi,

On Mon, 27 Jul 2009, Stephen Boyd wrote:

> Johannes Schindelin wrote:
> >
> > [PATCH] parse-opt: optionally show "--no-" option string
> >
> > It is usually better to have positive options, to avoid confusing 
> > double negations.  However, sometimes it is desirable to show the 
> > negative option in the help.
> >
> > Introduce the flag PARSE_OPT_NEGHELP to do that.
> 
> Perhaps with this documentation throw in?
> 
> diff --git a/parse-options.h b/parse-options.h
> index 90e577d..14162e9 100644
> --- a/parse-options.h
> +++ b/parse-options.h
> @@ -81,6 +81,9 @@ typedef int parse_opt_cb(const struct option *, const char *arg, int unset);
>   *   PARSE_OPT_LITERAL_ARGHELP: says that argh shouldn't be enclosed in brackets
>   *                             (i.e. '<argh>') in the help message.
>   *                             Useful for options with multiple parameters.
> + *   PARSE_OPT_NEGHELP: says that the long option should always be shown with
> + *                     the --no prefix in the usage message. Sometimes
> + *                     useful for users of OPTION_NEGBIT.
>   *
>   * `callback`::
>   *   pointer to the callback to use for OPTION_CALLBACK.
> 

Thanks.

Ciao,
Dscho
