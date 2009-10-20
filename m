From: Johan Herland <johan@herland.net>
Subject: Re: git gc and kernel.org
Date: Tue, 20 Oct 2009 10:54:48 +0200
Message-ID: <200910201054.48315.johan@herland.net>
References: <4ADD6026.8070203@zytor.com>
 <7veioyqzeo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
	ftpadmin@kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 20 10:55:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0AUa-0000P9-Hy
	for gcvg-git-2@lo.gmane.org; Tue, 20 Oct 2009 10:54:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751352AbZJTIyr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2009 04:54:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751335AbZJTIyr
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 04:54:47 -0400
Received: from smtp.getmail.no ([84.208.15.66]:45671 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751345AbZJTIyq (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Oct 2009 04:54:46 -0400
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KRT0091T23DNK20@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Tue, 20 Oct 2009 10:54:49 +0200 (MEST)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KRT009JI23CP920@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Tue, 20 Oct 2009 10:54:49 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.10.20.83616
User-Agent: KMail/1.12.2 (Linux/2.6.30-ARCH; KDE/4.3.2; x86_64; ; )
In-reply-to: <7veioyqzeo.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130774>

On Tuesday 20 October 2009, Junio C Hamano wrote:
> At one point, update-server-info used to compute a lot more than what we
> currently compute and it made some sense to oppose against it on
> performance ground.
> 
> But these days it only lists the refs and packs and does nothing else;
> the performance impact should be immeasurable and it adds only two files
> to the repository.  It cannot be a big deal, unless you oppose to http
> transport on a non-technical ground.

FYI, update-server-info takes ~0.7 seconds in a repo with one pack and 
~50000 refs, so I guess it's acceptable to enable it by default, even in 
those kinds of repos.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
