From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Fix reduce_heads
Date: Mon, 14 Jul 2008 11:30:24 +0200 (CEST)
Message-ID: <alpine.LSU.1.00.0807141128240.3486@wbgn129.biozentrum.uni-wuerzburg.de>
References: <402c10cd0807132107s29c470f7hb834bd5c00ef399e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
To: Sverre Hvammen Johansen <hvammen@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 14 11:31:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIKP0-00071A-O7
	for gcvg-git-2@gmane.org; Mon, 14 Jul 2008 11:31:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755884AbYGNJa1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2008 05:30:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756253AbYGNJa1
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 05:30:27 -0400
Received: from mail.gmx.net ([213.165.64.20]:56875 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750923AbYGNJa0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2008 05:30:26 -0400
Received: (qmail invoked by alias); 14 Jul 2008 09:30:24 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO wrzx67.rz.uni-wuerzburg.de) [132.187.25.128]
  by mail.gmx.net (mp038) with SMTP; 14 Jul 2008 11:30:24 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18Q8ZN0T7AQUfTSJuUNPxHFJOHIQIn1DfQCoKKwIr
	kpqeqSJrYndIb6
X-X-Sender: gene099@wbgn129.biozentrum.uni-wuerzburg.de
In-Reply-To: <402c10cd0807132107s29c470f7hb834bd5c00ef399e@mail.gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6899999999999999
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88407>

Hi,

On Sun, 13 Jul 2008, Sverre Hvammen Johansen wrote:

> Reduce_heads used by build in merge failed to find the correct
> heads in cases where duplicate heads are specified.

I liked Junio's explanation better.

> This should fix the last breakage I found. ([PATCH/Test] Build in
> merge is broken)
> I have squashed in Miklos's fix and the two tests cases to protect this.

I'd rather not have it squashed in.  Miklos is a GSoC student, and at the 
end I want to show the shortlog to tell Google how he fared.

Unfortunately, Miklos is on holiday this week, so he cannot send a mail of 
his own.  Junio, could you fake a commit message with a sign-off for 
Miklos, or do you want me to do it?

Ciao,
Dscho
