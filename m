From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: Questions about the new
Date: Mon, 12 Oct 2009 12:47:35 +0200
Message-ID: <871vl8ubw8.fsf@lysator.liu.se>
References: <loom.20091012T115746-719@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sergio <sergio.callegari@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 12 12:55:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxIZD-0004T5-2d
	for gcvg-git-2@lo.gmane.org; Mon, 12 Oct 2009 12:55:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756040AbZJLKsl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Oct 2009 06:48:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755481AbZJLKsk
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 06:48:40 -0400
Received: from lo.gmane.org ([80.91.229.12]:44775 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755449AbZJLKsk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 06:48:40 -0400
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1MxIRd-0001OP-Sb
	for git@vger.kernel.org; Mon, 12 Oct 2009 12:48:01 +0200
Received: from 62.20.90.206 ([62.20.90.206])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 12 Oct 2009 12:48:01 +0200
Received: from davidk by 62.20.90.206 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 12 Oct 2009 12:48:01 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 62.20.90.206
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
Cancel-Lock: sha1:h9h8MveDWm1XYTZxRY+SYpJ76Qw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130003>

Sergio <sergio.callegari@gmail.com> writes:

> Hi,
>
> I read from the release notes of git 1.6.5 about the new "replace" me=
chanism.
> It is presented as "a replacement of the "grafts" mechanism, with the=
 added
> advantage that it can be transferred across repositories."

Grafts allow you to change a little part of commit objects (the parent
relationship). Replacements allow (and require) you to change the whole
commit object. So obviously, anything you can do with grafts can be don=
e
with replacements.

If you have your A-B-x-x-x history and want to remove A from the
history, you replace B with a commit object that is identical, except
for the missing parent link to A.

Replacements allow you do to other kinds of changes as well (comments,
authorshiips) and changes to other object(?), so it is a much more
general mechanism.

But I missed the discussion about it, so I'm not sure why it was felt i=
t
was needed, or why the grafts mechanism wasn't enough.

--=20
David K=C3=A5gedal
