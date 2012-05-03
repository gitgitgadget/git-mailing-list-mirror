From: Ronan Keryell <Ronan.Keryell@hpc-project.com>
Subject: Re: Newbie grief
Date: Thu, 03 May 2012 15:23:47 -0700
Message-ID: <87y5p8dhu4.fsf@an-dro.info.enstb.org>
References: <4F9F128C.5020304@palm.com>
	<201204302331.q3UNVo7o032303@no.baka.org> <4F9F28F5.2020403@palm.com>
	<201205010137.q411bxaU002449@no.baka.org> <4F9F52B9.9060508@palm.com>
	<08704bd2e32343a4b9def80e4fa1efa2-mfwitten@gmail.com>
	<4FA2D8EA.7030809@palm.com> <87obq5ggpu.fsf@an-dro.info.enstb.org>
	<7vehr1dl2z.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 04 00:24:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQ4Rf-00042G-CT
	for gcvg-git-2@plane.gmane.org; Fri, 04 May 2012 00:24:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758982Ab2ECWX6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 May 2012 18:23:58 -0400
Received: from minou.info.enstb.org ([193.50.97.146]:51098 "EHLO
	minou.info.enstb.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758933Ab2ECWX4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 May 2012 18:23:56 -0400
Received: from an-dro.info.enstb.org (localhost [127.0.0.1])
	by minou.info.enstb.org (8.14.4/8.14.4/Debian-2) with ESMTP id q43MNmpE025323;
	Fri, 4 May 2012 00:23:49 +0200
In-Reply-To: <7vehr1dl2z.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 03 May 2012 14:13:40 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196968>

>>>>> On Thu, 03 May 2012 14:13:40 -0700, Junio C Hamano <gitster@pobox.com> said:

    >> This is a very good suggestion.  ...  At least, print a simpler
    >> message with some typical use case causing this and some workflow
    >> ideas before the detailed explanation.

    Junio> It indeed is a good starting point to make a suggestion, but
    Junio> there is nothing actionable in the above by itself,
    Junio> especially since "typical use case" is quite different for
    Junio> different Git users.

Right.

Just add a new git config entry defining "typical use case". :-)
And we can recurse to define what is the default value of this and so
on... :-)

Just to be constructive, in the previous case, adding something like
"It appears that you are trying to push some modifications on a remote
server on a branch that has been updated. It may be due to someone
having worked on it in the meantime. To go on, you may first do a
git merge .... <automatically generated>
and try again after solving this so that we are able to precisely track
the real history of your project."

The last sentence is to motivate the user to do what may be complicated
when coming from, say, SVN, and who do not really care with... real
history. ;-)

Well I'm not a native English speaker, but I hope you can get the idea.

After that, there are some other use cases, but I'm not sure that in
this case this kind of message would help, because you may have some
deeper knowledge of git anyway.

For example for my software testing infrastructure, I push some stuff on
some remote git and I force the update of the remote branch anyway with
a git push -f.  If I forgot the '-f' I would have the same error message
above that would not be helpful for me. But anyway, this message is not
needed since I use git for my very own specific purpose in this case.
-- 
  Ronan KERYELL                            |\/  Phone:  +1 408 658 9453
  Wild Systems / HPC Project               |/)
  5201 Great America Parkway, Suite 320    K    Ronan.Keryell@wild-systems.com
  Santa Clara, CA 95054                    |\   skype:keryell
  USA                                      | \  http://wild-systems.com
