From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/4] index-pack: Track the object_entry that creates each
 base_data
Date: Mon, 14 Jul 2008 12:15:06 +0200 (CEST)
Message-ID: <alpine.LSU.1.00.0807141214260.32392@wbgn129.biozentrum.uni-wuerzburg.de>
References: <1216001267-33235-1-git-send-email-spearce@spearce.org> <1216001267-33235-2-git-send-email-spearce@spearce.org> <1216001267-33235-3-git-send-email-spearce@spearce.org> <1216001267-33235-4-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Stephan Hennig <mailing_list@arcor.de>,
	Nicolas Pitre <nico@cam.org>, Andreas Ericsson <ae@op5.se>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Jul 14 12:16:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIL6J-0004UM-8c
	for gcvg-git-2@gmane.org; Mon, 14 Jul 2008 12:16:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756451AbYGNKPL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2008 06:15:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756417AbYGNKPL
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 06:15:11 -0400
Received: from mail.gmx.net ([213.165.64.20]:34145 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756102AbYGNKPK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2008 06:15:10 -0400
Received: (qmail invoked by alias); 14 Jul 2008 10:15:08 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO wrzx67.rz.uni-wuerzburg.de) [132.187.25.128]
  by mail.gmx.net (mp015) with SMTP; 14 Jul 2008 12:15:08 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19XH3cm+ylXdxfAlp7dMsDv37bdATCl7PT2FkzYhx
	EA+y6rBb9fsUBC
X-X-Sender: gene099@wbgn129.biozentrum.uni-wuerzburg.de
In-Reply-To: <1216001267-33235-4-git-send-email-spearce@spearce.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.76
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88408>

Hi,

On Sun, 13 Jul 2008, Shawn O. Pearce wrote:

> This however means we must add the missing baes object to the end
> of our packfile prior to calling resolve_delta() on each of the
> dependent deltas.  Adding the base first ensures we can read the
> base back from the pack we indexing, as if it had been included by
> the remote side.

s/baes/base/

Otherwise very clear.

Thanks,
Dscho
