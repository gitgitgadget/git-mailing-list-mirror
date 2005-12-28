From: Kalle Valo <Kalle.Valo@iki.fi>
Subject: Re: [PATCH] debian/ directory
Date: Wed, 28 Dec 2005 18:17:05 +0200
Message-ID: <87oe31urge.kvalo.fsf@purkki.valo.iki.fi>
References: <7v64pbc4fh.fsf@assigned-by-dhcp.cox.net>
	<20051228112018.19646.qmail@c226d15586b0bf.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Dec 28 17:17:16 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ErdzD-000214-2S
	for gcvg-git@gmane.org; Wed, 28 Dec 2005 17:17:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964853AbVL1QRI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Dec 2005 11:17:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932534AbVL1QRH
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Dec 2005 11:17:07 -0500
Received: from purkki.valo.iki.fi ([80.68.90.206]:50951 "EHLO
	purkki.valo.iki.fi") by vger.kernel.org with ESMTP id S932532AbVL1QRH
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Dec 2005 11:17:07 -0500
Received: from localhost
	([127.0.0.1] helo=purkki.valo.iki.fi ident=kvalo)
	by purkki.valo.iki.fi with esmtp (Exim 4.50)
	id 1Erdz8-0005qA-6T
	for git@vger.kernel.org; Wed, 28 Dec 2005 18:17:06 +0200
To: git@vger.kernel.org
In-Reply-To: <20051228112018.19646.qmail@c226d15586b0bf.315fe32.mid.smarden.org> (Gerrit
 Pape's message of "Wed, 28 Dec 2005 12:20:18 +0100")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14100>

Gerrit Pape <pape@smarden.org> writes:

>> different from what I have, so I'd like to avoid potential
>> confusion and reduce work by the official maintainer and myself.
>
> Thanks.  The most notable change is that debhelper isn't used to do the
> packaging stuff, and the build-dependency has been dropped; this is
> after my personal preference.
>
> Below is the diff for reference, I think though it might be better if
> you don't include the debian/ directory in the upstream package at all.

One upside in Junio's debian packages is that they[1] work also in
sarge[2]. If he stops building them, we sarge users will miss them.
Any volunteers to maintain them, for example, through backports.org?

[1] at least git-core and git-doc work
[2] Debian 3.1

-- 
Kalle Valo
