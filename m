From: Emmanuel Michon <emmanuel_michon@sigmadesigns.com>
Subject: (minor concern) git using the pager should not be a default
Date: Wed, 29 Aug 2012 18:02:06 +0200
Message-ID: <503E3CFE.1080603@sigmadesigns.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 29 18:18:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T6kyd-0006yi-1j
	for gcvg-git-2@plane.gmane.org; Wed, 29 Aug 2012 18:18:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754125Ab2H2QSl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Aug 2012 12:18:41 -0400
Received: from maildk.sigmadesigns.com ([195.215.56.173]:58458 "EHLO
	maildk.sigmadesigns.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754013Ab2H2QSk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2012 12:18:40 -0400
X-Greylist: delayed 990 seconds by postgrey-1.27 at vger.kernel.org; Wed, 29 Aug 2012 12:18:39 EDT
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:14.0) Gecko/20120714 Thunderbird/14.0
X-Enigmail-Version: 1.4.4
X-Originating-IP: [172.27.0.175]
X-FEAS-SYSTEM-WL: emmanuel_michon@sigmadesigns.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204482>

Hello,

I'm risking myself on this mailing list after looking for some advise o=
n
IRC. Basically I know about this previous attempt
http://marc.info/?l=3Dgit&m=3D122955045415845&w=3D2 but my request has =
little
to do with emacs.

I believe UNIX recommends some rules in the =ABless is more=BB spirit w=
hen
designing command line applications [basically listed here:
http://en.wikipedia.org/wiki/Unix_philosophy].

As far as I understand those, stdin/out/err would be better left with
minimum processing. Silent execution with $? =3D 0 is the best thing th=
at
can happen.

Per those rules, which I think apply to Linux apps, it would be
preferrable if the *default* setup of git didn't fork a pager, didn't
use colors, didn't behave differently whether piped or not.

Of course I would be the first to always call the tool with
git diff |less
excepted when I do git diff |diffstat
or enjoy such options as command line or environment switches to git.
when I want.

So the point is more about the appropriateness of pushing that special
ergonomy to all users, knowing it makes most users happy.

Isn't the design principle superior to the wishes of the masses?

Thanks for reading,
Don't laugh,
Keep on the good work.

Sincerely yours,

e.m.
