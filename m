From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: Missing pieces for 1.6.0 on MinGW?
Date: Sun, 3 Aug 2008 12:10:44 +0200
Message-ID: <20080803101044.GA32565@atjola.homenet>
References: <7vljzfkzkv.fsf@gitster.siamese.dyndns.org> <1217754985.4895776973fda@webmail.nextra.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Steffen Prohaska <prohaska@zib.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Sun Aug 03 12:12:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPaZ4-0000VI-97
	for gcvg-git-2@gmane.org; Sun, 03 Aug 2008 12:11:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752132AbYHCKKt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Aug 2008 06:10:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752090AbYHCKKt
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Aug 2008 06:10:49 -0400
Received: from mail.gmx.net ([213.165.64.20]:59069 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752001AbYHCKKs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Aug 2008 06:10:48 -0400
Received: (qmail invoked by alias); 03 Aug 2008 10:10:46 -0000
Received: from i577BB3F8.versanet.de (EHLO atjola.local) [87.123.179.248]
  by mail.gmx.net (mp033) with SMTP; 03 Aug 2008 12:10:46 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX19U6BoVvX5UTAqGjF3BZGwpbgzsOmgjTlTCRXwztC
	qELdyVxUwZvKX4
Content-Disposition: inline
In-Reply-To: <1217754985.4895776973fda@webmail.nextra.at>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91222>

On 2008.08.03 11:16:25 +0200, Johannes Sixt wrote:
> (3) the 'mingw_main undefined' error is still a mystery. I'm about to=
 send a
> preprocessed file to Steffen (it's a bit large, even compressed, so I=
'll do
> that in a private mail).

=46WIW, gcc 4.3 complains about such function declarations:
x.c:4: error: invalid storage class for function =E2=80=98foo=E2=80=99

Seems that gcc complains about that since 4.0, and linking failed with
older versions under some circumstances.

http://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D12738
http://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D17205

Bj=C3=B6rn
