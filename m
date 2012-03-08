From: cnighswonger <chris.nighswonger@gmail.com>
Subject: Re: [PATCH] blame: can specify shas of commits to ignore on command
  line
Date: Thu, 8 Mar 2012 13:01:13 -0800 (PST)
Message-ID: <1331240473379-7356224.post@n2.nabble.com>
References: <1272939687-17686-1-git-send-email-dgreid@gmail.com> <4BE0918C.9090204@lsrfire.ath.cx> <j2sfd211a421005041446ub9c2247ai484c2473df856b31@mail.gmail.com> <7vtyqnl19w.fsf@alter.siamese.dyndns.org> <z2lfd211a421005041608n1e302cbbt1bb628e9b51b3e3@mail.gmail.com> <7vfx27kjr6.fsf@alter.siamese.dyndns.org> <l2wfd211a421005042228rd6386ff9k9bc54c5862209785@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 08 22:01:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5kSd-0006qu-1g
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 22:01:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751896Ab2CHVBO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Mar 2012 16:01:14 -0500
Received: from sam.nabble.com ([216.139.236.26]:60668 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751300Ab2CHVBO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2012 16:01:14 -0500
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <chris.nighswonger@gmail.com>)
	id 1S5kSX-00042F-CX
	for git@vger.kernel.org; Thu, 08 Mar 2012 13:01:13 -0800
In-Reply-To: <l2wfd211a421005042228rd6386ff9k9bc54c5862209785@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192648>

I'm not subscribed to the list, so please reply-to-all or cc me on responses.

Is this feature dead? There seems to be some question about the value of
such a feature in the discussion along this thread, however, such a feature
would have the wonderful benefit of allowing a change such as that being
discussed here:
http://koha.1045719.n5.nabble.com/Koha-3-8-release-schedule-amp-perltidy-process-td5547369.html
to be made and yet preserve the usefulness of git-blame.

To recap the issue in the thread at koha-devel:

A massive perl-tidy is being considered to be applied project wide in a
single commit. The real show-stopper is that this breaks git-blame. If
git-blame could be told to ignore that single commit id, life would be good
(I think).

At any rate it provides a use-case which might justify such a feature.

Kind Regards,
Chris

--
View this message in context: http://git.661346.n2.nabble.com/PATCH-blame-can-specify-shas-of-commits-to-ignore-on-command-line-tp5001395p7356224.html
Sent from the git mailing list archive at Nabble.com.
