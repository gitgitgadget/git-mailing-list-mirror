From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH rfc v2] git-sh-setup: Fix scripts whose PWD is a symlink to a work-dir on OS X
Date: Sun, 4 Jan 2009 14:58:30 +0100
Message-ID: <D9F420FC-12C5-4262-833B-0820D8C80AC9@wincent.com>
References: <CC0158BE-219B-4E09-9B3B-A2D1B66132AC@silverinsanity.com> <1230649824-1893-1-git-send-email-marcel@oak.homeunix.org> <7v8wps59ss.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Marcel M. Cary" <marcel@oak.homeunix.org>, git@vger.kernel.org,
	jnareb@gmail.com, ae@op5.se, j.sixt@viscovery.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 04 15:30:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJU07-0002FK-6h
	for gcvg-git-2@gmane.org; Sun, 04 Jan 2009 15:30:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750932AbZADO3Z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 Jan 2009 09:29:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750883AbZADO3Z
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Jan 2009 09:29:25 -0500
Received: from wincent1.inetu.net ([209.235.192.161]:45387 "EHLO
	wincent1.inetu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750696AbZADO3Y convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Jan 2009 09:29:24 -0500
X-Greylist: delayed 1835 seconds by postgrey-1.27 at vger.kernel.org; Sun, 04 Jan 2009 09:29:23 EST
Received: from cuzco.lan (65.pool85-53-8.dynamic.orange.es [85.53.8.65])
	(authenticated bits=0)
	by wincent1.inetu.net (8.13.8/8.13.8) with ESMTP id n04DwUA3008635
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sun, 4 Jan 2009 08:58:32 -0500
In-Reply-To: <7v8wps59ss.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.929.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104518>

El 3/1/2009, a las 23:01, Junio C Hamano escribi=F3:

> "Marcel M. Cary" <marcel@oak.homeunix.org> writes:
>
>> I sent the first rev of this patch to just Brian.  It didn't have
>> either of the unit test changes.  He said it fixed all but t2300.3,
>> where cd_to_toplevel doesn't actually "cd", so I made the same chang=
e
>> to the unit test itself.  Can someone with OS X try running the test
>> suite with v2 of this patch?  I don't have OS X readily available.
>
> I think I saw a success report on the list.  Care to resend it with
> Sign-off (by you) and
>
> 	Tested-by: tester <test@er.xz> (on PLATFORM)
>
> lines as you see necessary for application?
>
> Thanks.

I also tested it and can confirm that it fixes the failures on Mac OS =20
X 10.5.5. So feel free to add:

Tested-by: Wincent Colaiuta <win@wincent.com> (on Mac OS X 10.5.5)

Cheers,
Wincent
