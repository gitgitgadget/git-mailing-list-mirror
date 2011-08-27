From: seanh <snhmnd@gmail.com>
Subject: Re: Files that cannot be added to the index
Date: Sat, 27 Aug 2011 17:39:42 +0200
Message-ID: <20110827153942.GB291@sooty-2.local>
References: <CAMvu5bLuRWinMYNc4NoRKQKiLCWLcwkpowEFT4GQ0mcJYj6eOg@mail.gmail.com>
 <4E57A93A.6090405@drmicha.warpmail.net>
 <20110826205919.GB8107@sooty-2.local>
 <20110826211233.GB3093@digium.com>
 <20110827060718.GA28136@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 27 17:39:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QxKzA-0002Ow-Nw
	for gcvg-git-2@lo.gmane.org; Sat, 27 Aug 2011 17:39:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751018Ab1H0Pjs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Aug 2011 11:39:48 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:49053 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750882Ab1H0Pjr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Aug 2011 11:39:47 -0400
Received: by fxh19 with SMTP id 19so3277098fxh.19
        for <git@vger.kernel.org>; Sat, 27 Aug 2011 08:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=dFhwAOQSjS35XHCMt774O7JT9AiZS9i6tw6X7xzMA7s=;
        b=SllX+D/Vw+vm3BJmBjlkBge7pWsswdCYD+lU81+ZKBQjESltGegPkhHsatf/Itm8h7
         7QQYSAOON41MDKCyeecnoQ7XK94Oi4btsHb5211DC1HQWQXU9vLeYbq3MUib0s+1YZx6
         TslyP1bgECcoX6vbtUVXaPkF5oiEX4G70yZWA=
Received: by 10.223.98.130 with SMTP id q2mr3610655fan.137.1314459586755;
        Sat, 27 Aug 2011 08:39:46 -0700 (PDT)
Received: from sooty-2.local (brln-4dbabee1.pool.mediaWays.net [77.186.190.225])
        by mx.google.com with ESMTPS id p11sm2225589faa.22.2011.08.27.08.39.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 27 Aug 2011 08:39:45 -0700 (PDT)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20110827060718.GA28136@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180234>

On Sat, Aug 27, 2011 at 02:07:18AM -0400, Jeff King wrote:
> I think both of you may be seeing the same bug I tracked down here:
> 
>   http://thread.gmane.org/gmane.comp.version-control.git/173612/focus=174634

I don't think it's the same problem. For me the problem does not occur
with any git repo, only with two repos in particular. Also, the output
is not different every time, there are two files in particular that
always show up with phantom modifications in git status and git diff.
