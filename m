From: Marcel Koeppen <git-dev@marzelpan.de>
Subject: Re: [PATCH rfc v2] git-sh-setup: Fix scripts whose PWD is a symlink to a work-dir on OS X
Date: Sun, 4 Jan 2009 19:49:03 +0100
Message-ID: <8C7E36D0-C037-427D-B6E2-4050CC767CD0@marzelpan.de>
References: <CC0158BE-219B-4E09-9B3B-A2D1B66132AC@silverinsanity.com> <1230649824-1893-1-git-send-email-marcel@oak.homeunix.org> <7v8wps59ss.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Marcel M. Cary" <marcel@oak.homeunix.org>, git@vger.kernel.org,
	jnareb@gmail.com, ae@op5.se, j.sixt@viscovery.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 04 19:50:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJY3i-0002kU-9I
	for gcvg-git-2@gmane.org; Sun, 04 Jan 2009 19:50:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753478AbZADStU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Jan 2009 13:49:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751400AbZADStU
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Jan 2009 13:49:20 -0500
Received: from smtprelay04.ispgateway.de ([80.67.18.16]:59884 "EHLO
	smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751336AbZADStU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Jan 2009 13:49:20 -0500
Received: from [80.145.211.163] (helo=[192.168.1.5])
	by smtprelay04.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <git-dev@marzelpan.de>)
	id 1LJY25-0000th-Od; Sun, 04 Jan 2009 19:49:05 +0100
In-Reply-To: <7v8wps59ss.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.930.3)
X-Df-Sender: 012269
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104534>


Am 03.01.2009 um 23:01 schrieb Junio C Hamano:

> "Marcel M. Cary" <marcel@oak.homeunix.org> writes:
>
>> I sent the first rev of this patch to just Brian.  It didn't have
>> either of the unit test changes.  He said it fixed all but t2300.3,
>> where cd_to_toplevel doesn't actually "cd", so I made the same change
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


Hi,

please add

Tested-by: Marcel Koeppen <git-dev@marzelpan.de> (on Mac OS X 10.5.6)

	Marcel
