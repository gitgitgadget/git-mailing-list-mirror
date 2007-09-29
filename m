From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 1/4] Rework progress module so that it uses less screen
 lines, with progress bars.
Date: Sat, 29 Sep 2007 10:33:44 -0400 (EDT)
Message-ID: <alpine.LFD.0.9999.0709291030010.17881@xanadu.home>
References: "20070929090121.GA4216@artemis.corp"
 <1191062758-30631-1-git-send-email-madcoder@debian.org>
 <1191062758-30631-2-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Sat Sep 29 16:33:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IbdOE-0004rI-W0
	for gcvg-git-2@gmane.org; Sat, 29 Sep 2007 16:33:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753842AbXI2Odr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Sep 2007 10:33:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753862AbXI2Odq
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Sep 2007 10:33:46 -0400
Received: from relais.videotron.ca ([24.201.245.36]:18537 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751636AbXI2Odq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Sep 2007 10:33:46 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JP4004SRWG83N30@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 29 Sep 2007 10:33:45 -0400 (EDT)
In-reply-to: <1191062758-30631-2-git-send-email-madcoder@debian.org>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59470>

On Sat, 29 Sep 2007, Pierre Habouzit wrote:

> Signed-off-by: Pierre Habouzit <madcoder@debian.org>

NAK.

I don't mind the progress bar, but please don't supress the printing of 
the number of objects.  This is the only indication we have to 
guesstimate the time needed for given operation.


Nicolas
