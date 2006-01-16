From: Alexander Litvinov <lan@ac-sw.com>
Subject: Re: RFC: Subprojects
Date: Mon, 16 Jan 2006 13:28:04 +0600
Organization: AcademSoft Ltd.
Message-ID: <200601161328.04985.lan@ac-sw.com>
References: <43C52B1F.8020706@hogyros.de> <Pine.LNX.4.64.0601110928350.5073@g5.osdl.org> <7vacdzkww3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 16 08:28:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EyOmt-0006j3-Op
	for gcvg-git@gmane.org; Mon, 16 Jan 2006 08:28:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932188AbWAPH2M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 16 Jan 2006 02:28:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932207AbWAPH2M
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jan 2006 02:28:12 -0500
Received: from gw.ac-sw.com ([81.1.223.2]:57804 "EHLO gw.ac-sw.com")
	by vger.kernel.org with ESMTP id S932188AbWAPH2L convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jan 2006 02:28:11 -0500
Received: from localhost (localhost [127.0.0.1])
	by gw.ac-sw.com (Postfix) with ESMTP id B2892BD5D;
	Mon, 16 Jan 2006 13:28:09 +0600 (NOVT)
Received: from gw.ac-sw.com ([127.0.0.1])
 by localhost (gw.ac-sw.com [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 18131-08; Mon, 16 Jan 2006 13:28:07 +0600 (NOVT)
Received: from lan.ac-sw.lcl (lan.ac-sw.lcl [192.168.0.69])
	by gw.ac-sw.com (Postfix) with ESMTP id 9A7C7BD41;
	Mon, 16 Jan 2006 13:28:07 +0600 (NOVT)
Received: by lan.ac-sw.lcl (Postfix, from userid 65534)
	id 96E358F11709; Mon, 16 Jan 2006 13:28:07 +0600 (NOVT)
Received: from localhost (localhost [127.0.0.1])
	by lan.ac-sw.lcl (Postfix) with ESMTP id 39DE78CE9BC2;
	Mon, 16 Jan 2006 13:28:05 +0600 (NOVT)
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.8
In-Reply-To: <7vacdzkww3.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Virus-Scanned: amavisd-new at gw.ac-sw.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14725>

On Saturday 14 January 2006 14:59, Junio C Hamano wrote:
> Now I'll think aloud about a completely different design.
>
> We could simply overlay the projects. =A0I think this is what
> Johannes suggested earlier.
>
> You keep one branch for each "subproject", and make commits into
> each branch (i.e. if you modified files for the upstream kernel,
> the change is committed to the branch for linux-2.6 subproject),
> but when checking things out, you do an equivalent of octopus
> merge across subprojects.
If I cleary understand this idea it is NOT that I dreaming about. Almos=
t all=20
our sub-projects are used in more than one project (imaging network lay=
er=20
library). So variant with gitlink is that I willing.
