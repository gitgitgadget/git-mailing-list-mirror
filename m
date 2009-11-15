From: Tim Henigan <tim.henigan@gmail.com>
Subject: Re: [PATCH] Update 'git remote' usage and man page to match.
Date: Sat, 14 Nov 2009 23:34:00 -0500
Message-ID: <32c343770911142034j6cf10e36jbd031c49119973c8@mail.gmail.com>
References: <32c343770911121715l7507b2d5j8c6cf8cccd1f1a61@mail.gmail.com>
	 <20091114071948.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: gitster@pobox.com, git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Sun Nov 15 05:34:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9Woc-0007JE-B5
	for gcvg-git-2@lo.gmane.org; Sun, 15 Nov 2009 05:34:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751812AbZKOEd5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Nov 2009 23:33:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751796AbZKOEd5
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Nov 2009 23:33:57 -0500
Received: from ey-out-2122.google.com ([74.125.78.24]:52693 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751787AbZKOEd5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Nov 2009 23:33:57 -0500
Received: by ey-out-2122.google.com with SMTP id 9so662702eyd.5
        for <git@vger.kernel.org>; Sat, 14 Nov 2009 20:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=+GvyjF065OdIrhMJuZtErz1mg5mhhRPEtVaczDZnSPw=;
        b=b0gK8y+g+Y4cQXBBDnBoQYxNbuBFmqhdPJV+GRQIEBCP6LznE0sgEYmEFVbIo8hRco
         h6b+m3dW1u+NEeZNH2oTV4YWFvQB+oN17ooz7oEjArHtAtoQgiNrQsp1AIayZIrTaWGZ
         SwOpNdiLXsGR3/lNuv+53VieZXElyBS4SFsjs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=ATvWU95DTEn5Wok7RmB6la3jt52/hMBC3B/tZUyhibGbANcV2nqfOyc8HGgEEdy8WO
         GIpXd+jBogEtS8bwUy4QRe+yOc8Mj4BAXxeXs9x6Vs1cHGcUmq62mknweak4oRt8edNM
         ZQ0KocsSprB9QpknmWRG4sgCCo3gvuUk9y4YI=
Received: by 10.216.90.133 with SMTP id e5mr561608wef.23.1258259640967; Sat, 
	14 Nov 2009 20:34:00 -0800 (PST)
In-Reply-To: <20091114071948.6117@nanako3.lavabit.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132908>

On Fri, Nov 13, 2009 at 5:19 PM, Nanako Shiraishi <nanako3@lavabit.com> wrote:
>
> The second change is good but why do you remove -v from the
> synopsis section? Why is it a good idea? Manual pages for
> many other commands list --verbose in their synopsis section.
>

After checking other git operations (fetch, pull, clone, commit, merge, etc)
I found that none of these other commands document '-v' in the synopsis.

With that in mind, I wondered why it had been listed for 'git remote'.  My best
guess is that only some of the 'git remote' subcommands are affected by '-v'.
However, to me it still seems better to only mention it as a general option.
That way if subcommands add/remote support for '-v', the usage string
and man page don't need to be updated.

Please note that even with the change, '-v' is still printed as one of the
general options in the usage string.  I simply removed it from the synopsis
section.

Thank for reviewing,
Tim
