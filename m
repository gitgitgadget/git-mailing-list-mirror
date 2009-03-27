From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 09/10] bisect: implement "read_bisect_paths" to read paths in "$GIT_DIR/BISECT_NAMES"
Date: Fri, 27 Mar 2009 01:18:16 +0100
Message-ID: <200903270118.16564.chriscool@tuxfamily.org>
References: <20090326055559.743cb502.chriscool@tuxfamily.org> <7vwsacrd6x.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, John Tapsell <johnflux@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 27 01:22:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmzqP-0003ov-IN
	for gcvg-git-2@gmane.org; Fri, 27 Mar 2009 01:22:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932413AbZC0ATV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Mar 2009 20:19:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932650AbZC0ATT
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Mar 2009 20:19:19 -0400
Received: from smtp6-g21.free.fr ([212.27.42.6]:52830 "EHLO smtp6-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932706AbZC0ATS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Mar 2009 20:19:18 -0400
Received: from smtp6-g21.free.fr (localhost [127.0.0.1])
	by smtp6-g21.free.fr (Postfix) with ESMTP id C263DE08010;
	Fri, 27 Mar 2009 01:19:09 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp6-g21.free.fr (Postfix) with ESMTP id 9ED8AE08041;
	Fri, 27 Mar 2009 01:19:06 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <7vwsacrd6x.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114834>

Le jeudi 26 mars 2009, Junio C Hamano a =E9crit :
> Christian Couder <chriscool@tuxfamily.org> writes:
> > This is needed because  "git bisect--helper" must read bisect paths
> > in "$GIT_DIR/BISECT_NAMES", so that a bisection can be performed on=
ly
> > on commits that touches paths in this file.
> >
> > Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
>
> Again, very nice.

Thanks, but I found a big bug in this patch.
It doesn't work when there is more than one path in "$GIT_DIR/BISECT_NA=
MES"
because they are all on the same line, not on different lines.
I will try to fix it soon and provide some test cases.

Best regards,
Christian.
