From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH v6 12/13] notes: track whether notes_trees were changed at
 all
Date: Thu, 11 Mar 2010 11:58:57 +0100
Message-ID: <201003111158.57543.johan@herland.net>
References: <cover.1268229087.git.trast@student.ethz.ch>
 <f4ef87cbd1f0bb98d8c8d2cc7dd6d3e417ec2875.1268229087.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-15
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Mar 11 11:59:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Npg6d-0007aG-Mn
	for gcvg-git-2@lo.gmane.org; Thu, 11 Mar 2010 11:59:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757357Ab0CKK7A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Mar 2010 05:59:00 -0500
Received: from smtp.getmail.no ([84.208.15.66]:55104 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757116Ab0CKK67 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Mar 2010 05:58:59 -0500
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KZ400A8D6IBZ540@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Thu, 11 Mar 2010 11:58:59 +0100 (MET)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KZ400FU76IAA940@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Thu, 11 Mar 2010 11:58:59 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2010.3.11.104819
User-Agent: KMail/1.13.1 (Linux/2.6.32-ARCH; KDE/4.4.1; x86_64; ; )
In-reply-to: <f4ef87cbd1f0bb98d8c8d2cc7dd6d3e417ec2875.1268229087.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141951>

On Wednesday 10 March 2010, Thomas Rast wrote:
> Currently, the notes copying is a bit wasteful since it always creates
> new trees, even if no notes were copied at all.
> 
> Teach add_note() and remove_note() to flag the affected notes tree as
> changed ('dirty').  Then teach builtin/notes.c to use this knowledge
> and avoid committing trees that weren't changed.
> 
> Signed-off-by: Thomas Rast <trast@student.ethz.ch>

Acked-by: Johan Herland <johan@herland.net>


-- 
Johan Herland, <johan@herland.net>
www.herland.net
