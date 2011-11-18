From: Miles Bader <miles@gnu.org>
Subject: Re: A flaw in dep generation with gcc -MMD?
Date: Fri, 18 Nov 2011 13:49:12 +0900
Message-ID: <buor516m3w7.fsf@dhlpc061.dev.necel.com>
References: <CACsJy8BZMDyf4MCiKxPJ5Z+XS+C-MC82SpMFyWgiXmb9xCnScw@mail.gmail.com>
 <20111118034142.GA25228@elie.hsd1.il.comcast.net>
 <CACsJy8A44PFtYrm8NQU+48sVkOe8mjJyO9opO5-TwRtAd-TKsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 18 05:49:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RRGOE-0007qY-5w
	for gcvg-git-2@lo.gmane.org; Fri, 18 Nov 2011 05:49:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756535Ab1KREtV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Nov 2011 23:49:21 -0500
Received: from relmlor2.renesas.com ([210.160.252.172]:64186 "EHLO
	relmlor2.renesas.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756288Ab1KREtV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Nov 2011 23:49:21 -0500
Received: from relmlir2.idc.renesas.com ([10.200.68.152])
 by relmlor2.idc.renesas.com ( SJSMS)
 with ESMTP id <0LUU00EATAQ73R90@relmlor2.idc.renesas.com> for
 git@vger.kernel.org; Fri, 18 Nov 2011 13:49:19 +0900 (JST)
Received: from relmlac2.idc.renesas.com ([10.200.69.22])
 by relmlir2.idc.renesas.com ( SJSMS)
 with ESMTP id <0LUU00BTQAQ7SU40@relmlir2.idc.renesas.com> for
 git@vger.kernel.org; Fri, 18 Nov 2011 13:49:19 +0900 (JST)
Received: by relmlac2.idc.renesas.com (Postfix, from userid 0)
	id A5A4D28076; Fri, 18 Nov 2011 13:49:19 +0900 (JST)
Received: from relmlac2.idc.renesas.com (localhost [127.0.0.1])
	by relmlac2.idc.renesas.com (Postfix) with ESMTP id 88E5528070; Fri,
 18 Nov 2011 13:49:19 +0900 (JST)
Received: from relmlii1.idc.renesas.com [10.200.68.65]	by
 relmlac2.idc.renesas.com with ESMTP id PAC08951; Fri,
 18 Nov 2011 13:49:19 +0900
X-IronPort-AV: E=Sophos;i="4.69,530,1315148400";   d="scan'208";a="55401491"
Received: from unknown (HELO relay61.aps.necel.com) ([10.29.19.64])
 by relmlii1.idc.renesas.com with ESMTP; Fri, 18 Nov 2011 13:49:19 +0900
Received: from dhlpc061 (dhlpc061.dev.necel.com [10.114.97.34])
	by relay61.aps.necel.com (8.14.4+Sun/8.14.4) with ESMTP id pAI4nEC2028339;
 Fri, 18 Nov 2011 13:49:15 +0900 (JST)
Received: by dhlpc061 (Postfix, from userid 31295)	id 6A11052E295; Fri,
 18 Nov 2011 13:49:14 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
Blat: Foop
In-reply-to: <CACsJy8A44PFtYrm8NQU+48sVkOe8mjJyO9opO5-TwRtAd-TKsQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185630>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>> Interesting. =A0What compiler do you use?
>
> $ gcc --version
> gcc (Gentoo 4.4.4-r2 p1.2, pie-0.4.5) 4.4.4

=46WIW, gcc 4.4.6 on debian does the correct thing too...

-Miles

--=20
Yo mama's so fat when she gets on an elevator it HAS to go down.
