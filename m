From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH v4] Add utf8_fprintf helper which returns correct columns
Date: Fri, 08 Feb 2013 07:13:04 +0100
Message-ID: <51149770.5070303@web.de>
References: <7va9rho350.fsf@alter.siamese.dyndns.org> <4ea03e99bad13e2910b137fd3991951244fa23f1.1360289411.git.worldhello.net@gmail.com> <51149542.8060307@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= <pclouds@gmail.co>,
	Git List <git@vger.kernel.org>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Fri Feb 08 07:13:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3hDK-0002P8-R8
	for gcvg-git-2@plane.gmane.org; Fri, 08 Feb 2013 07:13:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752562Ab3BHGNM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2013 01:13:12 -0500
Received: from mout.web.de ([212.227.17.12]:57354 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750981Ab3BHGNL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2013 01:13:11 -0500
Received: from birne.lan ([195.67.191.23]) by smtp.web.de (mrweb102) with
 ESMTPA (Nemesis) id 0MLxs8-1U0Nor08zs-007rnS; Fri, 08 Feb 2013 07:13:05 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
In-Reply-To: <51149542.8060307@web.de>
X-Provags-ID: V02:K0:pXj8HlA+hYJ9zISFDYxGi4cADfOwq+Z3OpSZmMk97Fp
 pHCZkDi+vdHKHPK7GDlCNAj3C4IVpZitJTFZD9qIInqEeCElLK
 Tsngd5rFK62/mbxRrd2U7ptkrCwxzkeE+DnFaT8tRowFeIOQmF
 ZD+y2JDeKYgRFNxf5njIGbRAmpW6F5lAh/Abrr2nY5GEcUjsfd
 Yb3UQkoci712pA6wJk8mA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215757>

(Sorry for confusing: I should have written:)

Please see below for specifications on fputs()

Linux:
RETURN VALUE
fputc(), putc() and putchar() return the character written as an unsigned char cast to an int or EOF on error.
puts() and fputs() return a nonnegative number on success, or EOF on error.

Mac OS:
COMPATIBILITY
fputs() now returns a non-negative number (as opposed to 0) on successful completion. As a result, many tests (e.g., "fputs() == 0", "fputs() != 0") do not give the desired result.
Use "fputs() != EOF" or "fputs() == EOF" to determine success or failure.

Posix:
RETURN VALUE
Upon successful completion, fputs() shall return a non-negative number. Otherwise, it shall return EOF, set an error indicator for the stream, and set errno to indicate the error.
