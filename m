From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [RFC] Making ce_path_match() more useful by accepting globs
Date: Mon, 26 Nov 2007 01:11:14 +0100
Message-ID: <20071126001114.GA10286@steel.home>
References: <7vr6ienqxr.fsf@gitster.siamese.dyndns.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 26 01:11:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwRZc-0008WQ-Kg
	for gcvg-git-2@gmane.org; Mon, 26 Nov 2007 01:11:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755909AbXKZALW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Nov 2007 19:11:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755867AbXKZALW
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Nov 2007 19:11:22 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:62671 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754676AbXKZALV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2007 19:11:21 -0500
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaHqBg79ik=
Received: from tigra.home (Fcbf4.f.strato-dslnet.de [195.4.203.244])
	by post.webmailer.de (klopstock mo54) (RZmta 14.3)
	with ESMTP id N002e2jAPJwpdE ; Mon, 26 Nov 2007 01:11:15 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 33E42277AE;
	Mon, 26 Nov 2007 01:11:15 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id BD07056D22; Mon, 26 Nov 2007 01:11:14 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vr6ienqxr.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66029>

Junio C Hamano, Sun, Nov 25, 2007 19:03:12 +0100:
> Currently ce_path_match() only uses "the leading directory" match, and
> does not understand file globs.  These do not work:
> 
>    git diff-files 't/*.sh'
>    git diff-index HEAD 'xdiff/*.c'
>    git update-index -g 'Documentation/howto/*.txt'

How should my scripts handle files with "*" in names?
Maybe before the proposed change we should make all plumbing accept
"--stdin" (which does not expand globs)?

P.S. you have something broken in your mailer:

    To: Linus@sceptre.sasl.smtp.pobox.com,
	    "Torvalds <torvalds"@linux-fundation.org
