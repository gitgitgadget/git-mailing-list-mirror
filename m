From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 1/6] Add string comparison functions that respect the ignore_case variable.
Date: Mon, 30 Aug 2010 22:13:07 +0200
Message-ID: <201008302213.07279.j6t@kdbg.org>
References: <cover.1281985411.git.j6t@kdbg.org> <201008302040.10399.j6t@kdbg.org> <AANLkTi=CeeBkHZgCOtACxCtWoab6Q+3Jwtx327KDFjqh@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Joshua Jensen <jjensen@workspacewhiz.com>, git@vger.kernel.org
To: =?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
	<avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 30 22:13:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqAjK-0001b7-6f
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 22:13:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754338Ab0H3UNM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Aug 2010 16:13:12 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:59828 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752343Ab0H3UNL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Aug 2010 16:13:11 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 99E7CCDF8D;
	Mon, 30 Aug 2010 22:13:07 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 5D1FD19F5AB;
	Mon, 30 Aug 2010 22:13:07 +0200 (CEST)
User-Agent: KMail/1.9.10
In-Reply-To: <AANLkTi=CeeBkHZgCOtACxCtWoab6Q+3Jwtx327KDFjqh@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154843>

On Montag, 30. August 2010, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrot=
e:
> So why does e.g. compat/snprintf.c need to "#undef snprintf" before
> defining it again?

Because the implementation of the compat snprintf uses the system's snp=
rintf.

There are other cases, like e.g., pread, where it would not be necessar=
y to=20
#define pread git_pread.

-- Hannes
