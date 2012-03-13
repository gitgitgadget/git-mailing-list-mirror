From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] git-am: error out when seeing -b/--binary
Date: Tue, 13 Mar 2012 10:42:09 -0500
Message-ID: <20120313154209.GC1978@burratino>
References: <20120312152004.GB9380@kroah.com>
 <20120312152453.GB12405@1wt.eu>
 <87aa3l4vqq.fsf@thomas.inf.ethz.ch>
 <20120312165703.GB18791@burratino>
 <7vvcm9snko.fsf@alter.siamese.dyndns.org>
 <87399dpk48.fsf@thomas.inf.ethz.ch>
 <20120312215607.GB11362@burratino>
 <874ntto4t8.fsf@thomas.inf.ethz.ch>
 <20120312222227.GC11362@burratino>
 <87fwdcldqj.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Mar 13 16:42:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7Tre-0003FU-PK
	for gcvg-git-2@plane.gmane.org; Tue, 13 Mar 2012 16:42:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755934Ab2CMPmN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Mar 2012 11:42:13 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:33539 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753073Ab2CMPmM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2012 11:42:12 -0400
Received: by yhmm54 with SMTP id m54so672722yhm.19
        for <git@vger.kernel.org>; Tue, 13 Mar 2012 08:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=cigvJnb74F4oH6CJ0AP65mXyS+KejQqdwAY9Q65oRgI=;
        b=CcZglraMzTT02luDnyjqMyh0/zhS0JVF14K5ArWyS26OPx8HV3kcoeCxM/Zzs6ZnZE
         w2tefcBCDj2BCZ+QfRnGvrHNBUvOLMcoJJxUlxB6C6Xx09lruvlCenXXbLpcFGeGAXXR
         9/EM2LFU3UnzWhPuiCdAQvuXWRuUOAw2frSoWgWcAClXJKYv5c0ejgVE/6P6hvXEXm0A
         FlzXcvdEse9CGH9VyUufkWi1yV2M+W0KXIb0Eucnc3y69MnEiFnyNA71UGY6rmowtCTW
         h55Pgt9KFF+R3J9lNb8bUA+BiFkvj1mIEN35jFH89MuTrojWPJw2H2nOYoBv8Eq0dCg1
         XenA==
Received: by 10.182.231.41 with SMTP id td9mr12341183obc.22.1331653332097;
        Tue, 13 Mar 2012 08:42:12 -0700 (PDT)
Received: from burratino (remote.soliantconsulting.com. [67.109.75.130])
        by mx.google.com with ESMTPS id n1sm1299376obm.11.2012.03.13.08.42.11
        (version=SSLv3 cipher=OTHER);
        Tue, 13 Mar 2012 08:42:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <87fwdcldqj.fsf@thomas.inf.ethz.ch>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193036>

(resetting cc list)
Thomas Rast wrote:

> Hmm, I had an alternate patch ready in the morning, but Junio beat us to
> it and applied the old one to master.
>
> I don't really think it matters enough to apply *another*, so I'll leave
> it at that.

May I have a copy?  If it makes the wording better somehow, I would be
happy to do the work of making a patch on top of master using it.
