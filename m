From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH v2 1/3] doc/fast-import: clarify notemodify command
Date: Fri, 22 Jul 2011 21:32:58 +0200
Message-ID: <201107222132.59145.johan@herland.net>
References: <1310483428-29833-1-git-send-email-divanorama@gmail.com>
 <1310577055-6347-1-git-send-email-divanorama@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-15
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Dmitry Ivankov <divanorama@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 22 21:33:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QkLTB-00033E-9r
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jul 2011 21:33:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755215Ab1GVTdD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jul 2011 15:33:03 -0400
Received: from smtp.getmail.no ([84.208.15.66]:40190 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755166Ab1GVTdC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2011 15:33:02 -0400
Received: from get-mta-scan01.get.basefarm.net ([10.5.16.4])
 by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LOR00NJG2B02Y40@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Fri, 22 Jul 2011 21:33:00 +0200 (MEST)
Received: from get-mta-scan01.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 4863C17992EB_E29D06CB	for <git@vger.kernel.org>; Fri,
 22 Jul 2011 19:33:00 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan01.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 2AD881797DF7_E29D06CF	for <git@vger.kernel.org>; Fri,
 22 Jul 2011 19:33:00 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LOR00B872B0AQ10@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Fri, 22 Jul 2011 21:33:00 +0200 (MEST)
User-Agent: KMail/1.13.7 (Linux/2.6.39-ARCH; KDE/4.6.3; x86_64; ; )
In-reply-to: <1310577055-6347-1-git-send-email-divanorama@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177660>

On Wednesday 13 July 2011, Dmitry Ivankov wrote:
> The "notemodify" fast-import command was introduced in commit a8dd2e7
> (fast-import: Add support for importing commit notes, 2009-10-09)
> The commit log has slightly different description than the added
> documentation. The latter is somewhat confusing. "notemodify" is a
> subcommand of "commit" command used to add a note for some commit.
> Does this note annotate the commit produced by the "commit" command
> or a commit given by it's committish parameter? Which notes tree
> does it write notes to?
> 
> The exact meaning could be deduced with old description and some
> notes machinery knowledge. But let's make it more obvious. This
> command is used in a context like "commit refs/notes/test" to
> add or rewrite an annotation for a committish parameter. So the
> advised way to add notes in a fast-import stream is:
> 1) import some commits (optional)
> 2) prepare a "commit" to the notes tree:
> 2.1) choose notes ref, committer, log message, etc.
> 2.2) create annotations with "notemodify", where each can refer to
> a commit being annotated via a branch name, import mark reference,
> sha1 and other expressions specified in the Documentation.
> 
> Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>

Acked-by: Johan Herland <johan@herland.net>


-- 
Johan Herland, <johan@herland.net>
www.herland.net
