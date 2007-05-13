From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: RFH for [PATCH] Optimized cvsexportcommit: calling 'cvs status' only once instead of once per changed file.
Date: Sun, 13 May 2007 23:51:24 +0200
Organization: Dewire
Message-ID: <200705132351.24867.robin.rosenberg.lists@dewire.com>
References: <0056A63A-D511-4FDD-82A6-A13B06E237E9@zib.de> <7vd519m9z7.fsf@assigned-by-dhcp.cox.net> <7vps54qvya.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Steffen Prohaska" <prohaska@zib.de>,
	"Martin Langhoff" <martin.langhoff@gmail.com>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun May 13 23:51:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnLyP-0005c9-7a
	for gcvg-git@gmane.org; Sun, 13 May 2007 23:51:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755413AbXEMVvT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 13 May 2007 17:51:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755793AbXEMVvT
	(ORCPT <rfc822;git-outgoing>); Sun, 13 May 2007 17:51:19 -0400
Received: from [83.140.172.130] ([83.140.172.130]:22676 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1755413AbXEMVvS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 May 2007 17:51:18 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id F349B8028BD;
	Sun, 13 May 2007 23:45:06 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 04310-09; Sun, 13 May 2007 23:45:06 +0200 (CEST)
Received: from [10.9.0.4] (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id A01C28027ED;
	Sun, 13 May 2007 23:45:06 +0200 (CEST)
User-Agent: KMail/1.9.6
In-Reply-To: <7vps54qvya.fsf_-_@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47183>

s=F6ndag 13 maj 2007 skrev Junio C Hamano:
> I'd like to have feedbacks on this patch, as I think what it
> tries to do is sensible and worth to have it in v1.5.2 if it
> works for people.
>=20
> Ack?  Nack?  YesButNeedsmorework?

Looks good, but I haven't tried it for production work yet.

-- robin
