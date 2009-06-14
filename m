From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] format-patch: add --filename-prefix to prepend a prefix to output file names
Date: Sun, 14 Jun 2009 01:25:26 -0700
Message-ID: <7vk53fql1l.fsf@alter.siamese.dyndns.org>
References: <7vr5xsozcm.fsf@alter.siamese.dyndns.org>
	<1244963400-1739-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>, Andreas Ericsson <ae@op5.se>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 14 10:26:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFl39-0006yZ-St
	for gcvg-git-2@gmane.org; Sun, 14 Jun 2009 10:26:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754011AbZFNIZf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Jun 2009 04:25:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753911AbZFNIZe
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Jun 2009 04:25:34 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:45243 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753630AbZFNIZY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jun 2009 04:25:24 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090614082526.QMVI17670.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Sun, 14 Jun 2009 04:25:26 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id 3kRS1c0024aMwMQ03kRS5D; Sun, 14 Jun 2009 04:25:26 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=0x9OhrcHy5gA:10 a=yTbM2EVNuUQA:10
 a=pGLkceISAAAA:8 a=nfjPVkwdqLSNrP55pPsA:9 a=vAxLvt1WELtdcA0FqIcA:7
 a=V89AgNrw3YjN-qV_ujJPR2Gkg0QA:4 a=MSl-tDqOz04A:10
X-CM-Score: 0.00
In-Reply-To: <1244963400-1739-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuIFRow6FpIE5n4buNYw==?= Duy"'s message of "Sun\, 14
 Jun 2009 17\:10\:00 +1000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121544>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

>  > I am not saying we must allow a slash in the prefix and create nec=
essary
>  > leading paths ourselves, nor we must check for a slash and fail in=
 the
>  > input validation phase, but I am wondering if we can have some cle=
ver way
>  > to internally unify the handling of this new option with --outdir.
>
>  Hardly, the way it is handled now (chdir()ing to --outdir, then writ=
e patches)

Ah, true enough.  Thanks.
