From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [PATCH] Lose perl dependency. (fwd)
Date: Sun, 21 Jan 2007 01:37:40 +0100
Organization: Dewire
Message-ID: <200701210137.41219.robin.rosenberg.lists@dewire.com>
References: <Pine.LNX.4.63.0701181149260.22628@wbgn013.biozentrum.uni-wuerzburg.de> <7vwt3h7dp6.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0701202240210.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 21 01:37:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8Qi9-0008CC-DT
	for gcvg-git@gmane.org; Sun, 21 Jan 2007 01:37:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750974AbXAUAh0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 20 Jan 2007 19:37:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750983AbXAUAhZ
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Jan 2007 19:37:25 -0500
Received: from [83.140.172.130] ([83.140.172.130]:21217 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1750974AbXAUAhZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 20 Jan 2007 19:37:25 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 265E5802E10;
	Sun, 21 Jan 2007 01:32:53 +0100 (CET)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 20160-02; Sun, 21 Jan 2007 01:32:52 +0100 (CET)
Received: from [10.9.0.2] (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id D78FA802657;
	Sun, 21 Jan 2007 01:32:52 +0100 (CET)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
User-Agent: KMail/1.9.4
In-Reply-To: <Pine.LNX.4.63.0701202240210.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37298>

l=F6rdag 20 januari 2007 23:04 skrev Johannes Schindelin:
> +--reverse::
> +
> +	Output the commits in reverse order.
> +

The --reverse is really bad naming since the default *is* to list commi=
ts in=20
reverse order. Name it "--chronological" or something to indicate that =
you do=20
not want the default reverse order.=20

Some suggestions:
	--chronological
	--forward
	--noreverse
	--commit-order

-- robin
