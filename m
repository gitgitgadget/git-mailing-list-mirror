From: Pietro Battiston <me@pietrobattiston.it>
Subject: git-repack & big files
Date: Tue, 11 Jan 2011 08:37:18 +0100
Message-ID: <1294731438.3300.973.camel@voubian.casa>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 11 08:46:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PcYwE-0002YC-CE
	for gcvg-git-2@lo.gmane.org; Tue, 11 Jan 2011 08:46:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753022Ab1AKHqi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Jan 2011 02:46:38 -0500
Received: from pietrobattiston.it ([92.243.7.39]:53808 "EHLO
	jauntuale.pietrobattiston.it" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751405Ab1AKHqg (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Jan 2011 02:46:36 -0500
X-Greylist: delayed 539 seconds by postgrey-1.27 at vger.kernel.org; Tue, 11 Jan 2011 02:46:36 EST
Received: from [192.168.1.2] (net-188-218-63-65.cust.dsl.vodafone.it [188.218.63.65])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jauntuale.pietrobattiston.it (Postfix) with ESMTPSA id C1CDC13560
	for <git@vger.kernel.org>; Tue, 11 Jan 2011 07:37:32 +0000 (UTC)
X-Mailer: Evolution 2.30.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164917>

Hello,

first, I do know git is not optimized for big files, and that's fine.
But it is able, on my machine with 3 GB of RAM, to succesfully backup m=
y
home directory=C2=B9, which contains, among others, several files of se=
veral
hundreds of megabytes each. And I like that a lot.

Since it perfectly does what it is not optimized to do... I then wonder
when it does not do what it declares: if I run git-repack=C2=B2 with th=
e
parameter --window-memory set to, for instance, "100m", it takes
hundreds and hundreds of MB of memory until it runs out of memory, fail=
s
a malloc and aborts.
So, two questions:

1) is there a bug, is the documentation about that parameter a bit too
optimistic or did I just not understand it?

2) do I have any hope that in one way or another my 500+ MB mailboxes
with relatively small changes over time are archived smartly (=3Ddiffs)=
 by
git at the current state of development? If I understand correctly, the
project git-bigfiles=C2=B3 would just "solve" my problems by not making
differences of big files.

thanks for the clarifications

Pietro


=C2=B9 Just for the records: through gibak:
http://eigenclass.org/hiki/gibak-0.3.0

=C2=B2 git version 1:1.7.2.3-2.2 on Debian

=C2=B3 http://caca.zoy.org/wiki/git-bigfiles
