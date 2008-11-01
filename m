From: Gonsolo <gonsolo@gmail.com>
Subject: Git remote status
Date: Sat, 01 Nov 2008 20:52:48 +0100
Message-ID: <490CB390.9000206@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 01 20:54:09 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwMXw-0005U9-EO
	for gcvg-git-2@gmane.org; Sat, 01 Nov 2008 20:54:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752218AbYKATwy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Nov 2008 15:52:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752182AbYKATwy
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Nov 2008 15:52:54 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:16363 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752047AbYKATwy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Nov 2008 15:52:54 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1484909fgg.17
        for <git@vger.kernel.org>; Sat, 01 Nov 2008 12:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=lGMzBSjCqYn5FNGDSlWSuJVUZeHwQ5mD9gtELunA2Fo=;
        b=L3XOX14fY7KI1TFum/RBr+Bd2/GqQLpd/ROw+0ibIrU3+oqSXwAByk2BN8Z8nhTScV
         jD7Tz2FGSuTCwynDy1g5ekx7IaLewiEsht7B8MRkVtLLyRjOcHqAfOtwugI1Zz9YqBcM
         JWAiGA8FmO3mz0ctc5DdNYmmBFdlUnLQ8aSkc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=JDyqZJXdL8WJSDw2Oui8eJllon6TIjwhH3xMHyC7xuzG7Pp2eAA737yI47qGW1PG+r
         zrmF3Bb+Gw+YeWgGnd9lzIGypC+rlc+GbRblyD1Yyp7Y4QzP/wAdotpuOkdEMbMg5+F6
         DbKr4QfCvaMF608hVIDrmo5F2HXzd8AesIpEM=
Received: by 10.86.58.3 with SMTP id g3mr9524642fga.77.1225569171481;
        Sat, 01 Nov 2008 12:52:51 -0700 (PDT)
Received: from ?192.168.2.100? (p54BD7E81.dip.t-dialin.net [84.189.126.129])
        by mx.google.com with ESMTPS id 4sm6547915fge.8.2008.11.01.12.52.50
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 01 Nov 2008 12:52:50 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.17 (X11/20080925)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99765>

Hi!

If I switch branches with "git checkout master" git tells me something 
like "Your branch is ahead of the tracked remote branch 'origin/master' 
by 39 commits".
Is there a "git remote status" or git-status switch to get the same 
information without switching branches?
Sometimes it's valuable whether one should push changes (for example 
before installing a new Ubuntu version ;) ).

Thank you,

g
