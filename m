From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] color-words: Support diff.color-words config option
Date: Wed, 21 Jan 2009 09:25:08 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901210923580.7929@racer>
References: <alpine.DEB.1.00.0901162208180.3586@pacific.mpi-cbg.de> <200901192145.21115.bss@iguanasuicide.net> <alpine.DEB.1.00.0901201058520.3586@pacific.mpi-cbg.de> <200901202146.58651.bss@iguanasuicide.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: =?ISO-8859-15?Q?Santi_B=E9jar?= <santi@agolina.net>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Junio C Hamano <junio@pobox.com>,
	Teemu Likonen <tlikonen@iki.fi>
To: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
X-From: git-owner@vger.kernel.org Wed Jan 21 09:26:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPYPm-0004Nf-Ki
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 09:26:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754876AbZAUIY5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2009 03:24:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753240AbZAUIY5
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 03:24:57 -0500
Received: from mail.gmx.net ([213.165.64.20]:48131 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753218AbZAUIY4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2009 03:24:56 -0500
Received: (qmail invoked by alias); 21 Jan 2009 08:24:53 -0000
Received: from pD9EB3014.dip0.t-ipconnect.de (EHLO noname) [217.235.48.20]
  by mail.gmx.net (mp068) with SMTP; 21 Jan 2009 09:24:53 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19/kEIleAF/uO/5FHSw6o4BUUrfOop1AT0Suh8Jwo
	5ooLGuoC6xE5R7
X-X-Sender: gene099@racer
In-Reply-To: <200901202146.58651.bss@iguanasuicide.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106576>

Hi,

On Tue, 20 Jan 2009, Boyd Stephen Smith Jr. wrote:

> It uses "diff.wordregex" for reasons mention by Dscho and because that 
> was already what the diff drivers were using.

To be fair, Jakub and Junio mentioned it, too.

> I'm not entirely satisfied with it.  There should probably be some way 
> to force the default behavior (which is a bit faster) even if a global 
> config or diff driver exists.  Also, I think camelCase is better than 
> runtogether so I'd prefer to change "wordregex" -> "wordRegex" across 
> the entire patch set.

Well, the thing is, it _should_ be "wordRegex", _except_ in the strcmp() 
because the config helpers get a downcased key.

Ciao,
Dscho
