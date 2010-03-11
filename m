From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 7/6] Enable threaded async procedures whenever pthreads is available
Date: Thu, 11 Mar 2010 20:53:07 +0100
Message-ID: <201003112053.07260.j6t@kdbg.org>
References: <cover.1267889072.git.j6t@kdbg.org> <201003092100.36616.j6t@kdbg.org> <7v7hpjq0aw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 11 20:55:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NpoTN-0004ik-JE
	for gcvg-git-2@lo.gmane.org; Thu, 11 Mar 2010 20:55:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751615Ab0CKTzB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Mar 2010 14:55:01 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:20257 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751170Ab0CKTzA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Mar 2010 14:55:00 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 99B17CDF86;
	Thu, 11 Mar 2010 20:54:55 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 81A6C19F5F2;
	Thu, 11 Mar 2010 20:53:07 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <7v7hpjq0aw.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141993>

On Mittwoch, 10. M=C3=A4rz 2010, Junio C Hamano wrote:
> Will queue in 'pu', but as Shawn said, we should probably give anothe=
r
> closer look at the callees that are started with this interface befor=
e
> moving forward.

I'll audit the call paths. But I'll need some time for this.

-- Hannes
