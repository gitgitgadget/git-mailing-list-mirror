From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: [PATCH] rebase: be cleverer with rebased upstream branches
Date: Wed, 16 Feb 2011 22:16:11 +0100
Message-ID: <AANLkTi=e+T2V+cnVYKziU7ezQdMpbBcxke4vj0AH7DZc@mail.gmail.com>
References: <1297691481-3308-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <7vzkpxm45e.fsf@alter.siamese.dyndns.org> <alpine.DEB.2.00.1102152040370.14950@debian>
 <AANLkTinmxbYLB-K+VzY50NtOAPwd-q3WwAosAHqKRq_0@mail.gmail.com>
 <AANLkTinsvfXjVhJfLDeZ+g4skev6bBmJgByyxXW7eO39@mail.gmail.com> <7vei77kdce.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 16 22:16:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ppojm-0001Hj-7f
	for gcvg-git-2@lo.gmane.org; Wed, 16 Feb 2011 22:16:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754736Ab1BPVQd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Feb 2011 16:16:33 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:59669 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751036Ab1BPVQc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Feb 2011 16:16:32 -0500
Received: by qwa26 with SMTP id 26so1711688qwa.19
        for <git@vger.kernel.org>; Wed, 16 Feb 2011 13:16:31 -0800 (PST)
Received: by 10.229.250.130 with SMTP id mo2mr1291362qcb.163.1297890991323;
 Wed, 16 Feb 2011 13:16:31 -0800 (PST)
Received: by 10.229.225.8 with HTTP; Wed, 16 Feb 2011 13:16:11 -0800 (PST)
In-Reply-To: <7vei77kdce.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167002>

On Wed, Feb 16, 2011 at 8:07 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Santi B=E9jar <santi@agolina.net> writes:
>
>>> + =A0 =A0oldremoteref=3D$(git merge-base $curr_branch $oldremoteref=
 $(git
>>> rev-list -g $remoteref 2>/dev/null))
>
> Yuck; the entire set of commits that appear in reflog can be quite lo=
ng.
> What will happen when this exceeds the shell command line limit or wh=
en
> you get E2BIG from execve(2)?
>

Sure, but it was just a proof of concept to test the algorithm.

Santi
