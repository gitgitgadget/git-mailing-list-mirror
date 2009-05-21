From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v0 3/3] Build in git-rebase.sh
Date: Thu, 21 May 2009 07:39:30 -0700
Message-ID: <7vhbzebjvh.fsf@alter.siamese.dyndns.org>
References: <1242899229-27603-1-git-send-email-pclouds@gmail.com>
	<1242899229-27603-2-git-send-email-pclouds@gmail.com>
	<1242899229-27603-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 21 16:39:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M79Qo-0003hX-Kz
	for gcvg-git-2@gmane.org; Thu, 21 May 2009 16:39:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753374AbZEUOjb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 May 2009 10:39:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753083AbZEUOja
	(ORCPT <rfc822;git-outgoing>); Thu, 21 May 2009 10:39:30 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:33055 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751638AbZEUOj3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2009 10:39:29 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090521143930.YVRW18948.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Thu, 21 May 2009 10:39:30 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id uEfW1b00A4aMwMQ03EfWVW; Thu, 21 May 2009 10:39:30 -0400
X-Authority-Analysis: v=1.0 c=1 a=ECYJSX4P2JAA:10 a=azpQuX_XDtQA:10
 a=pGLkceISAAAA:8 a=p2_q4hGOVibdURykVHcA:9 a=l1STiLmD3Jo84-XrOoUhUv41bQIA:4
 a=MSl-tDqOz04A:10
X-CM-Score: 0.00
In-Reply-To: <1242899229-27603-3-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuIFRow6FpIE5n4buNYw==?= Duy"'s message of "Thu\, 21
 May 2009 19\:47\:09 +1000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119687>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  Regression: "-M" is gone. Don't really want to mess up struct option=
 for "-M"

Good riddance ;-).  It's not documented, nor I even knew it existed.
