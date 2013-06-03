From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH 1/6] prompt: don't scream continuation state
Date: Mon, 3 Jun 2013 10:58:14 +0200
Message-ID: <87r4gjzi3d.fsf@linux-k42r.v.cablecom.net>
References: <1370181822-23450-1-git-send-email-artagnon@gmail.com>
	<1370181822-23450-2-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 03 10:58:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjQav-000738-5Z
	for gcvg-git-2@plane.gmane.org; Mon, 03 Jun 2013 10:58:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753958Ab3FCI6T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Jun 2013 04:58:19 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:28030 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752750Ab3FCI6S (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jun 2013 04:58:18 -0400
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 3 Jun
 2013 10:58:14 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.233) by
 CAS11.d.ethz.ch (172.31.38.211) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Mon, 3 Jun 2013 10:58:15 +0200
In-Reply-To: <1370181822-23450-2-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Sun, 2 Jun 2013 19:33:37 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226206>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Currently, when performing any operation that saves the state and
> expects the user the continue (like rebase, bisect, am), the prompt
> screams:
>
>   artagnon|completion|REBASE-i 2/2:~/src/git$
>
> Lowercase the words, so we get a more pleasant
>
>   artagnon|completion|rebase-i 2/2:~/src/git$

So I'm not sure whether this falls under bikeshedding or actual
features, but I like the screaming.  When I first saw these displays, I
thought that the point was that this display is more important than all
the others, so it should be louder and easy to distinguish from the
branch name (common ones, anyway).

Do you have other ways of distinguishing the branch and the state?
Colors?  I'm a bit too lazy to check.  Perhaps it could be made to only
use caps if not in colored mode?

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
