From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [PATCH] gitweb: Extra columns in blame
Date: Fri, 18 May 2007 22:10:52 -0400
Message-ID: <464E5CAC.1040303@gmail.com>
References: <20070518191725.10460.83338.stgit@rover>	<7vy7jl4zjm.fsf@assigned-by-dhcp.cox.net>	<20070518221916.GZ4489@pasky.or.cz> <7vy7jl3bu5.fsf@assigned-by-dhcp.cox.net>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sat May 19 04:11:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpEPQ-0001Sn-Fq
	for gcvg-git@gmane.org; Sat, 19 May 2007 04:11:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753278AbXESCK6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 May 2007 22:10:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753631AbXESCK6
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 22:10:58 -0400
Received: from wx-out-0506.google.com ([66.249.82.227]:50264 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753049AbXESCK6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2007 22:10:58 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1082707wxd
        for <git@vger.kernel.org>; Fri, 18 May 2007 19:10:54 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:disposition-notification-to:date:from:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=paOYFnNy+8GmC8bCbQYrCWcjpb+zGBv5/f99zKM3qh61MZWBfEf4G5ou1wL0HGx/UJHf19omx4k+PGbwwFKmFCotSBpXUMBkyLfg9WSetjvTm30NqFHpZj30IY/AY4rVh3QYW3K/ERN+cVsn7eT0O2wHmlOnVRA4+xceEMGRuaM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=WOLymFvyFhiaHJP29OEP5RacMLk3a0Mm+ARrl70MmIj+32pHLBCW2RZpO0+u/ZnQcaH22tTizYdh4AvEK7VLaDixVKLRxBfBHjOXdomopH9rS9RXUeHs7O4Rkw8k5+6Ok/uE81EY9bD5lMNC2CI31RKDUKDEBFBjIcPiBJfSBqI=
Received: by 10.70.35.1 with SMTP id i1mr3466976wxi.1179540654714;
        Fri, 18 May 2007 19:10:54 -0700 (PDT)
Received: from ?10.0.0.6? ( [66.177.19.99])
        by mx.google.com with ESMTP id 25sm6395856wra.2007.05.18.19.10.53;
        Fri, 18 May 2007 19:10:54 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.10 (X11/20060911)
In-Reply-To: <7vy7jl3bu5.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47705>

Junio C Hamano wrote:
> Petr Baudis <pasky@suse.cz> writes:
> 
>>> Also the incremental thing using JavaScript does not seem to
>>> work for me incrementally for some reason, although if I wait
>>> long enough I get the fully blamed picture that seems to match
>>> nonincremental one.  While I am waiting, the browser goes silent
>>> and does not even let me switch to other tabs, so it is not all
>>> that useful to me in its current shape.
>> Strange, what browser are you using?
> 
> Firefox (I think it is 2.0) running on a W2k box behind two http
> proxies.

Same symptoms with FireFox 1.5.0.10 running on Suse 9.3.
