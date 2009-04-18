From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [RFC/PATCH] rev-list: embed "struct rev_info revs" into "struct rev_list_info"
Date: Sat, 18 Apr 2009 19:11:25 +0900
Message-ID: <20090418191125.6117@nanako3.lavabit.com>
References: <20090418064328.ad64accf.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Paolo Bonzini <bonzini@gnu.org>, git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sat Apr 18 12:13:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lv7YL-0001NW-97
	for gcvg-git-2@gmane.org; Sat, 18 Apr 2009 12:13:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753449AbZDRKMH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Apr 2009 06:12:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753068AbZDRKMH
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Apr 2009 06:12:07 -0400
Received: from karen.lavabit.com ([72.249.41.33]:33647 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752665AbZDRKMF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Apr 2009 06:12:05 -0400
Received: from c.earth.lavabit.com (c.earth.lavabit.com [192.168.111.12])
	by karen.lavabit.com (Postfix) with ESMTP id 994AF11B7EC;
	Sat, 18 Apr 2009 05:12:04 -0500 (CDT)
Received: from 2162.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id M8CB2IZQQUPM; Sat, 18 Apr 2009 05:12:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=Kt2lU0EOqrenzs3IGzCcGlBkaTohDfPmiQZ43faGY+eNt1o6/LT0b1u9v3OGh6+57szHFNH6SBwuAjA3pgZKa+vzkyh9K2Qyq1UkfSDKF5s7HIb5gyc8zOmyizPRIereebB9189Oq70aZcBatAJUEz6f1S5Cav0spuBcRK74tG4=;
  h=From:To:Cc:Subject:In-Reply-To:References:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <20090418064328.ad64accf.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116821>

Quoting Christian Couder <chriscool@tuxfamily.org>:

> There are downsides to this patch. First it is big. And "revs" is
> initialized once when doing "memset(&info, 0, sizeof(info))" and
> once in "init_revisions".

I'm sorry if it is obvious, but is there any upsides?

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
