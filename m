From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] Add git-zip-tree to .gitignore
Date: Mon, 28 Aug 2006 00:34:51 +0200
Message-ID: <44F21E0B.9010600@lsrfire.ath.cx>
References: <44F17FD5.2030000@lsrfire.ath.cx> <7vlkp9x2b9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 28 00:35:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GHTDc-0002xl-4V
	for gcvg-git@gmane.org; Mon, 28 Aug 2006 00:35:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751240AbWH0Wez convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 27 Aug 2006 18:34:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751242AbWH0Wez
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Aug 2006 18:34:55 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:16013
	"EHLO neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S1751240AbWH0Wey (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Aug 2006 18:34:54 -0400
Received: from [10.0.1.3] (p508E7AB6.dip.t-dialin.net [80.142.122.182])
	by neapel230.server4you.de (Postfix) with ESMTP id DBFD636011;
	Mon, 28 Aug 2006 00:34:52 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vlkp9x2b9.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26124>

Junio C Hamano schrieb:
> Although it was my fault applying it already to "master" without=20
> asking this question first, I started to wonder how many more archive
> format people would want, and if it might make more sense to
> consolidate git-*-tree into a single frontend with an option to
> specify the archiver.
>=20
> We would obviously need to keep git-tar-tree as a backward=20
> compatibility alias for "git archive-tree -f tar", but doing things
> that way we do not have to introduce unbounded number of new
> git-{zip,rar,...}-tree programs.

That thought occurred to me, too.  I guess there are not that many more
interesting archive formats, though.  Can we defer adding
git-archive-tree until a third archive format command appears?  I won't
submit another one, I promise. ;-)

Ren=E9
