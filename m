From: ddw_music <jamshark70@gmail.com>
Subject: Re: (osx 10.4.11) can't push from linux to Apache on mac: can't
 access location
Date: Sun, 13 Jun 2010 04:56:19 -0700 (PDT)
Message-ID: <1276430179137-5174101.post@n2.nabble.com>
References: <1276390106819-5173157.post@n2.nabble.com> <AANLkTim4U99KQ2zDfdSmMzbn1FqCqAPh_hKwITmQDX6H@mail.gmail.com> <1276410911244-5173593.post@n2.nabble.com> <AANLkTilIGhEXlhEbAAXIU-_1Qg8AJoCalkilWGCzIP1m@mail.gmail.com> <1276424936869-5173934.post@n2.nabble.com> <m3iq5np602.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 13 14:01:43 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ONlsl-0001o3-23
	for gcvg-git-2@lo.gmane.org; Sun, 13 Jun 2010 14:01:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752422Ab0FML4U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jun 2010 07:56:20 -0400
Received: from kuber.nabble.com ([216.139.236.158]:49259 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751050Ab0FML4T (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jun 2010 07:56:19 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <jamshark70@gmail.com>)
	id 1ONlnX-000448-4a
	for git@vger.kernel.org; Sun, 13 Jun 2010 04:56:19 -0700
In-Reply-To: <m3iq5np602.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149046>



Jakub Narebski wrote:
> 
> Why can't you use SSH for pushing instead of "dumb" HTTPS via WebDAV?
> This would require having sshd (SSH daemon, i.e. SSH server) installed,
> and perhaps Gitosis or Gitolite for access control (so one can use only
> single shell account).
> 

I'll consider that later on. For the moment -- I spent probably five or six
hours today and fiddling around with the configuration, and I don't have
time to look at any other tools (gitosis etc). (At least osx comes with
"Remote Login" == sshd preinstalled.)

While experimenting with git-daemon this morning, I did get the
functionality that I need working by enabling receive-pack. Yes, I know
that's a security risk, but I'm the only user, behind a hardware router (no
exposed IP address) and I will have the daemon running only for a few
minutes at a time when needed for sync.

I realize this isn't the "correct" or "optimal" configuration, but I know
that it will work for the moment and, as stated, I simply won't have any
further time for experimentation for the next few weeks.



> P.S. You did run git-update-server-info (and added it to 'update' hook),
> didn't you?
> 

Yes, no help.

Thanks, in any case - it's a good tip for the future (and word to the wise
to git noobs who find this in the list archives: avoid HTTP!).

James
-- 
View this message in context: http://git.661346.n2.nabble.com/osx-10-4-11-can-t-push-from-linux-to-Apache-on-mac-can-t-access-location-tp5173157p5174101.html
Sent from the git mailing list archive at Nabble.com.
