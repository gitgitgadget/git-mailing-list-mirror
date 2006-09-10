From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 1/2] archive: allow remote to have more formats than we
 understand.
Date: Sun, 10 Sep 2006 14:05:31 +0200
Message-ID: <4503FF8B.9060209@lsrfire.ath.cx>
References: <7vpse4tcyc.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Franck Bui-Huu <vagabon.xyz@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 10 14:05:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GMO4F-0002ZC-Tb
	for gcvg-git@gmane.org; Sun, 10 Sep 2006 14:05:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750882AbWIJMFd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 10 Sep 2006 08:05:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750871AbWIJMFd
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Sep 2006 08:05:33 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:63424
	"EHLO neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S1750875AbWIJMFc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Sep 2006 08:05:32 -0400
Received: from [10.0.1.3] (p508E7157.dip.t-dialin.net [80.142.113.87])
	by neapel230.server4you.de (Postfix) with ESMTP id B2CCDB040;
	Sun, 10 Sep 2006 14:05:30 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vpse4tcyc.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26794>

Junio C Hamano schrieb:
> This fixes git-archive --remote not to parse archiver arguments;
> otherwise if the remote end implements formats other than the
> one known locally we will not be able to access that format.

Yes!  That's the right separation of work between the two parties.
And git-archive --remote=3Dsomewhere --list starts to magically work. =3D=
)

Thanks,
Ren=E9
