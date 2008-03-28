From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Silence cpio's "N blocks" output when cloning locally
Date: Fri, 28 Mar 2008 14:01:10 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803281400330.18259@racer.site>
References: <> <1206685186-10352-1-git-send-email-bdonlan@fushizen.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Bryan Donlan <bdonlan@fushizen.net>
X-From: git-owner@vger.kernel.org Fri Mar 28 14:02:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JfEDl-0007CK-Nn
	for gcvg-git-2@gmane.org; Fri, 28 Mar 2008 14:02:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760045AbYC1NBO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Mar 2008 09:01:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758088AbYC1NBN
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Mar 2008 09:01:13 -0400
Received: from mail.gmx.net ([213.165.64.20]:37091 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760019AbYC1NBM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Mar 2008 09:01:12 -0400
Received: (qmail invoked by alias); 28 Mar 2008 13:01:10 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp002) with SMTP; 28 Mar 2008 14:01:10 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+l6T9tbTulxd/can+EaVpzBaMTCxh3tw0PpXiaUF
	Agj/1jGH/iqg/5
X-X-Sender: gene099@racer.site
In-Reply-To: <1206685186-10352-1-git-send-email-bdonlan@fushizen.net>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78401>

Hi,

On Fri, 28 Mar 2008, Bryan Donlan wrote:

> Pass --quiet to cpio in git-clone to hide the (confusing) "0 blocks" 
> message. For compatibility with operating systems which might not 
> support GNUisms, the presence of --quiet is probed for by grepping 
> cpio's --help output.

We have a builtin clone which is almost ready for 'next', and I think that 
this issue would be resolved there anyway.

Ciao,
Dscho
