From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: [StGit PATCH] Emacs mode: automatically cd up to root of worktree
Date: Wed, 14 May 2008 09:38:24 +0200
Message-ID: <87r6c5uyhb.fsf@lysator.liu.se>
References: <20080514014309.GA17955@diana.vm.bytemark.co.uk>
	<20080514014820.7140.28591.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>,
	Karl =?utf-8?Q?Hasselstr?= =?utf-8?Q?=C3=B6m?= 
	<kha@treskal.com>
X-From: git-owner@vger.kernel.org Wed May 14 09:39:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwBa2-000794-BO
	for gcvg-git-2@gmane.org; Wed, 14 May 2008 09:39:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752496AbYENHi2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 May 2008 03:38:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752430AbYENHi2
	(ORCPT <rfc822;git-outgoing>); Wed, 14 May 2008 03:38:28 -0400
Received: from mail.lysator.liu.se ([130.236.254.3]:52716 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751875AbYENHi1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2008 03:38:27 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 2368C200A340;
	Wed, 14 May 2008 09:38:26 +0200 (CEST)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 27020-01-36; Wed, 14 May 2008 09:38:25 +0200 (CEST)
Received: from krank (unknown [87.96.142.66])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id B91DF200A1D0;
	Wed, 14 May 2008 09:38:25 +0200 (CEST)
Received: by krank (Postfix, from userid 1000)
	id 0AC4D7B4039; Wed, 14 May 2008 09:38:24 +0200 (CEST)
In-Reply-To: <20080514014820.7140.28591.stgit@yoghurt> ("Karl =?utf-8?Q?Ha?=
 =?utf-8?Q?sselstr=C3=B6m=22's?= message of "Wed\, 14 May 2008 03\:49\:09
 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82082>

Karl Hasselstr=C3=B6m <kha@treskal.com> writes:

> git's emacs mode automatically finds the root of the worktree, so tha=
t
> the user doesn't have to. Teach StGit's emacs mode the same trick by
> borrowing the git-get-top-dir function from git.
>
> The borrowed code was written by Alexandre Julliard <julliard@winehq.=
org>.
>
> Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

Signed-off-by: David K=C3=A5gedal <davidk@lysator.liu.se>

Excellent. It's an itch that I've been meaning to scratch for some time=
=2E

--=20
David K=C3=A5gedal
