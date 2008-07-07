From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] INSTALL: Update section about git-frotz form.
Date: Sun, 06 Jul 2008 19:10:00 -0700
Message-ID: <7vhcb2a1hj.fsf@gitster.siamese.dyndns.org>
References: <1215318521-23901-1-git-send-email-vmiklos@frugalware.org>
 <alpine.LSU.1.00.0807061312520.32725@wbgn129.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jul 07 04:11:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFgC2-0003hD-P1
	for gcvg-git-2@gmane.org; Mon, 07 Jul 2008 04:11:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751502AbYGGCKJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jul 2008 22:10:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751851AbYGGCKI
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jul 2008 22:10:08 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40584 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751056AbYGGCKH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jul 2008 22:10:07 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 66A9A241B3;
	Sun,  6 Jul 2008 22:10:06 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 88159241A6; Sun,  6 Jul 2008 22:10:02 -0400 (EDT)
In-Reply-To: <alpine.LSU.1.00.0807061312520.32725@wbgn129.biozentrum.uni-wuerzburg.de>
 (Johannes Schindelin's message of "Sun, 6 Jul 2008 13:14:34 +0200 (CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D15DC652-4BC9-11DD-A4C3-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87573>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Sun, 6 Jul 2008, Miklos Vajna wrote:
>
>> +   Let's face it, most of us don't have GNU interactive tools, and even
>> +   if we had it, we wouldn't know what it does.  I don't think it has
>> +   been actively developed since 1997, and people have moved over to
>
> This:  ^   ^   ^   ^   ^   ^   ^   ^   ^
>
> ... and this:
>
>> +   In addition, as of gnuit-4.9.2, the GNU interactive tools package has
>> +   been renamed.
>
> somehow contradict each other.  Maybe kill the whole sentence containing 
> 1997?

The mention of 1997 was correct when it was made, and I think it still is
true to some extent (http://savannah.gnu.org/forum/forum.php?forum_id=5189
says it has not been actively maintained for quite some time), but I think
it is no longer relevant to us whether many users use gnuit or moved away
to graphical file managers because of its name change.

The only people possibly affected are people who has older version of
gnuit that has been called git, so how about shortening the section even
further like:

 INSTALL |   26 +++++++++-----------------
 1 files changed, 9 insertions(+), 17 deletions(-)

diff --git a/INSTALL b/INSTALL
index 4a4e13f..7d0c2c2 100644
--- a/INSTALL
+++ b/INSTALL
@@ -24,23 +24,15 @@ set up install paths (via config.mak.autogen), so you can write instead
 
 Issues of note:
 
- - git normally installs a helper script wrapper called "git", which
-   conflicts with a similarly named "GNU interactive tools" program.
-
-   Tough.  Either don't use the wrapper script, or delete the old GNU
-   interactive tools.  None of the core git stuff needs the wrapper,
-   it's just a convenient shorthand and while it is documented in some
-   places, you can always replace "git commit" with "git-commit"
-   instead.
-
-   But let's face it, most of us don't have GNU interactive tools, and
-   even if we had it, we wouldn't know what it does.  I don't think it
-   has been actively developed since 1997, and people have moved over to
-   graphical file managers.
-
-   NOTE: As of gnuit-4.9.2, the GNU interactive tools package has been
-         renamed. You can compile gnuit with the --disable-transition
-         option and then it will not conflict with git.
+ - Ancient versions of GNU Interactive Tools (pre-4.9.2) installed a
+   program "git", whose name conflicts with this program.  But with
+   version 4.9.2, after long hiatus without active maintenance (since
+   around 1997), it changed its name to gnuit and the name conflict is no
+   longer a problem.
+
+   NOTE: When compiled with backward compatiblity option, the GNU
+   Interactive Tools package still can install "git", but you can build it
+   with --disable-transition option to avoid this.
 
  - You can use git after building but without installing if you
    wanted to.  Various git commands need to find other git
