From: Olivier Marin <dkr+ml.git@free.fr>
Subject: Re: [PATCH] path-list documentation: document all functions and data
 structures
Date: Sat, 14 Jun 2008 14:50:22 +0200
Message-ID: <4853BE8E.4030009@free.fr>
References: <1213404964-25161-1-git-send-email-vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Don Zickus <dzickus@redhat.com>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sat Jun 14 14:50:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7VDT-0003if-BN
	for gcvg-git-2@gmane.org; Sat, 14 Jun 2008 14:50:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754063AbYFNMty convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Jun 2008 08:49:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754166AbYFNMtx
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jun 2008 08:49:53 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:57721 "EHLO smtp2-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753605AbYFNMtx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jun 2008 08:49:53 -0400
Received: from smtp2-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 093FD12B6F1;
	Sat, 14 Jun 2008 14:49:52 +0200 (CEST)
Received: from [10.253.21.40] (hhe95-1-82-225-56-14.fbx.proxad.net [82.225.56.14])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 9BDB012B6E4;
	Sat, 14 Jun 2008 14:49:51 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (X11/20080505)
In-Reply-To: <1213404964-25161-1-git-send-email-vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85013>

Miklos Vajna a =E9crit :
>=20
> +. Allocates and clears (`memset(&list, \'\0', sizeof(list));`) a
> +  `struct path_list` variable.

What about just `memset(&list, 0, sizeof(list))` instead?

It's readable in the text format, clean in html and this is the way
memset() is used.

Olivier.
