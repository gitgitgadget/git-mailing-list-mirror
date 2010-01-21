From: Johan Herland <johan@herland.net>
Subject: Re: Dangerous new server status for deleted files
Date: Thu, 21 Jan 2010 01:28:13 +0100
Message-ID: <201001210128.13772.johan@herland.net>
References: <4B5764A6.30504@naughtydog.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-15
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Simon Hausmann <simon@lst.de>,
	Junio C Hamano <gitster@pobox.com>
To: Pal-Kristian Engstad <pal_engstad@naughtydog.com>
X-From: git-owner@vger.kernel.org Thu Jan 21 01:28:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXkuY-0006bK-VU
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jan 2010 01:28:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754335Ab0AUA2V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2010 19:28:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751650Ab0AUA2R
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jan 2010 19:28:17 -0500
Received: from smtp.getmail.no ([84.208.15.66]:64430 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754805Ab0AUA2Q (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Jan 2010 19:28:16 -0500
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KWK00FZUMN2A110@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Thu, 21 Jan 2010 01:28:14 +0100 (MET)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KWK00JJUMN1CA00@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Thu, 21 Jan 2010 01:28:14 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2010.1.21.1529
User-Agent: KMail/1.12.4 (Linux/2.6.32-ARCH; KDE/4.3.4; x86_64; ; )
In-reply-to: <4B5764A6.30504@naughtydog.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137603>

On Wednesday 20 January 2010, Pal-Kristian Engstad wrote:
> Our new Perforce server (P4D/NTX64/2009.2/228098 2009/12/16) seems to be
> giving out 'move/delete' instead of the old 'delete' status for files
> that are moved within the repo. Attached is the simple patch to fix it.
> (By the way: How do you "sign off" a patch?) This is urgent, as it will
> corrupt git repos trying to track a Perforce depot.

Hi, and welcome to the Git community.

The patch itself may be fine, but you should probably read 
Documentation/SubmittingPatches for hints on the customs of this list. For 
example: We prefer patches _inline_ in the mail, so that it's easier to 
review and comment on them. The Documentation/SubmittingPatches also 
explains what is meant by a sign-off, and how to sign-off your patches.


Have fun! :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
