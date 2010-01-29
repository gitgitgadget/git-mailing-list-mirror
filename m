From: =?UTF-8?B?Wm9sdMOhbiBGw7x6ZXNp?= <zfuzesi@eaglet.hu>
Subject: threaded-grep cause msys build failure
Date: Fri, 29 Jan 2010 11:27:02 +0100
Message-ID: <9ab80d151001290227u386616c5o6c825ff10d37f9fd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git lista <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 29 11:27:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nao4H-0002wO-Qc
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jan 2010 11:27:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753056Ab0A2K1H convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Jan 2010 05:27:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752896Ab0A2K1H
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 05:27:07 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:58782 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751303Ab0A2K1E convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Jan 2010 05:27:04 -0500
Received: by bwz27 with SMTP id 27so1285164bwz.21
        for <git@vger.kernel.org>; Fri, 29 Jan 2010 02:27:03 -0800 (PST)
Received: by 10.204.36.85 with SMTP id s21mr394190bkd.1.1264760822989; Fri, 29 
	Jan 2010 02:27:02 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138307>

Hi,

Building git in msys environment fails:
=2E..
    LINK git.exe
builtin-grep.o: In function `wait_all':
D:\devel\msysgit\git/builtin-grep.c:260: undefined reference to
`pthread_cond_broadcast'
collect2: ld returned 1 exit status
make: *** [git.exe] Error 1

I guess compat/win32/pthread.c misses pthread_cond_broadcast implementa=
tion.

Z=C3=A9
