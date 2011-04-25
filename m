From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Cloning into an existing, non-empty directory?
Date: Mon, 25 Apr 2011 03:59:13 -0500
Message-ID: <20110425085913.GB28885@elie>
References: <BANLkTi=VwiqN99AMEJb6jb1uFya2Hipibw@mail.gmail.com>
 <20110421220327.GA3396@elie>
 <BANLkTikY7c7rP+yv5vt2vxw5nu84k_H=Xw@mail.gmail.com>
 <20110423101500.GB1500@elie>
 <BANLkTinV4cFC5vzr25V-D3PMwWx284zgoQ@mail.gmail.com>
 <20110425075750.GA28172@elie>
 <m2pqoa9121.fsf@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Richard Hartmann <richih.mailinglist@gmail.com>,
	Git List <git@vger.kernel.org>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Mon Apr 25 10:59:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEHdc-0000ec-1e
	for gcvg-git-2@lo.gmane.org; Mon, 25 Apr 2011 10:59:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758139Ab1DYI7T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2011 04:59:19 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:43275 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758135Ab1DYI7S (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2011 04:59:18 -0400
Received: by iyb14 with SMTP id 14so1704037iyb.19
        for <git@vger.kernel.org>; Mon, 25 Apr 2011 01:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=UM/kcxG1zILSPgpksFZmWXG4m47INAZxsGMib09LK04=;
        b=xMw8J7WQv1aKr/FviKe8ZKJ6F+bX76SwGbzkKAzK96VUQ2JUBaD7sjnDBeWyVxuP/d
         PBuE4NMCVvUqAhcB6J4ZdAxmIFMgytqApdVX/NJaSBJDkSmchLhisi7BnrZTbxQLg3sd
         J5t6HNVyPFPZ8L1JJcKw/ABueR1Erh4fxC8mg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=l5is4TKKc9XsbO1UH9CPyp0Ospdgut7f6Raz5m7Crnsx4la+OX2WJSY5IuQuNLEwgr
         AhOrHKlUTGgdoj1iEg2MFlPHVIPcsupycsje345CK3iOrj0+LFXisK4a9vFeI/SyR0DJ
         +b+Ta6ToGsqYGHY2PF3FaL0oVECvdyvqCmLE8=
Received: by 10.42.133.1 with SMTP id f1mr4657913ict.129.1303721958048;
        Mon, 25 Apr 2011 01:59:18 -0700 (PDT)
Received: from elie (adsl-68-255-96-190.dsl.chcgil.ameritech.net [68.255.96.190])
        by mx.google.com with ESMTPS id ww2sm1978839icb.3.2011.04.25.01.59.16
        (version=SSLv3 cipher=OTHER);
        Mon, 25 Apr 2011 01:59:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <m2pqoa9121.fsf@linux-m68k.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172019>

Andreas Schwab wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> I'm not sure what a good meaning for "git merge <repository>" would
>> be.
>
> It's equivalent to refs/remotes/<repository>/HEAD if that exists.

Ah, I should have checked gitrevisions(7).  Thank you.

Jonathan
who wonders where his origin/HEAD symref came from and if
"git remote set-head --auto origin" was ever automatic
