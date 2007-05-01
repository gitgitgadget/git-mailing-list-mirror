From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] Optimize diff-delta.c
Date: Tue, 1 May 2007 17:51:06 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0705011748510.4010@racer.site>
References: <1178030967273-git-send-email-mkoegler@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Nicolas Pitre <nico@cam.org>
To: Martin Koegler <mkoegler@auto.tuwien.ac.at>
X-From: git-owner@vger.kernel.org Tue May 01 17:51:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hiud4-0002iW-Hk
	for gcvg-git@gmane.org; Tue, 01 May 2007 17:51:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751682AbXEAPu4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 May 2007 11:50:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751693AbXEAPu4
	(ORCPT <rfc822;git-outgoing>); Tue, 1 May 2007 11:50:56 -0400
Received: from mail.gmx.net ([213.165.64.20]:33598 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751682AbXEAPuz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2007 11:50:55 -0400
Received: (qmail invoked by alias); 01 May 2007 15:50:54 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp030) with SMTP; 01 May 2007 17:50:54 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19xua9R1WFxweweJOtt5qbCxtWia451bXKGZVr5Vc
	v2kIID/6KjTqP7
X-X-Sender: gene099@racer.site
In-Reply-To: <1178030967273-git-send-email-mkoegler@auto.tuwien.ac.at>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45953>

Hi,

On Tue, 1 May 2007, Martin Koegler wrote:

> I tried to speed up the delta generation by searching for a common 
> prefix, as my blobs are mostly append only. I tested it with about less 
> than 1000 big blobs. The time for finding the deltas decreased from 17 
> to 14 minutes cpu time.

The interesting timings, of course, would be of big blobs which are _not_ 
append-only, as they are more common, at least for me.

Since git.git contained next to no binary blobs, this is not a good test 
case.

Ciao,
Dscho
