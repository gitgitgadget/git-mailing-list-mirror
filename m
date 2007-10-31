From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: remote#branch
Date: Wed, 31 Oct 2007 02:49:16 +0100
Message-ID: <200710310249.17233.jnareb@gmail.com>
References: <20071030053732.GA16963@hermes.priv> <fg8h9l$b4n$1@ger.gmane.org> <20071031013856.GA23274@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 31 02:49:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1In2iG-0001Jb-2W
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 02:49:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751905AbXJaBta (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 21:49:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751781AbXJaBta
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 21:49:30 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:11081 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751122AbXJaBt3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2007 21:49:29 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1812521nfb
        for <git@vger.kernel.org>; Tue, 30 Oct 2007 18:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=TO/C9NZIjEyHSVge2qF42nydo2zv3y83jq5JAkdl1Rw=;
        b=RlI5+MKsQweanC1x7nNlIGfVyDTQWjj/CC8lxl0qlAJR4C7w/8g0C8WNESMKgqiwIW2cAdqSBCjPLQsDyurfFNphKIfC+JyuGNsb2Xg9HkLy9hFi9Dg1j8t64eUJ1vck+8Tj1aHoKekPSyXW02kD2WnuRjV+2KXhMW//BUpYew4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=pMsBLJO4uLl8zpRs2x6WvNVjV2XEYEnF83L3q+aUGLi6ET/AGcVP1RJH9sz2vGx7niAOpkgRK019YUKKt9GieVK+1Lh8PFl4xz+YpQp2Zg8AlxFvT4r6vzyMq/mKmfEkCBu2eHoXGE1M7Wiuw5rRl/CZPrOTVXbu3KOHoe2jXcQ=
Received: by 10.78.147.6 with SMTP id u6mr5758749hud.1193795367233;
        Tue, 30 Oct 2007 18:49:27 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.221.204])
        by mx.google.com with ESMTPS id 31sm3573986nfu.2007.10.30.18.49.24
        (version=SSLv3 cipher=OTHER);
        Tue, 30 Oct 2007 18:49:25 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20071031013856.GA23274@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62775>

Jeff King wrote:
> On Wed, Oct 31, 2007 at 01:12:37AM +0100, Jakub Narebski wrote:
> 
>>> that they are machine parseable. If you wanted to write a tool to pick
>>> the URLs out of this email and clone them as git repos, then how do you
>>> find the end of:
>>> 
>>>   http://host/git repo with spaces in the path
>>
>> You use
>> 
>>   'http://host/git repo with spaces in the path'
> 
> ...which is a quoting mechanism, and it's not even one commonly used in
> emails (i.e., people have written "parse a URL from this text" scripts
> for RFC-encoded URLs, but _not_ for shell quoting).

I don't think RFC-encoding is quoting mechanism used in emails, either.

-- 
Jakub Narebski
Poland
