From: Jeremy Morton <jeremy@configit.com>
Subject: Re: git push default behaviour?
Date: Thu, 8 Mar 2012 10:13:41 +0000
Message-ID: <CAFsnPqopZEZeeuFzK4ZoUjGnfpiv5oMs=xV5XBSgSyGLXOwgqA@mail.gmail.com>
References: <CAFsnPqp1+jX3ZY0LZ1QDmvA=2_ebApPBttwFjr36OuTX2_MHug@mail.gmail.com>
	<87k42vs8pi.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Mar 08 11:13:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5aM0-0005LZ-CW
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 11:13:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756458Ab2CHKNo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Mar 2012 05:13:44 -0500
Received: from mail-lb0-f174.google.com ([209.85.217.174]:45769 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756376Ab2CHKNn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Mar 2012 05:13:43 -0500
Received: by lbbgm6 with SMTP id gm6so49254lbb.19
        for <git@vger.kernel.org>; Thu, 08 Mar 2012 02:13:42 -0800 (PST)
Received: by 10.152.102.145 with SMTP id fo17mr4075673lab.2.1331201621965;
 Thu, 08 Mar 2012 02:13:41 -0800 (PST)
Received: by 10.112.23.225 with HTTP; Thu, 8 Mar 2012 02:13:41 -0800 (PST)
In-Reply-To: <87k42vs8pi.fsf@thomas.inf.ethz.ch>
X-Gm-Message-State: ALoCoQmb36+s9fYFH9igMnkDU2pljnuWXfw6vjMBoa1FzeAxDvE+NZ8g8g+oBdwS0ZjTaSV8YN8L
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192549>

Right, so I guess I'm saying that the default value for push.default
should be upstream instead of matching...

Best regards,
Jeremy Morton (Jez)

On Thu, Mar 8, 2012 at 10:11 AM, Thomas Rast <trast@inf.ethz.ch> wrote:
> Jeremy Morton <jeremy@configit.com> writes:
>
>> I've noticed that the default behaviour of 'git push' is to push to
>> *all* branches that have a remote branch set up.
> [...]
>> Wouldn't it be better for git's default push behaviour (at least wit=
h
>> the '--force' option) to be just to push to the current branch in th=
e
>> current repo?=A0 To push to all branches you could have an
>> '--allbranches' option.
>
> See push.default in git-config(1).
>
> --
> Thomas Rast
> trast@{inf,student}.ethz.ch
