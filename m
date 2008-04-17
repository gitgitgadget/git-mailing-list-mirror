From: Wincent Colaiuta <win@wincent.com>
Subject: Re: gitweb: pathinfo feature breaks commitdiff/raw links
Date: Thu, 17 Apr 2008 11:57:32 +0200
Message-ID: <869CFE40-B245-4744-A9D5-0F3FA623633F@wincent.com>
References: <20080417092339.GA17016@piper.oerlikon.madduck.net>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git discussion list <git@vger.kernel.org>
To: martin f krafft <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Thu Apr 17 12:00:31 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmQtE-0003Cq-W9
	for gcvg-git-2@gmane.org; Thu, 17 Apr 2008 11:58:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935522AbYDQJ5q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Apr 2008 05:57:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935518AbYDQJ5p
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Apr 2008 05:57:45 -0400
Received: from wincent1.inetu.net ([209.235.192.161]:57361 "EHLO
	wincent1.inetu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935512AbYDQJ5o convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Apr 2008 05:57:44 -0400
Received: from cuzco.lan (105.pool85-53-7.dynamic.orange.es [85.53.7.105])
	(authenticated bits=0)
	by wincent1.inetu.net (8.13.8/8.13.8) with ESMTP id m3H9vXPN007717
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Thu, 17 Apr 2008 05:57:36 -0400
In-Reply-To: <20080417092339.GA17016@piper.oerlikon.madduck.net>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79780>

El 17/4/2008, a las 11:23, martin f krafft escribi=F3:
> Hello,
>
> as per suggestion in gitweb.cgi, I put the following into my
> gitweb.conf:
>
>  $feature{'pathinfo'}{'default'} =3D [1];
>
> This mostly works, but James Vega recently found a corner case where
> this is broken: the raw link of a commitdiff page, such as
>
>  http://git.madduck.net/v/code/mailplate.git?a=3Dcommitdiff;h=3Df7d23=
65ee0ab439217083dd613daa4757a4e3d6e
>
> suddenly becomes
>
>  http://git.madduck.net/v/ARRAY(0xbc3b70)?a=3Dcommitdiff_plain;h=3Df7=
d2365ee0ab439217083dd613daa4757a4e3d6e
>                           ^^^^^^^^^^^^^^^
> when the feature is turned on. It works when it's off.
>
> I discussed this a bit on IRC, with the following bottom line:
>
>  < jengelh> if you see ARRAY... in the url, and [1] in the source
>  the wise Perl person says "ah, of course"
>
> Unfortunately, I am neither wise nor a Perl person, so I resort to
> just pointing this out to you and can offer to test any patches on
> this live server.

Are you running an older version of gitweb? One which predates 7863c61?

Cheers,
Wincent
