From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] BUG: git push on an empty clone segfaults.
Date: Mon, 20 Apr 2009 12:55:10 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0904201252120.6955@intel-tinevez-2-302>
References: <1240220930-24679-1-git-send-email-Matthieu.Moy@imag.fr> <7vfxg3ipib.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1158155535-1240224911=:6955"
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>,
	=?VISCII?Q?Nguy=ADn_Th=E1i_Ng=F7c_Duy?= <pclouds@gmail.com>,
	git@vger.kernel.org
To: pasky@suse.cz, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 20 12:57:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvrBA-0008Gv-FS
	for gcvg-git-2@gmane.org; Mon, 20 Apr 2009 12:56:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754043AbZDTKzP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2009 06:55:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753648AbZDTKzO
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 06:55:14 -0400
Received: from mail.gmx.net ([213.165.64.20]:44876 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752741AbZDTKzN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2009 06:55:13 -0400
Received: (qmail invoked by alias); 20 Apr 2009 10:55:11 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp040) with SMTP; 20 Apr 2009 12:55:11 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18Hm9QP+vQHQ7Ljv7oP+/q0NAO/KZSVcGuEZDbp12
	NfQh4V2Kdu+lRJ
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <7vfxg3ipib.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116965>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1158155535-1240224911=:6955
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi,

On Mon, 20 Apr 2009, Junio C Hamano wrote:

> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
> 
> > Ideally, "git push" from an empty repository to another empty one
> > should be a no-op, or perhaps should error out cleanly. Currently, it
> > just segfaults.
> 
> Didn't we see this fixed by Nguyễn with 55f0566 (get_local_heads(): do not
> return random pointer if there is no head, 2009-04-17)?

I fetched from repo.or.cz and tested with 'master', and it was broken.  
Apparently git://repo.or.cz/git.git is lagging behind by 5 days.  Pasky?

Ciao,
Dscho

--8323329-1158155535-1240224911=:6955--
