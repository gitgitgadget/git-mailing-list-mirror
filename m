From: Jan Engelhardt <jengelh@inai.de>
Subject: Re: A new way to get a sha1?
Date: Mon, 30 Jul 2012 14:28:36 +0200 (CEST)
Message-ID: <alpine.LNX.2.01.1207301426090.25013@frira.zrqbmnf.qr>
References: <jv5tln$96e$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Thomas Badie <thomas.badie@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 30 14:28:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Svp5Z-0002GA-Je
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jul 2012 14:28:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753732Ab2G3M2j convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Jul 2012 08:28:39 -0400
Received: from seven.medozas.de ([5.9.24.206]:50620 "EHLO seven.medozas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753452Ab2G3M2h (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2012 08:28:37 -0400
Received: by seven.medozas.de (Postfix, from userid 25121)
	id DC03F96A02B5; Mon, 30 Jul 2012 14:28:36 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by seven.medozas.de (Postfix) with ESMTP id AE47B96A0295;
	Mon, 30 Jul 2012 14:28:36 +0200 (CEST)
In-Reply-To: <jv5tln$96e$1@dough.gmane.org>
User-Agent: Alpine 2.01 (LNX 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202538>

On Monday 2012-07-30 14:11, Thomas Badie wrote:

>Hi all,
>
>When I should fixup or squash a commit, I nearly never
>remember how to get the sha1 of the commit I want to fixup.
>Because sometimes HEAD~n is not enough, I make `git log`,
>copy the sha1 of the right commit and paste it in my git
>fixup command. So I wrote a perl script to avoid the usage
>of the mouse.

If you use screen(1), you can use the keyboard as well; it offers ^A [=20
and ^A ] for copy, and then paste. tmux and all those screen clones=20
probably have something similar. Maybe ratpoison-like WMs do as well.
Or, you can use `git log --oneline`, look for the commit and then
type the (usually) 6-char part of the hash manually, which may be faste=
r=20
than ^A[, moving the cursor to the copy position, marking it, etc.

>So, what is your opinion?

IMO, I thus never needed an extra tool to find and specify the hash for=
=20
`git re -i hash^`..

my =C2=A52
