From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diff: don't run pager if user asked for a diff style exit code
Date: Mon, 13 Aug 2007 16:42:33 -0700
Message-ID: <7v7inzf1cm.fsf@assigned-by-dhcp.cox.net>
References: <17875.88.10.191.55.1186873960.squirrel@secure.wincent.com>
	<46BF478F.7030603@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Wincent Colaiuta <win@wincent.com>, git@vger.kernel.org
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Tue Aug 14 01:43:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKjZ7-0007Jv-PW
	for gcvg-git@gmane.org; Tue, 14 Aug 2007 01:43:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758386AbXHMXnN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 13 Aug 2007 19:43:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760872AbXHMXnN
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Aug 2007 19:43:13 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:57986 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758386AbXHMXnM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Aug 2007 19:43:12 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070813234237.IUDF7956.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Mon, 13 Aug 2007 19:42:37 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id bbib1X0011kojtg0000000; Mon, 13 Aug 2007 19:42:35 -0400
In-Reply-To: <46BF478F.7030603@lsrfire.ath.cx> (=?utf-8?Q?Ren=C3=A9?=
 Scharfe's message of
	"Sun, 12 Aug 2007 19:46:55 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55795>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> As Wincent Colaiuta found out, it's a bit unexpected for git diff to
> start a pager even when the --quiet option is specified.  The problem
> is that the pager hides the return code -- which is the only output
> we're interested in in this case.
>
> Push pager setup down into builtin-diff.c and don't start the pager
> if --exit-code or --quiet (which implies --exit-code) was specified.

Surprisingly nice, although I would have said "don't use
git-diff wrapper from scripts, use underlying diff-* plumbing"
;-).

Thanks.
