From: Richard Quadling <rquadling@googlemail.com>
Subject: Heap allocation error in git-1.6.2.4 on Cygwin. Problem not present 
	in git-1.6.1.2
Date: Fri, 22 May 2009 12:23:42 +0100
Message-ID: <10845a340905220423x69eb1718n7a6f9dcd5c2df459@mail.gmail.com>
Reply-To: RQuadling@googlemail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 22 13:24:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M7Src-00057H-P8
	for gcvg-git-2@gmane.org; Fri, 22 May 2009 13:24:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755310AbZEVLYD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2009 07:24:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754762AbZEVLYD
	(ORCPT <rfc822;git-outgoing>); Fri, 22 May 2009 07:24:03 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:50296 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753831AbZEVLYB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 May 2009 07:24:01 -0400
Received: by fxm2 with SMTP id 2so1591158fxm.37
        for <git@vger.kernel.org>; Fri, 22 May 2009 04:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:from:date
         :message-id:subject:to:content-type:content-transfer-encoding;
        bh=yCFweL+5OyM5A3hJNpV5qOzfgaEukilrKmRU8F5OsIY=;
        b=ufoCEIK/EiLAcK6nOOAm0UkfyFQJZB5mMyqlBA1WkufxDKSbYtj+/vPGBsa8ZQcYt+
         f4gO/hJwIflVWJf7iAyOIrvWnVNdUOUJjlJSvCXAOhnxIDAidFXMHWPsRaNvRqUKAsS0
         CanzifQ51hV/yAhXvXS//6s+TAKdeqnx41Jxc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        b=w1cVBwg8XkeBz+YTWz9UMHUPN5RJv1O/Ohe4Gv33lhyJWNPhRR6ufoiA4zZcpX5dAe
         pZ2c4kiGI1OU1A7s0XAdsz8TXq+qvpgHNTKwCPiiYEQI7H8ReH1weiDhZ3Q4EzK97det
         015wQjGVvqD28dJbnY9a6FwzXRZoEZFl9pzGE=
Received: by 10.223.110.4 with SMTP id l4mr2196795fap.47.1242991442075; Fri, 
	22 May 2009 04:24:02 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119726>

Hi.

I've just upgraded GIT on Cygwin from git-1.6.1.2 to git-1.6.2.4.

I'm getting a crash ...

21 [main] git 4620 C:\Cygwin\bin\git.exe: *** fatal error - couldn't
allocate heap, Win32 error 487, base 0x990000, top 0xA10000,
reserve_size 520192, allocsize 524288, page_const 4096

When I kill git.exe, I get ...

17 [unknown (0x1048)] GIT 1824 fork: child -1 - died waiting for
longjmp before initialization, retry 0, exit code 0x1, errno 11


Reverting back to git-1.6.1.2 and the problem does not exist.

Happy to help if given some direction.

Regards,

Richard Quadling.

-- 
-----
Richard Quadling
Zend Certified Engineer : http://zend.com/zce.php?c=ZEND002498&r=213474731
"Standing on the shoulders of some very clever giants!"
