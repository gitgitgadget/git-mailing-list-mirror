From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] Windows: Remove dependency on pthreadGC2.dll
Date: Sun, 24 Jan 2010 20:03:33 +0100
Organization: 
Message-ID: <201001242003.33703.j6t@kdbg.org>
References: <1264327830-4204-1-git-send-email-michael.lukashov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Andrzej K. Haczewski" <ahaczewski@gmail.com>
To: Michael Lukashov <michael.lukashov@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 24 20:04:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZ7lQ-00033B-1Z
	for gcvg-git-2@lo.gmane.org; Sun, 24 Jan 2010 20:04:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752619Ab0AXTEn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jan 2010 14:04:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751702Ab0AXTEn
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jan 2010 14:04:43 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:48497 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751127Ab0AXTEm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jan 2010 14:04:42 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id C3F4BA7EDA;
	Sun, 24 Jan 2010 20:04:39 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id C87AC19F5EC;
	Sun, 24 Jan 2010 20:03:33 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <1264327830-4204-1-git-send-email-michael.lukashov@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137910>

On Sonntag, 24. Januar 2010, Michael Lukashov wrote:
> Commit 44626dc7 (MSVC: Windows-native implementation for subset
> of threads API, 2010-01-15) introduces builtin replacement of
> pthreadGC2.dll functionality, thus we can completely drop
> dependency on this dll.

Duh! This means that when I tested above-mentioned patch, I actually was using 
pthread.h from msysgit instead of compat/win32/pthread.h, and didn't test it 
at all (note: MinGW version; MSVC was fine because it had the right includes 
all the time). This patch passes the test suite and a 'git gc --aggressive':

Acked-by: Johannes Sixt <j6t@kdbg.org>

-- Hannes
