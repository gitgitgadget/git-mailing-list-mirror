From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: [PATCH v3 1/3] Eliminate recursion in setting/clearing marks
 in commit list
Date: Sat, 14 Jan 2012 16:23:16 +0100
Message-ID: <20120114152316.GA30986@m62s10.vlinux.de>
References: <1326081546-29320-1-git-send-email-pclouds@gmail.com>
 <1326543595-28300-1-git-send-email-pclouds@gmail.com>
 <1326543595-28300-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 14 16:23:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rm5S4-0000e2-4G
	for gcvg-git-2@lo.gmane.org; Sat, 14 Jan 2012 16:23:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755014Ab2ANPXY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Jan 2012 10:23:24 -0500
Received: from mailout-de.gmx.net ([213.165.64.23]:34796 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754851Ab2ANPXX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jan 2012 10:23:23 -0500
Received: (qmail invoked by alias); 14 Jan 2012 15:23:20 -0000
Received: from m62s10.vlinux.de (EHLO m62s10.vlinux.de) [83.151.21.204]
  by mail.gmx.net (mp025) with SMTP; 14 Jan 2012 16:23:20 +0100
X-Authenticated: #1252284
X-Provags-ID: V01U2FsdGVkX1+3jN8g5yy3mJPjiKl1XD6ObdsgeIMXNlOfRTWBHs
	3RX5u9KjTC56bO
Received: by m62s10.vlinux.de (Postfix, from userid 1000)
	id D60EAD42AC; Sat, 14 Jan 2012 16:23:16 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1326543595-28300-2-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188572>

On Sat, Jan 14, 2012 at 07:19:53PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:
> Recursion in a DAG is generally a bad idea because it could be very
> deep. Be defensive and avoid recursion in mark_parents_uninteresting(=
)
> and clear_commit_marks().
>=20
> mark_parents_uninteresting() learns a trick from clear_commit_marks()
> to avoid malloc() in (dorminant) single-parent case.
                        ^^^^^^^^^

I think you ment dominant here.
