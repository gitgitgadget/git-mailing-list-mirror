From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [PATCH] Add a new lstat implementation based on Win32 API, and make stat use that implementation too.
Date: Sun, 2 Sep 2007 22:27:59 +0200
Message-ID: <200709022228.00733.robin.rosenberg.lists@dewire.com>
References: <46DACD93.9000509@trolltech.com> <46DB0478.8050402@trolltech.com> <46DB0F9C.2090306@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Marius Storm-Olsen <marius@trolltech.com>
X-From: git-owner@vger.kernel.org Sun Sep 02 22:26:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRw22-00088j-QR
	for gcvg-git@gmane.org; Sun, 02 Sep 2007 22:26:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751049AbXIBU02 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 2 Sep 2007 16:26:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752562AbXIBU02
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Sep 2007 16:26:28 -0400
Received: from [83.140.172.130] ([83.140.172.130]:18651 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1750874AbXIBU01 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2007 16:26:27 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 9C12C802866;
	Sun,  2 Sep 2007 22:18:32 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 01234-05; Sun,  2 Sep 2007 22:18:32 +0200 (CEST)
Received: from [10.9.0.3] (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 23D9680267F;
	Sun,  2 Sep 2007 22:18:32 +0200 (CEST)
User-Agent: KMail/1.9.6
In-Reply-To: <46DB0F9C.2090306@trolltech.com>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57386>

s=F6ndag 02 september 2007 skrev Marius Storm-Olsen:
> (Also, since Windows doesn't really handle symlinks, it's fine that s=
tat just uses lstat)

It does now: See http://msdn2.microsoft.com/en-us/library/aa363866.aspx

-- robin
