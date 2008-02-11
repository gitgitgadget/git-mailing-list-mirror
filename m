From: Wincent Colaiuta <win@wincent.com>
Subject: Re: gitweb bug: broken "next" and other links
Date: Mon, 11 Feb 2008 14:33:06 +0100
Message-ID: <0811044D-4929-494F-8189-B0B4AFE2D373@wincent.com>
References: <B0EC9FB3-DDDE-4BC5-92D8-20487CBD6725@wincent.com> <m3ve4vejdr.fsf@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>, Petr Baudis <pasky@suse.cz>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 14:33:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOYn6-00037W-1h
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 14:33:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752207AbYBKNdN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Feb 2008 08:33:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752165AbYBKNdN
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 08:33:13 -0500
Received: from wincent.com ([72.3.236.74]:46004 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752125AbYBKNdM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Feb 2008 08:33:12 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id m1BDX7xT002197;
	Mon, 11 Feb 2008 07:33:08 -0600
In-Reply-To: <m3ve4vejdr.fsf@localhost.localdomain>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73532>

El 11/2/2008, a las 14:02, Jakub Narebski escribi=F3:

> Wincent Colaiuta <win@wincent.com> writes:
>
>> Just noticed a bug (possibly bugs) in gitweb.
>>
>> Look at a shortlog page like this one:
>>
>>  http://repo.or.cz/w/git.git?a=3Dshortlog
>>
>> Mouse over the "next" link at the bottom and you'll see this is the =
=20
>> URL:
>>
>>  http://repo.or.cz/w/ARRAY(0x85a5318)?a=3Dshortlog;pg=3D1
>>
>> Which obviously won't work...
>
> This is bug in repo.or.cz version of gitweb, which is slightly
> modified as compared to the "stock" version. Such error would be
> catched by the gitweb 'run as standalone script and check stderr'
> test script.

Hmm. I don't know. I can reproduce all three of those bugs on my own =20
unmodified gitweb installation from 1.5.4.

Cheers,
Wincent
