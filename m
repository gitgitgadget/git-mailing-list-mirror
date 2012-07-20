From: <dag@cray.com>
Subject: Re: [ANNOUNCE] Sharness - Test library derived from Git
Date: Fri, 20 Jul 2012 16:11:58 -0500
Message-ID: <nngmx2ujfxd.fsf@transit.us.cray.com>
References: <CAMFa-2hS-5CHQj79KMGwY7_qv6nGiK+9cKeDdihMVmSoxfsesQ@mail.gmail.com>
	<CACBZZX6QZACjkFPEsNgAkKgnkZHDsCOEAm=-9rs=PLiSfgsXBw@mail.gmail.com>
	<CAMFa-2gRWRKgj140i1q9iux=eC6nWxfdUPPhb42xAG1Gr7e4vA@mail.gmail.com>
	<vpq7gtyr6zt.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Mathias Lafeldt <mathias.lafeldt@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJu?= =?utf-8?B?ZmrDtnLDsA==?= Bjarmason 
	<avarab@gmail.com>, <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Jul 20 23:13:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SsKVv-0002r1-4x
	for gcvg-git-2@plane.gmane.org; Fri, 20 Jul 2012 23:13:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753221Ab2GTVN0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jul 2012 17:13:26 -0400
Received: from exprod6og113.obsmtp.com ([64.18.1.31]:33551 "EHLO
	exprod6og113.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752268Ab2GTVNZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jul 2012 17:13:25 -0400
Received: from CFWEX01.americas.cray.com ([136.162.34.11]) (using TLSv1) by exprod6ob113.postini.com ([64.18.5.12]) with SMTP
	ID DSNKUAnJ8Z3VIgwAcIwMBvt9IONvwCNeBZ8Y@postini.com; Fri, 20 Jul 2012 14:13:25 PDT
Received: from transit.us.cray.com (172.31.17.53) by CFWEX01.americas.cray.com
 (172.30.88.25) with Microsoft SMTP Server (TLS) id 14.2.298.4; Fri, 20 Jul
 2012 16:11:58 -0500
In-Reply-To: <vpq7gtyr6zt.fsf@bauges.imag.fr> (Matthieu Moy's message of "Fri,
	20 Jul 2012 13:45:26 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201792>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> OTOH, having it leave in a subdirectory (e.g. $git/t/Sharness/), and
> synchronize with stg like subtree merge would be nice for the user. We
> already have something similar for gitk and git-gui, except that the
> synchronization is normally one way (subprojects merged into Git, but
> merging back changes that were made in git.git in these subprojects is
> more painful).

Not really.  contrib/git-subtree can really help with this.

                           -Dave
