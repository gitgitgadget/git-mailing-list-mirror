From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: RFE: "git bisect reverse"
Date: Wed, 27 May 2009 17:22:33 +0900
Message-ID: <20090527172233.6117@nanako3.lavabit.com>
References: <4A1C6B70.4050501@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Git Mailing List <git@vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Wed May 27 10:23:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9EPi-0005oo-ET
	for gcvg-git-2@gmane.org; Wed, 27 May 2009 10:23:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757491AbZE0IW5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2009 04:22:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758865AbZE0IW5
	(ORCPT <rfc822;git-outgoing>); Wed, 27 May 2009 04:22:57 -0400
Received: from karen.lavabit.com ([72.249.41.33]:54436 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755537AbZE0IW4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2009 04:22:56 -0400
Received: from b.earth.lavabit.com (b.earth.lavabit.com [192.168.111.11])
	by karen.lavabit.com (Postfix) with ESMTP id 3D09911B804;
	Wed, 27 May 2009 03:22:57 -0500 (CDT)
Received: from 4022.lavabit.com (212.62.97.20)
	by lavabit.com with ESMTP id 3G2D4KBQBRA3; Wed, 27 May 2009 03:22:57 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=hJyzHK7wSgQS1K233NjPLTwa6ZevPIlQ4BSceVZ39O7enbR0R9jtKMl6ZwCBiNFARCt89ZFGcuG9o9iAXLCO+Oww5ijBgL5sWxPsA+9iYc6IedGIu5qgwX8Iev0TTbUYuGI2CKleYNL3iEu5PFSx4oroIL0CrS4TVyoOV+V2FE0=;
  h=From:To:Cc:Subject:In-Reply-To:References:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <4A1C6B70.4050501@zytor.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120048>

Quoting "H. Peter Anvin" <hpa@zytor.com>:

> I would like to request the following feature:
>
> "git bisect reverse"
>
> ... does exactly the same thing as "git bisect start", except that it
> flips the meaning of "good" and "bad".  It is mentally fairly taxing to
> do a reverse bisection (looking for an antiregression) when one has to
> flip the meaning of "good" and "bad" (which are very loaded words to our
> psyche), and it's even worse to try to get a user to do it...

There was a discussion on "fixed" and "unfixed" aliases to find a commit that fixed an old breakage.

  http://thread.gmane.org/gmane.comp.version-control.git/86063/focus=86563

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
