From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 08/13] Add support for "import" helper command
Date: Wed, 5 Aug 2009 22:56:57 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908052254570.8306@pacific.mpi-cbg.de>
References: <alpine.LNX.2.00.0908050055550.2147@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johan Herland <johan@herland.net>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Aug 05 22:56:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYnXZ-00088T-Le
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 22:56:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751529AbZHEU4d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 16:56:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751458AbZHEU4d
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 16:56:33 -0400
Received: from mail.gmx.net ([213.165.64.20]:53524 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751267AbZHEU4d (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 16:56:33 -0400
Received: (qmail invoked by alias); 05 Aug 2009 20:56:32 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp062) with SMTP; 05 Aug 2009 22:56:32 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/00o0a30H0BhxPkllnVv6PVMmnkGManX0GAwqIIg
	l2JOCF5Put9v2v
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.LNX.2.00.0908050055550.2147@iabervon.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124979>

Hi,

On Wed, 5 Aug 2009, Daniel Barkalow wrote:

> This command, supported if the "import" capability is advertized,
> allows a helper to support fetching by outputting a git-fast-import
> stream.

  If both the "import" and the "fetch" capability are advertised, the 
  "import" capability is ignored.

> diff --git a/Documentation/git-remote-helpers.txt b/Documentation/git-remote-helpers.txt
> index 173ee23..e9aa67e 100644
> --- a/Documentation/git-remote-helpers.txt
> +++ b/Documentation/git-remote-helpers.txt
> @@ -43,6 +43,13 @@ Commands are given by the caller on the helper's standard input, one per line.
>  +
>  Supported if the helper has the "fetch" capability.
>  
> +'import' <name>::
> +	Produces a fast-import stream which imports the current value
> +	of the named ref. It may additionally import other refs as
> +	needed to construct the history efficiently.
> ++
> +Supported if the helper has the "import" capability.

                                                      , but ignored if the 
+helper offers the "fetch" capability.

Ciao,
Dscho

--
Sent from my EeePC
