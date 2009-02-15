From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 4/8] config: Improve variable 'type' handling.
Date: Sun, 15 Feb 2009 13:24:33 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902151323100.10279@pacific.mpi-cbg.de>
References: <1234688460-9248-1-git-send-email-felipe.contreras@gmail.com> <1234688460-9248-2-git-send-email-felipe.contreras@gmail.com> <1234688460-9248-3-git-send-email-felipe.contreras@gmail.com>
 <1234688460-9248-4-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 15 13:25:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYg3X-000683-Ic
	for gcvg-git-2@gmane.org; Sun, 15 Feb 2009 13:25:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753281AbZBOMXk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 07:23:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752974AbZBOMXk
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 07:23:40 -0500
Received: from mail.gmx.net ([213.165.64.20]:60757 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752857AbZBOMXk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 07:23:40 -0500
Received: (qmail invoked by alias); 15 Feb 2009 12:23:38 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp008) with SMTP; 15 Feb 2009 13:23:38 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX193i8YcMRF331eeW0Eip6WtnQCOWDz36GWXEO3tmh
	/uAXEvNEU6XM7Y
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1234688460-9248-4-git-send-email-felipe.contreras@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109999>

Hi,

On Sun, 15 Feb 2009, Felipe Contreras wrote:

> +	switch (types) {
> +	case TYPE_BOOL: type = T_BOOL; break;
> +	case TYPE_INT: type = T_INT; break;
> +	case TYPE_BOOL_OR_INT: type = T_BOOL_OR_INT; break;
> +	default: break;
> +	}

Would it not be nicer to get rid of the variable named "type" and use 
"types == TYPE_BOOL" and similar statements instead?

Ciao,
Dscho
