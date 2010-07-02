From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] Bugfix: grep: Do not colorize output when -O is set
Date: Fri, 02 Jul 2010 18:19:17 +0200
Message-ID: <4C2E1185.1040406@lsrfire.ath.cx>
References: <1278064941-30689-1-git-send-email-ayiehere@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git@vger.kernel.org, johannes.schindelin@gmx.de,
	jrnieder@gmail.com
To: Nazri Ramliy <ayiehere@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 02 18:19:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUixm-0004Uv-OJ
	for gcvg-git-2@lo.gmane.org; Fri, 02 Jul 2010 18:19:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758948Ab0GBQTd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Jul 2010 12:19:33 -0400
Received: from india601.server4you.de ([85.25.151.105]:53974 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757187Ab0GBQTc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jul 2010 12:19:32 -0400
Received: from [10.0.1.100] (p57B7E7AC.dip.t-dialin.net [87.183.231.172])
	by india601.server4you.de (Postfix) with ESMTPSA id 89E072F80D6;
	Fri,  2 Jul 2010 18:19:30 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.2.4) Gecko/20100608 Thunderbird/3.1
In-Reply-To: <1278064941-30689-1-git-send-email-ayiehere@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150140>

Am 02.07.2010 12:02, schrieb Nazri Ramliy:
> When color.ui is set to auto, "git grep -Ovi foo" breaks due to the
> presence of color escape sequences.

Hmm, but with --open-files-in-pager without argument or -Oless colours
may be handled correctly and desirable.  Turning colouring off with -O
is probably the most sensible default, but is it possible to allow
turning it back on explicitly (--color -O)?

Ren=E9
