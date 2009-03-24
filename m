From: Junio C Hamano <gitster@pobox.com>
Subject: Re: branch ahead in commits but push claims all up to date
Date: Tue, 24 Mar 2009 09:12:18 -0700
Message-ID: <7vskl2293x.fsf@gitster.siamese.dyndns.org>
References: <7001b7a00903240821v2155d234x6a10c80a3e987acb@mail.gmail.com>
 <7001b7a00903240822w70a57349xcc66a02cef62dc70@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Irene Ros <imirene@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 24 17:14:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lm9Gs-00058K-CS
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 17:14:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762316AbZCXQM3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Mar 2009 12:12:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762722AbZCXQM1
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 12:12:27 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:53639 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762716AbZCXQMZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Mar 2009 12:12:25 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id E84BD904B;
	Tue, 24 Mar 2009 12:12:22 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 339159048; Tue,
 24 Mar 2009 12:12:20 -0400 (EDT)
In-Reply-To: <7001b7a00903240822w70a57349xcc66a02cef62dc70@mail.gmail.com>
 (Irene Ros's message of "Tue, 24 Mar 2009 11:22:45 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8EE18A38-188E-11DE-B171-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114468>

Irene Ros <imirene@gmail.com> writes:

> Hi all,
>
> I've been using git for some time now and haven't run into this issue
> before, perhaps someone else here has:
>
> I have a branch that is ahead of its origin by a few commits:
>
> $ git status
> # On branch myBranch
> # Your branch is ahead of 'origin/myBranch' by 10 commits.
>
> Oddly, when I try to do a push, I get a message saying that everythin=
g
> is up to date:
> $ git push origin myBranch
> Everything up-to-date
>
> Looking at the log for origin/myBranch I can tell those commits are
> missing, but I can't push them up, even with a --force flag. Any
> ideas?
> Here's the config entry for this branch:
>
> [branch "myBranch"]
> =C2=A0=C2=A0=C2=A0 remote =3D origin
> =C2=A0=C2=A0=C2=A0 merge =3D refs/heads/myBranch

How does your

	[remote "origin"]

part look like?
