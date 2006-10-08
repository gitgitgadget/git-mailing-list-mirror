From: Jiri Slaby <jirislaby@gmail.com>
Subject: git-tar-tree & NEEDS_PREFIX
Date: Sun, 08 Oct 2006 15:09:42 +0159
Message-ID: <4528F8AD.2040307@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Oct 08 15:10:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GWYPj-0005zA-F6
	for gcvg-git@gmane.org; Sun, 08 Oct 2006 15:09:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134AbWJHNJw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Oct 2006 09:09:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751136AbWJHNJw
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Oct 2006 09:09:52 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:43455 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751134AbWJHNJv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Oct 2006 09:09:51 -0400
Received: by ug-out-1314.google.com with SMTP id o38so485109ugd
        for <git@vger.kernel.org>; Sun, 08 Oct 2006 06:09:50 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=oZrvw3myW1eQ318Xw22cl2/PdDiujwlpx7tseTWLWMcFMSEGpF/Nm/4/p6z+1r5tHsEdNxYtt6bjM7o+y9WCKNCSbxn6+60UHhS08XuuxO/Ls+8fUssX4DoWVPLTzoxTVSN98gZrkYlUjV44X8W4IAyf+9JXyEZcZmeL5dd8eAs=
Received: by 10.67.24.13 with SMTP id b13mr5568234ugj;
        Sun, 08 Oct 2006 06:09:50 -0700 (PDT)
Received: from ?192.168.1.129? ( [212.80.64.118])
        by mx.google.com with ESMTP id e34sm451462ugd.2006.10.08.06.09.49;
        Sun, 08 Oct 2006 06:09:49 -0700 (PDT)
User-Agent: Thunderbird 2.0a1 (X11/20060724)
To: git-list <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28535>

Hi,

is there any good reason to have NEEDS_PREFIX flag for git-tar-tree builtin?

I can't do --remote= tar-ing, but when I remove this flag from git.c, it seems 
to work correctly (prefix seems not to be used in any way).

regards,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
