From: Ryan Anderson <ryan@michonline.com>
Subject: Re: Comments on recursive merge..
Date: Sat, 12 Nov 2005 01:35:13 -0500
Message-ID: <43758D21.3060107@michonline.com>
References: <Pine.LNX.4.64.0511070837530.3193@g5.osdl.org>	<20051107225807.GA10937@c165.ib.student.liu.se>	<7vll00ov2l.fsf@assigned-by-dhcp.cox.net>	<Pine.LNX.4.64.0511071629270.3247@g5.osdl.org> <7v4q6ilt3m.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigA6D7E004108C984356BA2866"
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 12 07:35:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eaoz4-0006TM-Hn
	for gcvg-git@gmane.org; Sat, 12 Nov 2005 07:35:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932170AbVKLGf1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 Nov 2005 01:35:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932173AbVKLGf1
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Nov 2005 01:35:27 -0500
Received: from mail.autoweb.net ([198.172.237.26]:6891 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S932170AbVKLGf0 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Nov 2005 01:35:26 -0500
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73] helo=michonline.com)
	by mail.autoweb.net with esmtp (Exim 4.44)
	id 1Eaoys-000096-72; Sat, 12 Nov 2005 01:35:18 -0500
Received: from [10.254.251.12] (helo=mythryan)
	by michonline.com with esmtp (Exim 3.35 #1 (Debian))
	id 1Eaoyr-0006U7-00; Sat, 12 Nov 2005 01:35:17 -0500
Received: from localhost ([127.0.0.1])
	by mythryan with esmtp (Exim 4.54)
	id 1Eaoyr-0000dK-B5; Sat, 12 Nov 2005 01:35:17 -0500
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v4q6ilt3m.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.93.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11659>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA6D7E004108C984356BA2866
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Junio C Hamano wrote:
> Linus Torvalds <torvalds@osdl.org> writes:
> 
> 
>>>Another thing to consider is if it is fast enough for everyday
>>>trivial merges.
>>
>>Hmm. True. The _really_ trivial in-index case triggers for me pretty 
>>often, but I haven't done any statistics. It might be only 50% of the 
>>time.
> 
> 
> Just for fun, I randomly picked two heads/master commits from
> linux-2.6 repository (one was when I happened to have pulled the
> last time, and the other was when I thought this might be an
> interesting exercise and pulled again), and fed the commits
> between the two to a little script that looks at commits and
> tries to stat what they did (the script ignores renames so they
> appear as deletes and adds).

Mind sharing the script?

It'be nice to know if these stats are typical, or unusual when you get
numbers from a variety of other trees.



--------------enigA6D7E004108C984356BA2866
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDdY0kfhVDhkBuUKURAq7GAKCepTha/8APJgMqahWhdP5ofF/36QCfRro9
2CvVCNI1nnunQ0lgmtfvuls=
=oM7J
-----END PGP SIGNATURE-----

--------------enigA6D7E004108C984356BA2866--
