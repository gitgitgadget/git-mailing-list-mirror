From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH v2] Add --track option to git clone
Date: Wed, 02 Dec 2009 19:20:28 +0900
Message-ID: <20091202192028.6117@nanako3.lavabit.com>
References: <1259707865-6561-1-git-send-email-sn_@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: David Soria Parra <sn_@gmx.net>
X-From: git-owner@vger.kernel.org Wed Dec 02 11:21:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFmKR-0001tG-Dm
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 11:21:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753346AbZLBKUh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2009 05:20:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753275AbZLBKUh
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 05:20:37 -0500
Received: from karen.lavabit.com ([72.249.41.33]:60308 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753244AbZLBKUf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2009 05:20:35 -0500
Received: from e.earth.lavabit.com (e.earth.lavabit.com [192.168.111.14])
	by karen.lavabit.com (Postfix) with ESMTP id 6629D11B7F0;
	Wed,  2 Dec 2009 04:20:42 -0600 (CST)
Received: from 2268.lavabit.com (212.62.97.23)
	by lavabit.com with ESMTP id WNQ788F8MS12; Wed, 02 Dec 2009 04:20:42 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=5aqj3pTkgD9P0mBjFMBDN4K0S+eiAeQ5nzFzAzwbnUEeQC+1SqZaJ86sAv8eg0Jd1Hj5ut4yfVpSrPWFBhD2DR2Whl1zEanJF2kMtXDcvqQ50h4HnAbeIok1arG3/HgM1hnHtzcP/AeMka+gBWIk+u7gkkdt4w3bZPGLDfAwy88=;
  h=From:To:Cc:Subject:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <1259707865-6561-1-git-send-email-sn_@gmx.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134323>

Quoting David Soria Parra <sn_@gmx.net> writes:

> I'm aware that it's not possible to give more than one --track
> option. Implementing the possibility to specify multiple --track option
> would certainly a good improvment later, but would also require a lot
> more work as far as I understand the clone code.

I'm sorry if I'm asking the obvious, but how can multiple --track 
options be a useful future enhancement? If I understand your use 
case correctly, it's useful when you want to work on only one 
branch that isn't the default, and that is why you don't want to 
get data necessary for other branches. What does it mean to give 
two --track options? You will get one master branch that tracks
both versions, and "git pull" will merge both branches you track?

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
