From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH/RFC] svn test: escape peg revision separator using empty
 peg rev
Date: Wed, 10 Oct 2012 14:42:05 -0700
Message-ID: <20121010214205.GD4517@elie.Belkin>
References: <1343468872-72133-1-git-send-email-schwern@pobox.com>
 <1343468872-72133-2-git-send-email-schwern@pobox.com>
 <20120728141652.GA1603@burratino>
 <50143E34.8090802@pobox.com>
 <20121009084145.GA19784@elie.Belkin>
 <5073F2C0.6000504@drmicha.warpmail.net>
 <20121009101953.GB28120@elie.Belkin>
 <20121010203730.GA19115@dcvr.yhbt.net>
 <20121010210218.GB4517@elie.Belkin>
 <20121010213120.GA12935@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Torsten Schmutzler <git-ts@theblacksun.eu>,
	A Large Angry SCM <gitzilla@gmail.com>,
	Michael G Schwern <schwern@pobox.com>, git@vger.kernel.org,
	gitster@pobox.com, robbat2@gentoo.org, bwalton@artsci.utoronto.ca
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Oct 10 23:42:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TM42n-0007BX-UF
	for gcvg-git-2@plane.gmane.org; Wed, 10 Oct 2012 23:42:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754752Ab2JJVmM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2012 17:42:12 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:64650 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752637Ab2JJVmJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2012 17:42:09 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so1151022pbb.19
        for <git@vger.kernel.org>; Wed, 10 Oct 2012 14:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=CsxGziDV7OxiAZ8jF7h6BVbyyp0vQwWiL15HRAg7Kjo=;
        b=yVjt2GC3Dx9rBWXpja9wKnX8r9pcdA9lirEeYYKiPUbV1sS4Q3w07PEyeXpv2JfUaq
         krqs7HybkYwGfGYQSOyVy7njZuU5M/UQtOzxhNPjRsjfRQjBAoQzxkglRSzsrFmACsY2
         KfmQiWBNVMgnnV/GBFqMgT07qJs6GpuEEuC5PAy1Xdr06E0/E7SAQwjnAhNduxJkzhT7
         uorZqFQIsd4fYf8I/3c63rXX0awLB8WsRS9gR7nKFMOnJimQK0zYjKUFzg8id8nFm9uq
         iPdFp0LTxmi+qi/VpIfebTMPlwD2Nnh9BQZy8yB+FBmyvr1CbGTcdXy5dvNVXSgGH3os
         Xwgg==
Received: by 10.66.74.196 with SMTP id w4mr65744240pav.32.1349905329264;
        Wed, 10 Oct 2012 14:42:09 -0700 (PDT)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id tw2sm382876pbc.34.2012.10.10.14.42.07
        (version=SSLv3 cipher=OTHER);
        Wed, 10 Oct 2012 14:42:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20121010213120.GA12935@dcvr.yhbt.net>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207445>

Eric Wong wrote:
> Jonathan Nieder <jrnieder@gmail.com> wrote:

>> -- >8 --
>> Subject: Git::SVN::Editor::T: pass $deletions to ->A and ->D
>
> For future reference, it'd be slightly easier for me to apply if you
> included the From: (and Date:) headers so I don't have to yank+paste
> them myself :>

Ah, I assumed you were using "git am --scissors".  Will do next time.

Jonathan
