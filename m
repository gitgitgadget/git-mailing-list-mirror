From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 1/8] config: Trivial rename in preparation for 
 parseopt.
Date: Tue, 17 Feb 2009 13:01:47 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902171300450.6185@intel-tinevez-2-302>
References: <1234832094-15541-1-git-send-email-felipe.contreras@gmail.com>  <7v3aedet0j.fsf@gitster.siamese.dyndns.org> <94a0d4530902161842s1d1d9fech3786cce1f1a1135d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Gerrit Pape <pape@smarden.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 17 13:03:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZOfZ-0002gx-0y
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 13:03:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751321AbZBQMBx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 07:01:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751249AbZBQMBx
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 07:01:53 -0500
Received: from mail.gmx.net ([213.165.64.20]:44482 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750952AbZBQMBw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 07:01:52 -0500
Received: (qmail invoked by alias); 17 Feb 2009 12:01:51 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp039) with SMTP; 17 Feb 2009 13:01:51 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18VajoyGuAVZpuAgqu55aArDC41BE1cHWz/NZQM8p
	b9qtHieaxS4C5h
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <94a0d4530902161842s1d1d9fech3786cce1f1a1135d@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110364>

Hi,

On Tue, 17 Feb 2009, Felipe Contreras wrote:

>         free(repo_config);
> +       if (found == 0)
> +               error("no config file found");
>         return ret;

Err, you mean "return error(..)"?

But it might be not an error at all: think of "cd / && git ls-remote $URL" 
without /etc/gitconfig nor $HOME/.gitconfig.

Ciao,
Dscho
