From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 4/4] prune-packed: migrate to parse-options
Date: Thu, 9 Jul 2009 12:51:37 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0907091250120.4339@intel-tinevez-2-302>
References: <1247030141-11695-1-git-send-email-bebarino@gmail.com> <1247030141-11695-2-git-send-email-bebarino@gmail.com> <1247030141-11695-3-git-send-email-bebarino@gmail.com> <1247030141-11695-4-git-send-email-bebarino@gmail.com>
 <1247030141-11695-5-git-send-email-bebarino@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 09 12:51:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOrEF-00051A-M6
	for gcvg-git-2@gmane.org; Thu, 09 Jul 2009 12:51:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759018AbZGIKvm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2009 06:51:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757349AbZGIKvl
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jul 2009 06:51:41 -0400
Received: from mail.gmx.net ([213.165.64.20]:36504 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756647AbZGIKvk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2009 06:51:40 -0400
Received: (qmail invoked by alias); 09 Jul 2009 10:51:38 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp014) with SMTP; 09 Jul 2009 12:51:38 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18bOWVnYcobsbraORSFlFRv+MdT1TwLDMBzOgTiu5
	0fbJ38LeqT+6fv
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <1247030141-11695-5-git-send-email-bebarino@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122965>

Hi,

I reviewed all four patches, and like them.  Just a minor nit:

On Tue, 7 Jul 2009, Stephen Boyd wrote:

> Add --dry-run and --quiet to be more consistent with the rest of git.

You should say here that you add the _long_ options (the short options 
were supported already); I almost expected you to sneak in additional 
features with the parseoptification.

Same goes for 3/4, I guess.

Thanks,
Dscho
