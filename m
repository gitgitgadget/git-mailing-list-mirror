From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] http-push: refactor request url creation
Date: Thu, 29 Jan 2009 16:10:53 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901291608330.3586@pacific.mpi-cbg.de>
References: <4981C43B.9030409@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 29 16:12:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSYZ5-0004Pc-CA
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 16:12:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755587AbZA2PKe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 10:10:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754695AbZA2PKe
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 10:10:34 -0500
Received: from mail.gmx.net ([213.165.64.20]:54634 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755352AbZA2PKd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 10:10:33 -0500
Received: (qmail invoked by alias); 29 Jan 2009 15:10:30 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp057) with SMTP; 29 Jan 2009 16:10:30 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18kJPUrfbAkDCVNynKyXIr+xvu4O3lt+SvSU8nMeg
	e/02ELr9c0lYgc
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <4981C43B.9030409@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6899999999999999
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107692>

Hi,

On Thu, 29 Jan 2009, Tay Ray Chuan wrote:

> Currently, functions that deal with objects on the remote repository have to
> allocate and
> do strcpys to generate the URL.

That is a funny way to wrap the commit message :-)

> +static void append_remote_object_url(struct strbuf *buf, const char *url,
> const char *hex, int only_two_digit_prefix)

Here, you still have a corrupt patch.  Which might be helped by wrapping 
the overly long line in the first place?

Ciao,
Dscho
