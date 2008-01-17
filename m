From: Wincent Colaiuta <win@wincent.com>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Thu, 17 Jan 2008 14:40:50 +0100
Message-ID: <526D0C73-A004-4A2A-A177-274D2602D8DD@wincent.com>
References: <478E1FED.5010801@web.de> <76718490801162043w3884435ex435f38b9de837540@mail.gmail.com> <76718490801162059i2472cd82va34010caa3130b7e@mail.gmail.com> <7vejchkp6o.fsf@gitster.siamese.dyndns.org> <32DB7E53-1062-4F7C-A42D-6EC5945A70A3@wincent.com> <alpine.LSU.1.00.0801171106510.17650@racer.site> <C7439732-3B79-4F2B-9D0C-679C1EC8EA0E@simplicidade.org> <16D4755D-EAEC-4F4A-B6B4-F262A6841F66@wincent.com> <alpine.LSU.1.00.0801171252540.17650@racer.site>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pedro Melo <melo@simplicidade.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jay Soffian <jaysoffian+git@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 17 14:42:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFV1D-0004U8-E9
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 14:42:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752117AbYAQNmS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Jan 2008 08:42:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752114AbYAQNmS
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jan 2008 08:42:18 -0500
Received: from wincent.com ([72.3.236.74]:35840 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752088AbYAQNmR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Jan 2008 08:42:17 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id m0HDeq5M022897;
	Thu, 17 Jan 2008 07:40:53 -0600
In-Reply-To: <alpine.LSU.1.00.0801171252540.17650@racer.site>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70861>

El 17/1/2008, a las 13:53, Johannes Schindelin escribi=F3:

> Hi,
>
> On Thu, 17 Jan 2008, Wincent Colaiuta wrote:
>
>> On Mac OS X we have (unfortunately only 10.4 and up):
>
> That remark about the version raises my eyebrows.  Where I live, =20
> 10.2.8 is
> _still_ quite common.

There may be alternatives that I don't know about.

All the way back to 10.0 you have -[NSString =20
fileSystemRepresentation], which does the same thing but that's =20
Objective-C. I wouldn't be surprised if that's just a wrapper for the =20
CF functions; that's often the way it is on Mac OS X. And often, the =20
CF functions *are* present on older systems, but they're just not =20
declared in public headers. I wouldn't actually recommend using a =20
private SPI, but they are often there.

Cheers,
Wincent
