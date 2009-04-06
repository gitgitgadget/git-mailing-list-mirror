From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: [RFC/PATCH 0/2] New 'stage' command
Date: Mon, 06 Apr 2009 15:42:44 +0200
Message-ID: <87vdphj3u3.fsf@krank.kagedal.org>
References: <1238939331-10152-1-git-send-email-felipe.contreras@gmail.com>
	<200904052358.53028.markus.heidelberg@web.de>
	<94a0d4530904051535v8bd901fsedecdf61bc4acb33@mail.gmail.com>
	<200904060117.24810.markus.heidelberg@web.de>
	<fabb9a1e0904051622k66352ea4v542ecd99bd5d9c6@mail.gmail.com>
	<20090406032457.GA14758@gmail.com>
	<7v63hie4yh.fsf@gitster.siamese.dyndns.org>
	<871vs5kjfw.fsf@krank.kagedal.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Aguilar <davvid@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	markus.heidelberg@web.de,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 06 15:44:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lqp7d-0003I6-Es
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 15:44:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755015AbZDFNmt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Apr 2009 09:42:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754547AbZDFNms
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 09:42:48 -0400
Received: from mail.lysator.liu.se ([130.236.254.3]:35697 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754415AbZDFNmr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2009 09:42:47 -0400
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 2ABD340040;
	Mon,  6 Apr 2009 15:42:34 +0200 (CEST)
Received: by mail.lysator.liu.se (Postfix, from userid 1674)
	id 1E67E40043; Mon,  6 Apr 2009 15:42:34 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb3 (2006-10-05) on 
	bernadotte.lysator.liu.se
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=5.0 tests=AWL autolearn=disabled 
	version=3.1.7-deb3
Received: from krank (unknown [87.96.142.66])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id DD00B40040;
	Mon,  6 Apr 2009 15:42:33 +0200 (CEST)
Received: by krank (Postfix, from userid 1000)
	id A4756DC0C0; Mon,  6 Apr 2009 15:42:44 +0200 (CEST)
In-Reply-To: <871vs5kjfw.fsf@krank.kagedal.org> ("David =?utf-8?Q?K=C3=A5g?=
 =?utf-8?Q?edal=22's?= message of "Mon\, 06 Apr 2009 15\:20\:19 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115830>

David K=C3=A5gedal <davidk@lysator.liu.se> writes:

> We wouldn't have to use the "STAGE" or "WORKTREE" names, of course. I=
t
> doesn't have to look like refspecs even. The last example already has
> a syntax that matches the suggestion:
>
>      git diff --cached <commit>
>
> So, extrapolating this to "git diff --worktree --cached" would mean
> what "git diff -R" means today etc.

BTW, I don't really care much about whether it's spelled "cached"
"index" "staged" or "dumbledore". I just want some regularity in the
diff command. I'll happily let someone else figure out the taxonomy.

--=20
David K=C3=A5gedal
