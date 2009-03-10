From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] builtin-tag.c: remove global variable to use the callback
 data of git-config.
Date: Tue, 10 Mar 2009 14:34:20 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903101432010.14295@intel-tinevez-2-302>
References: <1236690219.20402.28.camel@luis-desktop>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Carlos Rica <jasampler@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 10 14:36:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lh28K-0001Pu-Kp
	for gcvg-git-2@gmane.org; Tue, 10 Mar 2009 14:36:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754681AbZCJNeZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2009 09:34:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753268AbZCJNeZ
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Mar 2009 09:34:25 -0400
Received: from mail.gmx.net ([213.165.64.20]:52930 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753853AbZCJNeY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2009 09:34:24 -0400
Received: (qmail invoked by alias); 10 Mar 2009 13:34:20 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp047) with SMTP; 10 Mar 2009 14:34:20 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19+VYwt61R+pVmOvJEVwJ4Dogr/ogkn5YVPFU9r+w
	YUR3G+Q8hAUUjH
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <1236690219.20402.28.camel@luis-desktop>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112814>

Hi,

On Tue, 10 Mar 2009, Carlos Rica wrote:

> 
> Signed-off-by: Carlos Rica <jasampler@yahoo.es>

Good to see you again!

BTW do you want to be recorded with a different email address in the 
author line than in the S-O-B?

> -static int do_sign(struct strbuf *buffer)
> +struct char_array {
> +	char *buf;
> +	size_t size;
> +};

That looks very much like you want a struct strbuf, no?

Ciao,
Dscho
