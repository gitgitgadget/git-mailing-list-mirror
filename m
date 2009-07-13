From: Jeff King <peff@cc.gatech.edu>
Subject: Re: "fatal: index-pack failed" on git-clone
Date: Mon, 13 Jul 2009 00:52:16 -0400
Message-ID: <20090713045215.GC8407@coredump.intra.peff.net>
References: <C92DE6F3-4F35-469F-AC28-4DDD1D8105C2@uchicago.edu>
 <4103BA41-39E4-496F-A76F-17D84F30EA21@uchicago.edu>
 <7vd48b6md8.fsf@alter.siamese.dyndns.org>
 <200907082242.51495.j6t@kdbg.org>
 <7vvdm26bbk.fsf@alter.siamese.dyndns.org>
 <20090709063735.GA22544@coredump.intra.peff.net>
 <4A567D57.7060602@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	Fritz Anderson <fritza@uchicago.edu>, git@vger.kernel.org,
	Daniel Barkalow <barkalow@iabervon.org>
To: A Large Angry SCM <gitzilla@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 13 06:59:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQDd7-0008La-QZ
	for gcvg-git-2@gmane.org; Mon, 13 Jul 2009 06:59:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751366AbZGME7B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jul 2009 00:59:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751180AbZGME7A
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Jul 2009 00:59:00 -0400
Received: from peff.net ([208.65.91.99]:45832 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750801AbZGME67 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jul 2009 00:58:59 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 Jul 2009 00:58:59 EDT
Received: (qmail 31203 invoked by uid 107); 13 Jul 2009 04:54:15 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 13 Jul 2009 00:54:15 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 13 Jul 2009 00:52:16 -0400
Content-Disposition: inline
In-Reply-To: <4A567D57.7060602@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123170>

On Thu, Jul 09, 2009 at 07:29:27PM -0400, A Large Angry SCM wrote:

> This breaks the install if ${bindir} == ${execdir}. The following is
> needed on top Peff's patch.

Oops, I didn't even think to test that (and then I left town all weekend
leaving you to pick up the pieces...:) ). Thanks.
 
-Peff
