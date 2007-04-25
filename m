From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: What's cooking in git.git (topics)
Date: Wed, 25 Apr 2007 10:11:37 +0200
Message-ID: <81b0412b0704250111h6eb0dbefh47867f4dfd7a4ee@mail.gmail.com>
References: <7vodly0xn7.fsf@assigned-by-dhcp.cox.net>
	 <7v647tcjr6.fsf@assigned-by-dhcp.cox.net>
	 <7vejmdq63w.fsf@assigned-by-dhcp.cox.net>
	 <7v647ninbq.fsf@assigned-by-dhcp.cox.net>
	 <81b0412b0704231007i81ee20cx9a37f1c8a3df62b1@mail.gmail.com>
	 <7vvefnf1wb.fsf@assigned-by-dhcp.cox.net>
	 <20070423211658.GA21404@steel.home>
	 <7v4pn6ep41.fsf@assigned-by-dhcp.cox.net>
	 <81b0412b0704240858w6121430fj624582539f14ceee@mail.gmail.com>
	 <7vwt014fib.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Apr 25 10:12:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hgcbv-00071M-9z
	for gcvg-git@gmane.org; Wed, 25 Apr 2007 10:12:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161846AbXDYILl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Apr 2007 04:11:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161844AbXDYILl
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Apr 2007 04:11:41 -0400
Received: from wx-out-0506.google.com ([66.249.82.232]:41455 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161847AbXDYILi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2007 04:11:38 -0400
Received: by wx-out-0506.google.com with SMTP id h31so155472wxd
        for <git@vger.kernel.org>; Wed, 25 Apr 2007 01:11:37 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=e3zu7jPdlcfA4npOvrB+267kR/OTxaQkDxDirF9y7zYZ62JHzYV6nw95bfm2oi8kbA9Qcyy3Al9h/VI2FXs96WPqUtBExjh5AF2ZMfdTgb3Pif6HdFS9Y5aKVWiD4n5rsbic3qf5V/r5lSpMQw5kSM2/nWHIDgEltXpKKDRPGvw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lYPRBFwOGLsHNKaVHw/A0dNEsuBZh8rcdxe3fCxdklClCGULUeCIt/GtmRe01zedpujx9DsYWv78PLkam3fgSw8Y2il/FZL8aRwQw2PfmjtwspKXLDlWmI3niRFgATBF9VrJmEhpvFCkII1yYiX++sc5Si0fHemSaLfgJvzmfug=
Received: by 10.70.40.1 with SMTP id n1mr408978wxn.1177488697901;
        Wed, 25 Apr 2007 01:11:37 -0700 (PDT)
Received: by 10.100.86.19 with HTTP; Wed, 25 Apr 2007 01:11:37 -0700 (PDT)
In-Reply-To: <7vwt014fib.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45508>

On 4/24/07, Junio C Hamano <junkio@cox.net> wrote:
> >> The content filtering is to massage the content into a shape
> >> that is more convenient for the platform/filesystem/the user to
> >> use.  The keyword here is "more convenient" and not "usable"; in
> >
> > how can "not usable" be "more convenient"?
>
> I think I worded it incorrectly to be misunderstood, but I
> couldn't word them better then, I do not know I can word them
> better now.
>

You don't have to. I just can't force myself to believe it can be
made useful. I'll shut up for now, and wait until I or someone else
proves the code has negligible negative impact on the normal
usage scenarios.
