From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH rfc v2] git-sh-setup: Fix scripts whose PWD is a symlink
 to a work-dir on OS X
Date: Sat, 03 Jan 2009 14:01:07 -0800
Message-ID: <7v8wps59ss.fsf@gitster.siamese.dyndns.org>
References: <CC0158BE-219B-4E09-9B3B-A2D1B66132AC@silverinsanity.com>
 <1230649824-1893-1-git-send-email-marcel@oak.homeunix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jnareb@gmail.com, ae@op5.se,
	j.sixt@viscovery.net
To: "Marcel M. Cary" <marcel@oak.homeunix.org>
X-From: git-owner@vger.kernel.org Sat Jan 03 23:02:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJEZu-0000Fc-Te
	for gcvg-git-2@gmane.org; Sat, 03 Jan 2009 23:02:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759863AbZACWBT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Jan 2009 17:01:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759673AbZACWBT
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Jan 2009 17:01:19 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51462 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752944AbZACWBS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Jan 2009 17:01:18 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D500D8D1B8;
	Sat,  3 Jan 2009 17:01:14 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id D9EC28D1B7; Sat,
  3 Jan 2009 17:01:08 -0500 (EST)
In-Reply-To: <1230649824-1893-1-git-send-email-marcel@oak.homeunix.org>
 (Marcel M. Cary's message of "Tue, 30 Dec 2008 07:10:24 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0A3D2C8C-D9E2-11DD-A936-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104480>

"Marcel M. Cary" <marcel@oak.homeunix.org> writes:

> I sent the first rev of this patch to just Brian.  It didn't have
> either of the unit test changes.  He said it fixed all but t2300.3,
> where cd_to_toplevel doesn't actually "cd", so I made the same change
> to the unit test itself.  Can someone with OS X try running the test
> suite with v2 of this patch?  I don't have OS X readily available.

I think I saw a success report on the list.  Care to resend it with
Sign-off (by you) and

	Tested-by: tester <test@er.xz> (on PLATFORM)

lines as you see necessary for application?

Thanks.
