From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3] config: Add new option to open an editor.
Date: Thu, 5 Feb 2009 00:43:36 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902050043000.10279@pacific.mpi-cbg.de>
References: <94a0d4530902040741t4333b132v886d7057353ed52a@mail.gmail.com> <1233786856-6571-1-git-send-email-felipe.contreras@gmail.com> <7vmyd1lrnx.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 05 00:44:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUrPy-00043X-RT
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 00:44:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754992AbZBDXnF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 18:43:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754210AbZBDXnD
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 18:43:03 -0500
Received: from mail.gmx.net ([213.165.64.20]:41205 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752884AbZBDXnC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 18:43:02 -0500
Received: (qmail invoked by alias); 04 Feb 2009 23:43:00 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp066) with SMTP; 05 Feb 2009 00:43:00 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18JgcBxs2IJpZ2DQI74amOyGBN+Y59YArw104KWqu
	pCzM4H94Nqkh4m
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7vmyd1lrnx.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.73
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108468>

Hi,

On Wed, 4 Feb 2009, Junio C Hamano wrote:

> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > The idea was originated by discussion about usability of manually
> > editing the config file in 'special needs' systems such as Windows. Now
> > the user can forget a bit about where the config files actually are.
> 
> Does this honor core.editor setting in existing configuration files?

It should, as it uses launch_editor().

Ciao,
Dscho
