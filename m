From: Hannu Koivisto <azure@iki.fi>
Subject: git diff, git mergetool and CRLF conversion
Date: Wed, 21 Jan 2009 18:55:34 +0200
Organization: NOYB
Message-ID: <83k58ofvjt.fsf@kalahari.s2.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 21 17:57:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPgOH-00074e-Kq
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 17:57:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752655AbZAUQzy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2009 11:55:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752436AbZAUQzy
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 11:55:54 -0500
Received: from main.gmane.org ([80.91.229.2]:47877 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752250AbZAUQzw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2009 11:55:52 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LPgMj-0004hQ-Mm
	for git@vger.kernel.org; Wed, 21 Jan 2009 16:55:45 +0000
Received: from s2.org ([195.197.64.39])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 21 Jan 2009 16:55:45 +0000
Received: from azure by s2.org with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 21 Jan 2009 16:55:45 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: s2.org
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/22.2 (gnu/linux)
Cancel-Lock: sha1:0DMwVPzGwY7s0DNbzTGvhcW8yKU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106628>

Hi,

Suppose I have core.autocrlf set to true and and due to that a
version controlled file in a working tree with CRLF line endings.
If I modify such a file and then say "git diff", I get a patch with
LF line endings.

Also, if get a merge conflict with a file to which CRLF conversion
is applied and run e.g. "git mergetool -t emerge", the temporary
files representing stage2 and stage3 versions seem to have LF line
endings.

Is this intended behaviour?  I'm using 1.6.1 on Cygwin.

-- 
Hannu
