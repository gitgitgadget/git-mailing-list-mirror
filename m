From: Pascal Obry <pascal@obry.net>
Subject: Re: git-svn checksum mismatch importing large file
Date: Wed, 17 Sep 2008 11:39:07 +0200
Organization: Home - http://www.obry.net
Message-ID: <48D0D03B.4040108@obry.net>
References: <48D0B77E.7010308@obry.net> <20080917082506.GA8849@atjola.homenet>
Reply-To: pascal@obry.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git list <git@vger.kernel.org>, Eric Wong <normalperson@yhbt.net>,
	Avery Pennarun <apenwarr@gmail.com>
To: =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Wed Sep 17 11:40:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KftWJ-0005rF-EJ
	for gcvg-git-2@gmane.org; Wed, 17 Sep 2008 11:40:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752068AbYIQJjO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Sep 2008 05:39:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752011AbYIQJjN
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Sep 2008 05:39:13 -0400
Received: from mu-out-0910.google.com ([209.85.134.188]:63302 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751979AbYIQJjM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Sep 2008 05:39:12 -0400
Received: by mu-out-0910.google.com with SMTP id g7so2316652muf.1
        for <git@vger.kernel.org>; Wed, 17 Sep 2008 02:39:11 -0700 (PDT)
Received: by 10.180.228.12 with SMTP id a12mr1596914bkh.34.1221644351061;
        Wed, 17 Sep 2008 02:39:11 -0700 (PDT)
Received: from ?192.168.0.106? ( [83.199.36.158])
        by mx.google.com with ESMTPS id e17sm16476666fke.10.2008.09.17.02.39.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 17 Sep 2008 02:39:10 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; fr-FR; rv:1.8.1.16) Gecko/20080708 Thunderbird/2.0.0.16 Mnenhy/0.7.5.0
In-Reply-To: <20080917082506.GA8849@atjola.homenet>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96080>


Bj=F6rn,

> Your /tmp is probably to small to hold the temporary file that git-sv=
n
> creates. At least it doesn't fail for me unless I fill my /tmp first.

Hum probably, I did not thought about this given the error message!

> This should be fixed since 29c70e0b3e3183f86f93500882177d0c74069988, =
at
> least it got me a useful error message when I tested it back then.
> Avery, any ideas?

I'm using Git on master. This commit is there, the error message is not
that useful on my side :)

Anyway, what's the best option? Is there a way to specify another tmp
directory to use with git-svn?

--=20

--|------------------------------------------------------
--| Pascal Obry                           Team-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|              http://www.obry.net
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver wwwkeys.pgp.net --recv-key C1082595
