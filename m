From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Port git commit to C.
Date: Thu, 08 Nov 2007 15:47:36 -0800
Message-ID: <7vmytoz4dj.fsf@gitster.siamese.dyndns.org>
References: <1194541140-3062-1-git-send-email-krh@redhat.com>
	<20071108232751.GC4899@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Kristian =?utf-8?Q?H=C3=B8gsberg?= <krh@redhat.com>,
	git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 09 02:01:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqIFM-00047A-LE
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 02:01:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763524AbXKIAcU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Nov 2007 19:32:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763525AbXKIAcU
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 19:32:20 -0500
Received: from lollipop.listbox.com ([208.210.124.78]:57738 "EHLO
	lollipop.listbox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758970AbXKIAcU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Nov 2007 19:32:20 -0500
Received: from sceptre.pobox.com (sceptre.pobox.com [207.106.133.20])
	by lollipop.listbox.com (Postfix) with ESMTP id EF7F041D7FD
	for <git@vger.kernel.org>; Thu,  8 Nov 2007 18:50:47 -0500 (EST)
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 0E7AA2F2;
	Thu,  8 Nov 2007 18:48:04 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 9768F93A6B;
	Thu,  8 Nov 2007 18:48:00 -0500 (EST)
In-Reply-To: <20071108232751.GC4899@steel.home> (Alex Riesen's message of
	"Fri, 9 Nov 2007 00:27:52 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64089>

Alex Riesen <raa.lkml@gmail.com> writes:

> Kristian H=C3=B8gsberg, Thu, Nov 08, 2007 17:59:00 +0100:
>> This makes git commit a builtin and moves git-commit.sh to
>> contrib/examples.  This also removes the git-runstatus
>> helper, which was mostly just a git-status.sh implementation detail.
>
> Applied instead of 00c8febf563da on Junio's pu it breaks t1400:

Don't worry.  It will pass with two of the Dscho's patches.

The racy-git issue is still there, though.
