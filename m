From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [RFC/PATCH] MSVC: Windows-native implementation of pthread_cond_broadcast
Date: Fri, 29 Jan 2010 21:02:49 +0100
Message-ID: <201001292102.49105.j6t@kdbg.org>
References: <4B62CEAB.5050608@viscovery.net> <1264793213-8805-1-git-send-email-zfuzesi@eaglet.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?q?Zolt=C3=A1n_F=C3=BCzesi?= <zfuzesi@eaglet.hu>
X-From: git-owner@vger.kernel.org Fri Jan 29 21:04:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nax4h-0000re-Cx
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jan 2010 21:04:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754662Ab0A2UEJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Jan 2010 15:04:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754067Ab0A2UEI
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 15:04:08 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:60119 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754469Ab0A2UEH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2010 15:04:07 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 3321CA7EB7;
	Fri, 29 Jan 2010 21:04:01 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 2F37119F609;
	Fri, 29 Jan 2010 21:02:49 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <1264793213-8805-1-git-send-email-zfuzesi@eaglet.hu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138343>

On Freitag, 29. Januar 2010, Zolt=C3=A1n F=C3=BCzesi wrote:
> Johannes, how about this? I haven't tested it.

Neither have I, but I do not expect that it work: You neither modify th=
e=20
waiters count nor do you wait for it to be modified; IOW, you have a bu=
sy=20
loop. cond_broadcast is not that trivial. I hope to send a patch tonigh=
t.

-- Hannes
