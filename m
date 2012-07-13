From: Edward Toroshchin <edward.hades@gmail.com>
Subject: Re: Don't share anything but those files
Date: Fri, 13 Jul 2012 17:21:27 +0200
Message-ID: <20120713152127.GC17521@phobos.chilli.itwm.local>
References: <500037EB.5030408@modusfx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Yves Perron <yves.perron@modusfx.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 13 17:21:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SphgX-00084Z-R3
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jul 2012 17:21:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422659Ab2GMPVc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jul 2012 11:21:32 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:34537 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755669Ab2GMPVc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jul 2012 11:21:32 -0400
Received: by wgbdr13 with SMTP id dr13so3294810wgb.1
        for <git@vger.kernel.org>; Fri, 13 Jul 2012 08:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=D2++sIypgyHoo/X/juwWVmF9HTWemR8L3Y9yBD5CQMs=;
        b=Uipr2js53VodhKSzHBzxw+ArGuvLXkvPwn55dwIoXCP4vUWHq3KUjMLOMt5EwXJnU+
         ybjckpOcQa4r1RgyS6G9Km+rpREXOYGxPGBX7onAbvKtcy8mIiY1lgqCyYZmBo2o0QEn
         ret6kYrezMR8El+E1mWu+idSOB+FzQmyPQb/ORnYKYHClPobnNHgmTSE8qE2Xg1l3DRU
         dgOA7J6zmFRwpVSbE2nAnyx5CaW0THssIoIUkRepK37Yxjl/Nv/WC0RCWmI8XQn48NzI
         BFu0YNHQvn4d9q3lxAWiBlsLBuJ88U6GdzEGt0RxhAcCQaq/BURvmo3RvEpsx8j0HLdq
         FzdA==
Received: by 10.180.107.103 with SMTP id hb7mr3563160wib.3.1342192890349;
        Fri, 13 Jul 2012 08:21:30 -0700 (PDT)
Received: from localhost (ganymede.hades.name. [81.17.21.251])
        by mx.google.com with ESMTPS id fr4sm5788433wib.8.2012.07.13.08.21.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 13 Jul 2012 08:21:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <500037EB.5030408@modusfx.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201407>

On Fri, Jul 13, 2012 at 10:59:55AM -0400, Yves Perron wrote:
> I'm wondering how to commit only selected files/folders on GIT, if even 
> possible.

Just "git add" only the files you need.

If you want git to ignore all the rest, you can write '*' in your
.gitignore

-- 
Edward "Hades" Toroshchin
dr_lepper on irc.freenode.org
