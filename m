From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Git Notes - Search Functionality
Date: Wed, 27 Feb 2013 16:57:46 +0100
Message-ID: <874ngxagw5.fsf@pctrast.inf.ethz.ch>
References: <CAFZnXLJCiq4G+_ZStWmjAGePWCD6mhske7Y4=oe2h==F0BYVLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>
To: krishna chaitanya kurnala <kkc4al@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 27 16:58:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UAjOY-0003QR-4C
	for gcvg-git-2@plane.gmane.org; Wed, 27 Feb 2013 16:58:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753218Ab3B0P5t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2013 10:57:49 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:11828 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751542Ab3B0P5s (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2013 10:57:48 -0500
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Wed, 27 Feb
 2013 16:57:40 +0100
Received: from pctrast.inf.ethz.ch.ethz.ch (129.132.153.233) by
 CAS20.d.ethz.ch (172.31.51.110) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Wed, 27 Feb 2013 16:57:46 +0100
In-Reply-To: <CAFZnXLJCiq4G+_ZStWmjAGePWCD6mhske7Y4=oe2h==F0BYVLQ@mail.gmail.com>
	(krishna chaitanya kurnala's message of "Wed, 27 Feb 2013 07:34:58
	-0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217215>

krishna chaitanya kurnala <kkc4al@gmail.com> writes:

>    I working on Git Notes. I want to know if there is an easy way to
> obtain a list of all "namespaces"(For eg., git notes --ref=namespace
> ... ) with notes objects in a specific git repository. We can easily
> create, edit, merge git notes with commands if we know the namespaces
> and/or the sha. But, for example, Has anyone tried to search for a
> string in a git notes objects for that project etc?
>   The closest i can think of is using some options with git logs, for
> example, git log --show-notes=*  --format="%H %N" etc.
>
> Appreciate your time.

An easy way to list everything in refs/notes/ is

  git for-each-ref refs/notes/

but that of course won't figure out if you have more notes e.g. in
refs/remotes/origin/notes/* or some such.  I think this more general
problem can be solved only by heuristics, since the notes trees are
actually "just trees" -- the only distinction is that they have fairly
funny filenames in them.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
