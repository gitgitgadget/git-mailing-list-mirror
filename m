From: Adam Megacz <adam@megacz.com>
Subject: Re: edit Author/Date metadata as part of 'git commit' $EDITOR  invocation?
Date: Fri, 08 Jan 2010 07:35:57 +0000
Organization: Myself
Message-ID: <xuu28wc9xd42.fsf@nowhere.com>
References: <xuu2fx6m4vdi.fsf@nowhere.com> <fabb9a1e1001041232h4e5827d1pb5c648b33ecfb5ce@mail.gmail.com> <xuu2zl4tfuij.fsf@nowhere.com> <20100106073806.6117@nanako3.lavabit.com> <7v4omz17xz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 08 08:36:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NT9OX-0008Pc-9l
	for gcvg-git-2@lo.gmane.org; Fri, 08 Jan 2010 08:36:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752631Ab0AHHgZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2010 02:36:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752323Ab0AHHgZ
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jan 2010 02:36:25 -0500
Received: from lo.gmane.org ([80.91.229.12]:52896 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750799Ab0AHHgY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jan 2010 02:36:24 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1NT9OP-0008Os-0L
	for git@vger.kernel.org; Fri, 08 Jan 2010 08:36:21 +0100
Received: from gentzen.megacz.com ([65.23.129.159])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 08 Jan 2010 08:36:20 +0100
Received: from adam by gentzen.megacz.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 08 Jan 2010 08:36:20 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: gentzen.megacz.com
X-Home-Page: http://www.megacz.com/
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.3 (gnu/linux)
Cancel-Lock: sha1:/kCkJlzIDAoneefoG3+o+SPeAKs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136419>


Junio C Hamano <gitster@pobox.com> writes:
> Nanako Shiraishi <nanako3@lavabit.com> writes:
>> Quoting Adam Megacz <adam@megacz.com>
>>> Perhaps a preference (off by default) demanding that they be set
>>> explicitly when "git commit -m" is used?

>> Sverre pointed out why this won't work.

I agree; making it a preference will not help.

I propose instead that "git commit -e" cause the metadata headers to be
provided to $EDITOR.  People who care about the metadata can simply get
in the habit of always passing that option when invoking "git commit".

> The approach may have been Ok 10 years ago, back when `whoami`@`hostname`,
> at least on systems that were competently maintained, gave a reasonable
> mail address for most people, but I don't think it is adequate anymore to
> majority of people,

I agree.

> So I don't think anybody minds if we refuse to work if we are going to end
> up using a name that we didn't get from an explicit end user configuration
> (i.e. GIT_*_EMAIL and GIT_*_NAME environment and user.* configuration
> variables).

I support that as well, although I'd still like to be shown the data.  I
wear a few different hats (each with its own email address), and I don't
think I want to pick one of them as the default.

Thanks,

  - a
