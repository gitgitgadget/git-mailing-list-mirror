From: Seth House <seth@eseth.com>
Subject: Re: Conflict markers in mergetool $LOCAL ?
Date: Tue, 17 Aug 2010 21:04:20 +0000 (UTC)
Message-ID: <loom.20100817T230158-934@post.gmane.org>
References: <loom.20100817T054731-955@post.gmane.org> <20100817093008.GA26357@gmail.com> <loom.20100817T185804-167@post.gmane.org> <f595ee73-b1a3-4797-bf55-20c0f1b309e0@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 17 23:04:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlTKs-0008L5-SI
	for gcvg-git-2@lo.gmane.org; Tue, 17 Aug 2010 23:04:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751120Ab0HQVEh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Aug 2010 17:04:37 -0400
Received: from lo.gmane.org ([80.91.229.12]:42622 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750855Ab0HQVEg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Aug 2010 17:04:36 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1OlTKg-0008BV-Bl
	for git@vger.kernel.org; Tue, 17 Aug 2010 23:04:30 +0200
Received: from ip65-44-116-164.z116-44-65.sendoutcards.net ([65.44.116.164])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 17 Aug 2010 23:04:30 +0200
Received: from seth by ip65-44-116-164.z116-44-65.sendoutcards.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 17 Aug 2010 23:04:30 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 65.44.116.164 (Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/534.6 (KHTML, like Gecko) Chrome/6.0.493.0 Safari/534.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153778>

Jacob Helwig <jacob.helwig <at> gmail.com> writes:
> That actually looks exactly like it should.  The order of the windows
> that vimdiff uses is (IIRC): ours, on-disk file, theirs.

Hm, you=E2=80=99re right. I just found the git-mergetool--lib script on=
 my
system and it opens vimdiff with $LOCAL $MERGED $REMOTE. Thank you, tha=
t
opened my eyes enough to clarify my question:

The conflict markers don't seem very useful in the context of a merge
tool. I would prefer to see two windows in vimdiff with each side of th=
e
conflict, respectively. Something like:

vimdiff $MERGED-left-hand-conflicts $MERGED-right-hand-conflicts

Is that possible with Git -- or does anyone know of external tools to
help with such a workflow?
