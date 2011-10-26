From: Hannu Koivisto <azure@iki.fi>
Subject: Recovery after interrupted repack
Date: Wed, 26 Oct 2011 12:15:32 +0300
Organization: NOYB
Message-ID: <8339egazbf.fsf@kalahari.s2.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 26 11:15:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RIzaY-00062N-Eb
	for gcvg-git-2@lo.gmane.org; Wed, 26 Oct 2011 11:15:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932490Ab1JZJPx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Oct 2011 05:15:53 -0400
Received: from lo.gmane.org ([80.91.229.12]:57002 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753130Ab1JZJPx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Oct 2011 05:15:53 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1RIzaR-0005zh-85
	for git@vger.kernel.org; Wed, 26 Oct 2011 11:15:51 +0200
Received: from s2.org ([80.83.7.53])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 26 Oct 2011 11:15:51 +0200
Received: from azure by s2.org with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 26 Oct 2011 11:15:51 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: s2.org
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.3 (gnu/linux)
Cancel-Lock: sha1:0+KNl3lGPs86npzVCY3pGqqyJfY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184250>

Hi,

I interrupted git repack -a -f -d and now most commands say "fatal:
bad object HEAD".  Additionally an attempt to run git repack again
says a bunch of "error: refs/heads/foo does not point to a valid
object!" messages.

git fsck prints a huge list of "missing blob <sha-1>" lines.

I'm using a Cygwin build of git 1.7.5.1 (I also have a build of the
latest master available).

-- 
Hannu
