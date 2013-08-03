From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2] gc: reject if another gc is running, unless --force
 is given
Date: Sat, 03 Aug 2013 11:49:02 +0200
Message-ID: <51FCD20E.8070406@kdbg.org>
References: <1375503605-32480-1-git-send-email-pclouds@gmail.com> <1375510890-4728-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 03 11:49:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V5YSx-0002a5-3l
	for gcvg-git-2@plane.gmane.org; Sat, 03 Aug 2013 11:49:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751377Ab3HCJtZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 3 Aug 2013 05:49:25 -0400
Received: from bsmtp5.bon.at ([195.3.86.187]:13629 "EHLO lbmfmo03.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751353Ab3HCJtZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Aug 2013 05:49:25 -0400
Received: from bsmtp.bon.at (unknown [192.168.181.102])
	by lbmfmo03.bon.at (Postfix) with ESMTP id 6CA25CE259
	for <git@vger.kernel.org>; Sat,  3 Aug 2013 11:49:23 +0200 (CEST)
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 1A2B3A7EB2;
	Sat,  3 Aug 2013 11:49:03 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 2EACB19F5DD;
	Sat,  3 Aug 2013 11:49:03 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <1375510890-4728-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231572>

Am 03.08.2013 08:21, schrieb Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy:
>  I changed mingw.h to add a stub uname() because I don't think MinGW
>  port has that function, but that's totally untested.

Thanks, but we don't have kill(pid, 0), either :-(

-- Hannes
