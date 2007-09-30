From: Bruno Haible <bruno@clisp.org>
Subject: Re: suggestion for git stash
Date: Sun, 30 Sep 2007 22:59:11 +0200
Message-ID: <200709302259.11731.bruno@clisp.org>
References: <200709302050.41273.bruno@clisp.org> <7vfy0vhqkl.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 30 22:59:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ic5sm-0007Nx-AF
	for gcvg-git-2@gmane.org; Sun, 30 Sep 2007 22:59:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752372AbXI3U7M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Sep 2007 16:59:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752352AbXI3U7L
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Sep 2007 16:59:11 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:27420 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752164AbXI3U7L (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Sep 2007 16:59:11 -0400
X-Greylist: delayed 7708 seconds by postgrey-1.27 at vger.kernel.org; Sun, 30 Sep 2007 16:59:10 EDT
Received: from linuix.haible.de ([81.210.217.73])
	by post.webmailer.de (klopstock mo26) (RZmta 13.2)
	with ESMTP id t00e60j8UGihKM ; Sun, 30 Sep 2007 22:59:08 +0200 (MEST)
	(envelope-from: <bruno@clisp.org>)
User-Agent: KMail/1.5.4
In-Reply-To: <7vfy0vhqkl.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
X-RZG-AUTH: gMysVb8JT2gB+rFDu0PuvnPihAP8oFdePhw95HsN8T+WAEY7QaSDm1JE
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59562>

Junio C Hamano wrote:
> Isn't "stash apply --index" what you talk about?

Not really:

$ git status
# On branch master
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#       modified:   README
#
# Changed but not updated:
#   (use "git add <file>..." to update what will be committed)
#
#       modified:   NEWS
#
$ git stash
Saved "WIP on master: 61135ee... Use check_PROGRAMS instead of noinst_PROGRAMS."
HEAD is now at 61135ee... Use check_PROGRAMS instead of noinst_PROGRAMS.
$ git stash apply --index
error: No changes
Conflicts in index. Try without --index.

(This is git version 1.5.3.1.)

I don't know what "git stash apply --index" does, since it's not documented.

Bruno
