From: "Raimund Berger" <raimund.berger@gmail.com>
Subject: Newbie question regarding 3way merge order.
Date: Thu, 29 Jan 2009 23:25:00 +0100
Message-ID: <871vulda2r.fsf@gigli.quasi.internal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 29 23:27:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSfLF-0001XQ-Ub
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 23:26:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754549AbZA2WZI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 17:25:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754326AbZA2WZH
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 17:25:07 -0500
Received: from ey-out-2122.google.com ([74.125.78.26]:47054 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752419AbZA2WZF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 17:25:05 -0500
Received: by ey-out-2122.google.com with SMTP id 25so55351eya.37
        for <git@vger.kernel.org>; Thu, 29 Jan 2009 14:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:user-agent:mime-version:content-type;
        bh=9rujUO10NhauYllrtF3+h62egnUky8XqUSvIFsPOcLs=;
        b=IeYXeWgOPIBpxJa5XkfIvzQFxoFchmqAXUKghnqBJ9gjir9uBcqyYIvNHLNpDKCHUM
         w5lymk0qZq0Y2ENh1ET68g4RRatVsDk28xe5t/WB/J6ruHpwcIbstcPsdOID6k3/5LP6
         W22xab3ZB9xmC82ah/j6WeIGjSNI3KWs3FGQ8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:user-agent:mime-version
         :content-type;
        b=n7dC+dDuOcCIWPcZJ+xZzk2uaz9hXpO0CNEiARA1TCwMNXuxnwxOSWRscXuz1ODX/T
         ZUJOPdJWJC3T/+kB8FEL3DYEWCgjyLx/Cx1pqmHo27SPc9Ch7Bp2VqO/KOpKiO8sjJE5
         +HdNHCQwFsPNc1+QKypl+QvlsVarvTE0urEBE=
Received: by 10.103.223.2 with SMTP id a2mr291845mur.4.1233267903041;
        Thu, 29 Jan 2009 14:25:03 -0800 (PST)
Received: from gigli.quasi.internal (p5DC32079.dip.t-dialin.net [93.195.32.121])
        by mx.google.com with ESMTPS id 12sm322841muq.23.2009.01.29.14.25.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 29 Jan 2009 14:25:02 -0800 (PST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.60 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107737>


Hi guys

I got a dumb question for you to wholeheartedly laugh at, and to which
the answer seems to be so self evident. I'd still like a possibly
authoritative statement though, just for the books.

The question is whether a (3way) merge is commutative, purely in terms
of content (i.e. disregarding commit history for now). Iow if no matter
in which order I merge A and B, i.e. A into B or B into A, I'd be
guaranteed to arrive at the same content.

If yes, a followup question would be if the merge machinery sitting
beneath rebase is exactly the same as that of a standard merge.

The reason I ask is obvious I guess. What basically interests me is if I
gave a bunch of topic branches exposure on a test branch and, after
resolving issues, applied them to stable, that I could be 100% sure to
not introduce new issues content wise just by applying merges in a
different order or form (rebase, patch set).

Thanks for feedback, Raimund.
