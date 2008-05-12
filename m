From: bill lam <cbill.lam@gmail.com>
Subject: how to backup git
Date: Mon, 12 May 2008 14:08:54 +0800
Message-ID: <4827DEF6.1050005@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 12 08:10:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvREn-0008FB-Ih
	for gcvg-git-2@gmane.org; Mon, 12 May 2008 08:10:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753964AbYELGJD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 02:09:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753961AbYELGJB
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 02:09:01 -0400
Received: from wa-out-1112.google.com ([209.85.146.181]:8112 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753817AbYELGJB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 02:09:01 -0400
Received: by wa-out-1112.google.com with SMTP id j37so3291026waf.23
        for <git@vger.kernel.org>; Sun, 11 May 2008 23:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        bh=pHliZ73MWjYvfkJ9v9b77EY67+MVZJaRvvb4PDPf8ac=;
        b=xmDlEeJxAvl+tCxne8abFUk2EwfOmMmTEHI3J0+tGAH2/nZD6ijtPKM7pw4leUF9QcVNhwhKuaiVN9JwusB3tASzgTD2IZvS3/BDarbVO9rcGEBNFdt1D2tyLGK/o/NO6FN1W8TlfKkCuze4joD9jbT0ZITo9OCo3VlykZ0cCbk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=HqUDHsaDNAIQpqAVCn7YYSKvQP5Q3Jd8/L6RZR6Gxc8OuLpc1K3Bw0IyKW0siikD+5HwGd7i59YZiPfOsR5BzWGbwG/WNk6uAn1ZKDMYpbLZvoDKpgXl/YiAt16d+VYdKrpLYFWf2+wFjwimD4iwIMXka56CEgcyLqx342x+tp0=
Received: by 10.115.79.1 with SMTP id g1mr7229460wal.43.1210572540720;
        Sun, 11 May 2008 23:09:00 -0700 (PDT)
Received: from ?192.168.1.201? ( [218.103.237.146])
        by mx.google.com with ESMTPS id a8sm14809094poa.12.2008.05.11.23.08.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 11 May 2008 23:08:59 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (X11/20080505)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81834>

Hello, this should be a simple question. How to backup a git repository but 
excluding files that not under versioned?  If I cp or tar or rsync the 
directory. All non-versioned files are added.

regards,
