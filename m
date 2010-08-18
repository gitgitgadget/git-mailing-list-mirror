From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 1/6] Add string comparison functions that respect the ignore_case variable.
Date: Wed, 18 Aug 2010 20:32:40 +0200
Message-ID: <201008182032.40375.j6t@kdbg.org>
References: <cover.1281985411.git.j6t@kdbg.org> <4C6C01A9.4080306@workspacewhiz.com> <AANLkTinwQqwjmeNfiUE6LiZtbBhEEFyisZXUgF9_b+2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Joshua Jensen <jjensen@workspacewhiz.com>, git@vger.kernel.org
To: =?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
	<avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 18 20:32:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlnRU-00038L-PV
	for gcvg-git-2@lo.gmane.org; Wed, 18 Aug 2010 20:32:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753484Ab0HRScm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Aug 2010 14:32:42 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:34952 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753470Ab0HRScm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Aug 2010 14:32:42 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id A1808CDF87;
	Wed, 18 Aug 2010 20:32:40 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 67D3E19F5FD;
	Wed, 18 Aug 2010 20:32:40 +0200 (CEST)
User-Agent: KMail/1.9.10
In-Reply-To: <AANLkTinwQqwjmeNfiUE6LiZtbBhEEFyisZXUgF9_b+2Q@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153872>

On Mittwoch, 18. August 2010, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wr=
ote:
> According to some further research at least FreeBSD and NetBSD have
> copied this GNU extension. You may find their versions easier to
> integrate.

We already have a GNU fnmatch in compat/fnmatch.

-- Hannes
