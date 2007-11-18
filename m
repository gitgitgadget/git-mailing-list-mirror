From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [PATCH] fetch-pack: Prepare for a side-band demultiplexer in a thread.
Date: Sun, 18 Nov 2007 12:03:37 +0100
Message-ID: <200711181203.37450.robin.rosenberg.lists@dewire.com>
References: <200711172309.28364.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Sun Nov 18 12:01:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IthuX-0008IT-HD
	for gcvg-git-2@gmane.org; Sun, 18 Nov 2007 12:01:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751405AbXKRLBl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 Nov 2007 06:01:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751398AbXKRLBl
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Nov 2007 06:01:41 -0500
Received: from [83.140.172.130] ([83.140.172.130]:21344 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751366AbXKRLBk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Nov 2007 06:01:40 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 9CF158026DE;
	Sun, 18 Nov 2007 11:52:30 +0100 (CET)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 02822-04; Sun, 18 Nov 2007 11:52:30 +0100 (CET)
Received: from [10.9.0.4] (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id 327F58026DC;
	Sun, 18 Nov 2007 11:52:30 +0100 (CET)
User-Agent: KMail/1.9.7
In-Reply-To: <200711172309.28364.johannes.sixt@telecom.at>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65366>

l=F6rdag 17 november 2007 skrev Johannes Sixt:
> Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
> ---
> 	This change again originates from the MinGW port. Since we don't
> 	have fork(2) on Windows, we must run the sideband demultiplexer
> 	in a thread.

I think this explanation deserves a place in the commit too.

-- robin
