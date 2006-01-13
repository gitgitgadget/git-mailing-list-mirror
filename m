From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [PATCH] show-branch: make --topo-order noop and default.
Date: Thu, 12 Jan 2006 21:28:21 -0800
Message-ID: <43C73A75.6020007@gmail.com>
References: <7v4q4ajonx.fsf@assigned-by-dhcp.cox.net>	<43C70F69.7010103@gmail.com> <7vslrsg41g.fsf@assigned-by-dhcp.cox.net>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 13 06:28:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ExHUM-00010r-02
	for gcvg-git@gmane.org; Fri, 13 Jan 2006 06:28:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964839AbWAMF2f (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Jan 2006 00:28:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751505AbWAMF2f
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jan 2006 00:28:35 -0500
Received: from xproxy.gmail.com ([66.249.82.198]:11276 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751504AbWAMF2e (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Jan 2006 00:28:34 -0500
Received: by xproxy.gmail.com with SMTP id s14so434353wxc
        for <git@vger.kernel.org>; Thu, 12 Jan 2006 21:28:31 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=mO9XCd63oM41K8TBQVQrJ+sd3m3W8Oeoyut8nvp1G5ZzIJvelPXahwgEqSm4UJAtbO/mqh1bldE4XXf9zg7Wr/zI7IvumRjLaxZoiXWm718fkd7CuBKMZc38/esQdVp9THBMuRhrj8DB9vfEUev0Tj4vibqp4eONoYcmylX/eX8=
Received: by 10.70.12.6 with SMTP id 6mr3303724wxl;
        Thu, 12 Jan 2006 21:28:31 -0800 (PST)
Received: from ?10.0.0.6? ( [68.234.172.144])
        by mx.gmail.com with ESMTP id h13sm3136716wxd.2006.01.12.21.28.30;
        Thu, 12 Jan 2006 21:28:31 -0800 (PST)
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vslrsg41g.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14616>

Junio C Hamano wrote:
> A Large Angry SCM <gitzilla@gmail.com> writes:
> 
>>Junio C Hamano wrote:
>>>It really does not make sense not doing --topo-order.
>>I disagree. I do like to see the chronological commit history of some
>>repositories.
> 
> But the thing is if you do chronological order, you may not see
> enough commits without --more=, because show-branches stops at
> the first common commit.  Try it yourself in a repository with
> merges on topic branches of different vintage, with and without
> the option, to see where output stops.

Interesting, I don't think I've ever looked far enough to triggered the 
stop condition in my repositories of interest before.

How about making topo-order the default but having an option for 
chronological order?
