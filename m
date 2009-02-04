From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/2] add test-dump-cache-tree in Makefile
Date: Wed, 04 Feb 2009 01:31:32 -0800 (PST)
Message-ID: <m34ozawnte.fsf@localhost.localdomain>
References: <1233781241-721-1-git-send-email-guanqun.lu@gmail.com>
	<1233781241-721-2-git-send-email-guanqun.lu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Guanqun Lu <guanqun.lu@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 04 10:33:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUe7z-0000IC-7r
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 10:33:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751274AbZBDJbg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 04:31:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751234AbZBDJbg
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 04:31:36 -0500
Received: from fg-out-1718.google.com ([72.14.220.157]:62256 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750990AbZBDJbf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 04:31:35 -0500
Received: by fg-out-1718.google.com with SMTP id 16so1159288fgg.17
        for <git@vger.kernel.org>; Wed, 04 Feb 2009 01:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=bfNI2bL7bTBp1OMz8sqOU2XnqHwnU3hogyJ0IcrfR8g=;
        b=k1DXwPJUWkOXoQJjKpZ090PPqQpvuW0aNm1G8pfvBS+skA62VuoRLuKqkBm3zL5vBs
         8SV4jM8eCIzA12uyRWKuYsvYQw4D60MlgETwEzJlnteXofzjBoQe/qg2x6dKgZ09G3CD
         Qq3Zd2xHLEZjdV5B+lk7314Hb0pzjIXnCO36o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=u5Gjbqc4pcPhIbsklnk1Z3W9orn3fiQVkVc3dyU7aCB/5jfYfaAFrW8JyZlOhCKc5J
         Z2GuV6o4Ce9QoMjfk2+Sey4OjawY4JVFFiA64VAfqRuCMVO2EtjfClEeXvH0/P2hu2D7
         Z8RCiiD9CdD8oRTxY86ApN2XCQjKSOtMoLma8=
Received: by 10.86.61.13 with SMTP id j13mr329252fga.59.1233739893096;
        Wed, 04 Feb 2009 01:31:33 -0800 (PST)
Received: from localhost.localdomain (abvm245.neoplus.adsl.tpnet.pl [83.8.210.245])
        by mx.google.com with ESMTPS id 4sm942085fge.54.2009.02.04.01.31.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 04 Feb 2009 01:31:32 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n149VTMh029949;
	Wed, 4 Feb 2009 10:31:30 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n149VP9L029946;
	Wed, 4 Feb 2009 10:31:25 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1233781241-721-2-git-send-email-guanqun.lu@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108325>

Guanqun Lu <guanqun.lu@gmail.com> writes:

>  dump-cache-tree.c      |   64 ------------------------------------------------
>  test-dump-cache-tree.c |   64 ++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 65 insertions(+), 64 deletions(-)
>  delete mode 100644 dump-cache-tree.c
>  create mode 100644 test-dump-cache-tree.c

> diff --git a/dump-cache-tree.c b/dump-cache-tree.c
> deleted file mode 100644
> index 1f73f1e..0000000

> diff --git a/test-dump-cache-tree.c b/test-dump-cache-tree.c
> new file mode 100644
> index 0000000..1f73f1e

Minor nit: it would be better to use git-format-patch with '-M' option
(detect renames) here.  It would result in shorter and more readable
patch:

 dump-cache-tree.c => test-dump-cache-tree.c |  0
 3 files changed, 1 insertions(+), 0 deletions(-)
 rename dump-cache-tree.c => test-dump-cache-tree.c (100%)

diff --git a/dump-cache-tree.c b/test-dump-cache-tree.c
similarity index 100%
rename from dump-cache-tree.c
rename to test-dump-cache-tree.c

Or something like that...
-- 
Jakub Narebski
Poland
ShadeHawk on #git
