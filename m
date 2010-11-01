From: Kan-Ru Chen <kanru@kanru.info>
Subject: Re: [PATCH 0/3] Bringing git-ls-files to porcelain level
Date: Mon, 01 Nov 2010 18:30:57 +0800
Message-ID: <87zkttqqse.fsf@anar.kanru.info>
References: <1262884076-12293-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 01 12:33:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PCsdx-00056R-2a
	for gcvg-git-2@lo.gmane.org; Mon, 01 Nov 2010 12:33:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757303Ab0KALdg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Nov 2010 07:33:36 -0400
Received: from cp23.secserverpros.com ([67.220.217.187]:58871 "EHLO
	cp23.secserverpros.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754958Ab0KALdf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Nov 2010 07:33:35 -0400
X-Greylist: delayed 3743 seconds by postgrey-1.27 at vger.kernel.org; Mon, 01 Nov 2010 07:33:35 EDT
Received: from 61-30-10-70.static.tfn.net.tw ([61.30.10.70] helo=anar.kanru.info)
	by cp23.secserverpros.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <kanru@kanru.info>)
	id 1PCrfP-00043c-Eb; Mon, 01 Nov 2010 10:31:10 +0000
Received: from kanru by anar.kanru.info with local (Exim 4.72)
	(envelope-from <kanru@kanru.info>)
	id 1PCrfF-0008Ir-Nx; Mon, 01 Nov 2010 18:30:57 +0800
Mail-Followup-To: git@vger.kernel.org
In-Reply-To: <1262884076-12293-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Fri, 8 Jan
 2010 00:07:53 +0700")
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/24.0.50 (gnu/linux)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cp23.secserverpros.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kanru.info
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160479>

Hi,

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> This is a hack, to scratch my itch. These patches add "git ls",
> which is equivalent to "git ls-files --max-depth 1|column"

What is the status of this patch?

I found it might be useful for zsh completion codes. Currently zsh _git
completion relies heavily on ls-files and can be very slow on large
repository like linux kernel.

If ls-files supports --max-depth then zsh can do incremental
completion. (hopefully)

  kanru

--=20
=E2=80=9CA badly written book is only a blunder. A bad
 translation of a good book is a crime.=E2=80=9D -- Gilbert Highet
