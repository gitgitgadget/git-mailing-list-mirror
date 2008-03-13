From: Martin Langhoff <martin@catalyst.net.nz>
Subject: Re: [PATCH] git-cvsimport: fix initial checkout
Date: Fri, 14 Mar 2008 12:29:07 +1300
Message-ID: <47D9B8C3.7000808@catalyst.net.nz>
References: <1205435378-10411-1-git-send-email-marcandre.lureau@gmail.com>	 <47D9A836.9010601@catalyst.net.nz> <e29894ca0803131604qa61adfbo22ff75d076feb899@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 14 00:30:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZws8-0000No-Lv
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 00:30:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753779AbYCMX3L convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Mar 2008 19:29:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753566AbYCMX3K
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 19:29:10 -0400
Received: from godel.catalyst.net.nz ([202.78.240.40]:33244 "EHLO
	mail1.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756598AbYCMX3J (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2008 19:29:09 -0400
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=[192.168.2.113])
	by mail1.catalyst.net.nz with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <martin@catalyst.net.nz>)
	id 1JZwrE-0002YX-9x; Fri, 14 Mar 2008 12:29:08 +1300
User-Agent: Thunderbird 2.0.0.12 (X11/20080227)
In-Reply-To: <e29894ca0803131604qa61adfbo22ff75d076feb899@mail.gmail.com>
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77149>

Marc-Andr=E9 Lureau wrote:
> Yeah, it failed in the middle of a ~4h import, I did not restart it.

there are no guarantees then of correctness (there seldom are, but a
failed import can leave your repo in a number of odd states...).

I'd suggest parsecvs for the initial import of a messy repo. You can
continue to do incrementas with cvsimport after the initial import.

cheers,



m

--=20
-----------------------------------------------------------------------
Martin @ Catalyst .Net .NZ  Ltd, PO Box 11-053, Manners St,  Wellington
WEB: http://catalyst.net.nz/           PHYS: Level 2, 150-154 Willis St
NZ: +64(4)916-7224    MOB: +64(21)364-017    UK: 0845 868 5733 ext 7224
      Make things as simple as possible, but no simpler - Einstein
-----------------------------------------------------------------------
