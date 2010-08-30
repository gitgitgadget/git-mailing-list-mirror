From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 1/6] Add string comparison functions that respect the ignore_case variable.
Date: Mon, 30 Aug 2010 20:40:10 +0200
Message-ID: <201008302040.10399.j6t@kdbg.org>
References: <cover.1281985411.git.j6t@kdbg.org> <AANLkTimtmudtWccRS==LrO_JrPmAJ7HzA6CU0ALbDZcV@mail.gmail.com> <4C7BC344.9020500@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
	<avarab@gmail.com>, git@vger.kernel.org
To: Joshua Jensen <jjensen@workspacewhiz.com>
X-From: git-owner@vger.kernel.org Mon Aug 30 20:40:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oq9HM-0006Wf-44
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 20:40:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755667Ab0H3SkP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Aug 2010 14:40:15 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:50572 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752216Ab0H3SkO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Aug 2010 14:40:14 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id C5C83CDFA0;
	Mon, 30 Aug 2010 20:40:10 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 7F18619F5AB;
	Mon, 30 Aug 2010 20:40:10 +0200 (CEST)
User-Agent: KMail/1.9.10
In-Reply-To: <4C7BC344.9020500@workspacewhiz.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154839>

On Montag, 30. August 2010, Joshua Jensen wrote:
> From: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> >      +       COMPAT_OBJS =3D compat/fnmatch/fnmatch.o
> >      +       COMPAT_CFLAGS =3D -Icompat -Icompat/fnmatch
=2E..
> You added COMPAT_OBJS
> above, but I think there is no linker guarantee it will pick up
> compat/fnmatch/fnmatch.o over the C runtime version?

The way linkers work ensures that git code picks up the compat version =
when=20
defined this way.

-- Hannes
