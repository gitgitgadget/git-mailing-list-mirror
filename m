From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2] bisect reset: Allow resetting to any commit, not just a branch
Date: Tue, 13 Oct 2009 22:30:04 +0200
Message-ID: <200910132230.04498.chriscool@tuxfamily.org>
References: <alpine.DEB.1.10.0910121237540.2223@dr-wily.mit.edu> <200910132206.18460.chriscool@tuxfamily.org> <alpine.DEB.2.00.0910131605170.5105@dr-wily.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Anders Kaseorg <andersk@mit.edu>
X-From: git-owner@vger.kernel.org Tue Oct 13 22:41:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxoBn-0006cE-GB
	for gcvg-git-2@lo.gmane.org; Tue, 13 Oct 2009 22:41:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934260AbZJMU2z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Oct 2009 16:28:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752347AbZJMU2z
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Oct 2009 16:28:55 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:47521 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752010AbZJMU2y convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Oct 2009 16:28:54 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 1FA8A8194E0;
	Tue, 13 Oct 2009 22:28:12 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 1AFE48194BB;
	Tue, 13 Oct 2009 22:28:10 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.DEB.2.00.0910131605170.5105@dr-wily.mit.edu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130206>

On Tuesday 13 October 2009, Anders Kaseorg wrote:
> On Tue, 13 Oct 2009, Christian Couder wrote:
> > +       1) git rev-parse --quiet --verify "$1^{commit}" > /dev/null=
 ||
> > +               die "'$1' does not seem to point to a valid commit"
> >
> > It would give a better error message when "git rev-parse" fails ins=
tead
> > of:
> >
> > fatal: Needed a single revision
> >
> > and it would not print the SHA1 from "$1^{commit}" when "git rev-pa=
rse"
> > succeeds.
>
> Oh, oops, I somehow lost the > /dev/null in my version.
>
> But as for the =E2=80=98git rev-parse=E2=80=99 error being confusing,=
 why don=E2=80=99t we fix
> =E2=80=98git rev-parse=E2=80=99 instead?

It's a plumbing command, and the output of plumbing commands is not sup=
posed=20
to change a lot as some scripts may rely on it.

And anyway that would be in another patch.

Best regards,
Christian.
