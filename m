From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH] revision: --ancestry-path
Date: Wed, 21 Apr 2010 09:34:30 +0200
Message-ID: <201004210934.30226.johan@herland.net>
References: <201004201649.31084.johan@herland.net>
 <7viq7lg8f2.fsf@alter.siamese.dyndns.org>
 <7v39ypg4gm.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 21 09:34:44 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4USG-0003zR-Pk
	for gcvg-git-2@lo.gmane.org; Wed, 21 Apr 2010 09:34:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752454Ab0DUHee (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Apr 2010 03:34:34 -0400
Received: from smtp.getmail.no ([84.208.15.66]:47432 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751253Ab0DUHee (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Apr 2010 03:34:34 -0400
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L17008U1UDJTS10@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Wed, 21 Apr 2010 09:34:31 +0200 (MEST)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L17008YLUDIOK20@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Wed, 21 Apr 2010 09:34:31 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2010.4.21.72115
User-Agent: KMail/1.13.2 (Linux/2.6.33-ARCH; KDE/4.4.2; x86_64; ; )
In-reply-to: <7v39ypg4gm.fsf_-_@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145413>

On Wednesday 21 April 2010, Junio C Hamano wrote:
> This is somewhat a rough-cut, as I haven't thought through possible
> interactions this new option may have with "rev-list --parents" and
> "rev-list --graph" (see "NEEDSWORK" in revision.c), but I'll leave that
> to people who are more interested in this topic than myself ;-).

Thanks! :)

I can confirm that this patch works with my original (more complicated) 
scenario. I've also played around with combinations of --ancestry-path, --
graph and --parents (and even --boundary), and AFAICS, the new option does 
not clobber the other options, and (IMHO) it all behaves correctly in the 
scenarios I've tested. Consider it:

Tested-by: Johan Herland <johan@herland.net>

I've also reviewed the patch, and it all looks good to me (i.e. "Acked-by", 
except I'm not super-familiar in the relevant area of the code).

What more should I do to push this forwards towards 'next'?


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
