From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 2/2] Make sha1_to_hex thread-safe
Date: Tue, 23 Mar 2010 21:23:59 +0100
Message-ID: <201003232123.59407.j6t@kdbg.org>
References: <20100323161713.3183.57927.stgit@fredrik-laptop> <20100323173130.GC4218@fredrik-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Fredrik Kuivinen <frekui@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 23 21:26:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NuAg1-0001FV-1X
	for gcvg-git-2@lo.gmane.org; Tue, 23 Mar 2010 21:26:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752667Ab0CWU0G convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Mar 2010 16:26:06 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:37757 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752570Ab0CWU0E (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Mar 2010 16:26:04 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 1946FCDF84;
	Tue, 23 Mar 2010 21:25:59 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 78B7719F6B8;
	Tue, 23 Mar 2010 21:23:59 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <20100323173130.GC4218@fredrik-laptop>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143047>

As I said in my previous mail, this is not necessary.

In particular...

On Dienstag, 23. M=E4rz 2010, Fredrik Kuivinen wrote:
> +static pthread_once_t sha1_to_hex_once =3D PTHREAD_ONCE_INIT;

=2E.. please give us a break: Don't force us to pile missing pthreads f=
eatures=20
in our Windows layer.

-- Hannes
