From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/3] git-archive: add support for --submodules
Date: Sun, 18 Jan 2009 16:51:52 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901181650340.3586@pacific.mpi-cbg.de>
References: <1232275999-14852-1-git-send-email-hjemli@gmail.com> <1232275999-14852-2-git-send-email-hjemli@gmail.com> <1232275999-14852-3-git-send-email-hjemli@gmail.com> <1232275999-14852-4-git-send-email-hjemli@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 18 16:53:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOZxd-0002N7-2w
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 16:53:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933458AbZARPvx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 10:51:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933064AbZARPvx
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 10:51:53 -0500
Received: from mail.gmx.net ([213.165.64.20]:58396 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759926AbZARPvw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 10:51:52 -0500
Received: (qmail invoked by alias); 18 Jan 2009 15:51:50 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp047) with SMTP; 18 Jan 2009 16:51:50 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18ZBzF4be8ZX+kQl3XLvHodNYNWLWqy7nX3xC4oIi
	IN14Fn7dPV9z48
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1232275999-14852-4-git-send-email-hjemli@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.68
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106230>

Hi,

On Sun, 18 Jan 2009, Lars Hjemli wrote:

> @@ -320,6 +323,7 @@ static int parse_archive_args(int argc, const char **argv,
>  	args->base = base;
>  	args->baselen = strlen(base);
>  
> +	set_traverse_gitlinks(submodules);

As I said, this is a per-call thing.  So you need to add that option to 
the archiver_args struct and use it in write_archive_entries().

Ciao,
Dscho
