From: Miles Bader <miles@gnu.org>
Subject: Re: git alias question
Date: Thu, 29 Dec 2011 12:21:22 +0900
Message-ID: <87wr9g2hcd.fsf@catnip.gol.com>
References: <CAFLRbopjqW7OEWN4kxy+6Gb828h4zBC_h=4WiP-q1__LeezxUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>
To: Michael Horowitz <michael.horowitz@ieee.org>
X-From: git-owner@vger.kernel.org Thu Dec 29 04:21:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rg6Yh-0002NJ-43
	for gcvg-git-2@lo.gmane.org; Thu, 29 Dec 2011 04:21:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752083Ab1L2DVa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Dec 2011 22:21:30 -0500
Received: from smtp12.dentaku.gol.com ([203.216.5.74]:49827 "EHLO
	smtp12.dentaku.gol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751336Ab1L2DV3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Dec 2011 22:21:29 -0500
Received: from 218.231.96.201.eo.eaccess.ne.jp ([218.231.96.201] helo=catnip.gol.com)
	by smtp12.dentaku.gol.com with esmtpa (Dentaku)
	(envelope-from <miles@gnu.org>)
	id 1Rg6YV-0002pU-Qy; Thu, 29 Dec 2011 12:21:23 +0900
Received: by catnip.gol.com (Postfix, from userid 1000)
	id CAB3BDFA1; Thu, 29 Dec 2011 12:21:22 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
In-Reply-To: <CAFLRbopjqW7OEWN4kxy+6Gb828h4zBC_h=4WiP-q1__LeezxUw@mail.gmail.com>
	(Michael Horowitz's message of "Wed, 28 Dec 2011 20:27:59 -0500")
X-Virus-Scanned: ClamAV GOL (outbound)
X-Abuse-Complaints: abuse@gol.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187770>

Michael Horowitz <michael.horowitz@ieee.org> writes:
> I was able to make the following 2 aliases, which work perfectly
> except for one problem...
>
> ldiff = "!git diff `git rev-list --reverse -n 2 HEAD -- $1` -- $1"
> ldifft = "!git difftool `git rev-list --reverse -n 2 HEAD -- $1` -- $1"
>
> The problem is the limitation that shell commands are always executed
> at the top-level directory of the repository.

Hmmm, it'd be cool if git exported an environment variable containing
the CWD when it invoked external aliases like this...!

-Miles

-- 
Love is the difficult realization that something other than oneself is real.
[Iris Murdoch]
