From: =?ISO-8859-1?Q?Lukas_Sandstr=F6m?= <lukass@etek.chalmers.se>
Subject: Re: Cloning from sites with 404 overridden
Date: Mon, 20 Mar 2006 19:29:02 +0100
Message-ID: <441EF46E.5050907@etek.chalmers.se>
References: <e5bfff550603190252n7e3e1cbbp94e3f15c92f12d07@mail.gmail.com>	<4d8e3fd30603190525o5a01fba8w5bcdedd064c213ec@mail.gmail.com>	<e5bfff550603190604ne4364f3o6a862d25267a2dce@mail.gmail.com> <7vk6aqql9e.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <junkio@cox.net>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 20 19:29:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FLP7u-0004Aq-Vm
	for gcvg-git@gmane.org; Mon, 20 Mar 2006 19:29:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750719AbWCTS3H convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 20 Mar 2006 13:29:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751067AbWCTS3H
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Mar 2006 13:29:07 -0500
Received: from pne-smtpout1-sn2.hy.skanova.net ([81.228.8.83]:45045 "EHLO
	pne-smtpout1-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S1750920AbWCTS3G (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Mar 2006 13:29:06 -0500
Received: from [192.168.0.82] (213.66.95.18) by pne-smtpout1-sn2.hy.skanova.net (7.2.070)
        id 44184DEA00125FE7; Mon, 20 Mar 2006 19:29:02 +0100
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051015)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
In-Reply-To: <7vk6aqql9e.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17759>

Junio C Hamano wrote:
> "Marco Costalba" <mcostalba@gmail.com> writes:
>>http://digilander.libero.it /mcostalba/scm/qgit.git/objects/8d/ea0351=
9e75f47d
>=20
> To be fair, the site is _not_ missing anything from HTTP
> protocol perspective, because when git asks 8d/ea0351... file,
> the server responds with a regular "HTTP/1.0 200 OK" response.
> So it is _your_ repository that is corrupt -- instead of
> correctly _lacking_ the file you should have removed with
> prune-packed, it has a garbage file.

Actually, it sends a 302 redirect.=20

Perhaps a repository config option to treat a 302 as a 404?

/Lukas Sandstr=F6m
