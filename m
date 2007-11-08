From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-branch --with=commit
Date: Thu, 8 Nov 2007 00:09:19 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711080008050.4362@racer.site>
References: <7vpryl8x5t.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 08 01:09:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ipuxq-00030f-7v
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 01:09:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754403AbXKHAJY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 19:09:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754879AbXKHAJY
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 19:09:24 -0500
Received: from mail.gmx.net ([213.165.64.20]:54151 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754304AbXKHAJY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 19:09:24 -0500
Received: (qmail invoked by alias); 08 Nov 2007 00:09:22 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp003) with SMTP; 08 Nov 2007 01:09:22 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/69KE5uQz60NRpPJAYQQStzriyDRY8DOrZw/Z4yX
	YowKzK1che3gg0
X-X-Sender: gene099@racer.site
In-Reply-To: <7vpryl8x5t.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63902>

Hi,

would it not be better to call it --containing=commit?  Besides, I think 
that the opt_parse_with_commit() function would be better named 
opt_parse_commit() and be put into parse-options.[ch].

Ciao,
Dscho
