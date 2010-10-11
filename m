From: Yann Dirson <dirson@bertin.fr>
Subject: Undocumented git-diff syntax
Date: Mon, 11 Oct 2010 15:03:42 +0200
Organization: Bertin Technologies
Message-ID: <20101011150342.292ad725@chalon.bertin.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 11 15:12:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5IBP-0006FZ-Qs
	for gcvg-git-2@lo.gmane.org; Mon, 11 Oct 2010 15:12:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754475Ab0JKNMp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Oct 2010 09:12:45 -0400
Received: from blois.bertin.fr ([195.68.26.9]:61431 "EHLO blois.bertin.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754352Ab0JKNMp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Oct 2010 09:12:45 -0400
Received: from blois.bertin.fr (localhost [127.0.0.1])
	by postfix.imss70 (Postfix) with ESMTP id 24D1054307
	for <git@vger.kernel.org>; Mon, 11 Oct 2010 15:12:43 +0200 (CEST)
Received: from YPORT1 (yport1.bertin.fr [192.168.1.13])
	by blois.bertin.fr (Postfix) with ESMTP id 0092A542D9
	for <git@vger.kernel.org>; Mon, 11 Oct 2010 15:12:43 +0200 (CEST)
Received: from chalon.bertin.fr ([172.16.1.1]) by yport1.innovation.bertin.fr
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 with ESMTPPA id <0LA400DYXND6KO90@yport1.innovation.bertin.fr> for
 git@vger.kernel.org; Mon, 11 Oct 2010 15:12:42 +0200 (CEST)
X-Mailer: Claws Mail 3.7.6 (GTK+ 2.20.1; i486-pc-linux-gnu)
X-TM-AS-Product-Ver: IMSS-7.0.0.8200-6.0.0.1038-17696.007
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158759>

When trying "just to see it it would work", I noticed that the
following syntax appears to do what it looks like it should do.

git diff v1.7.3-rc0:Documentation/RelNotes-1.7.3.txt v1.7.3:Documentation/RelNotes/1.7.3.txt

It is a useful thing, but I could not find described in the manpage.  I have not dig this
part of diff yet, and maybe someone would have already a description of it (does it simply allow
to diff two arbitrary blobs ?).  Is it here just by some magic side-effect ? :)

Another thought: if we can already compare arbitrary blobs, maybe it would not be so hard to
extend it to take arbitrary contents that are not stored as blobs yet ?  (a quick hack would be to
insert an object for them, but that does not look too clean...).  As a use-case, I'm often found generating diffs from within custom scripts, from contents derived from a git repo, but can't use all the bells and whistles (--color, --color-words, etc), just because I have to use plain diff;
that makes the output of those scripts very inconsistent with native git commands.

Would there be any objections to moving into that direction ?

-- 
Yann Dirson - Bertin Technologies
