From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [PATCH] Additional merge-base tests
Date: Wed, 05 Jul 2006 07:28:25 -0700
Message-ID: <44ABCC89.2090003@gmail.com>
References: <44A9E6AE.10508@gmail.com> <Pine.LNX.4.63.0607041019580.29667@wbgn013.biozentrum.uni-wuerzburg.de> <7v8xn9gjh5.fsf@assigned-by-dhcp.cox.net> <200607051039.53288.Josef.Weidendorfer@gmx.de>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 05 16:28:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fy8Mj-0001AM-2I
	for gcvg-git@gmane.org; Wed, 05 Jul 2006 16:28:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964853AbWGEO2a (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Jul 2006 10:28:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964882AbWGEO2a
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Jul 2006 10:28:30 -0400
Received: from wr-out-0506.google.com ([64.233.184.237]:49670 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S964853AbWGEO23 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jul 2006 10:28:29 -0400
Received: by wr-out-0506.google.com with SMTP id 69so931059wra
        for <git@vger.kernel.org>; Wed, 05 Jul 2006 07:28:28 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=YnFRS89Uu1faVD4ZJJRE8V26dgRBWES3WEd2msjyghSxhUZcXiNX75hcN3PB30kf87DG/ZjGB+yHSm2l7sbVySe1N9TwAE/iUB9yONyY2Tqs6vMzYqwIbWYBdD2JTr+csTtcfnslv73FIACdeDAd16HKcR+VaBcm08DPUYjp0As=
Received: by 10.65.191.7 with SMTP id t7mr5242972qbp;
        Wed, 05 Jul 2006 07:28:28 -0700 (PDT)
Received: from ?10.0.0.6? ( [69.160.147.208])
        by mx.gmail.com with ESMTP id p4sm2228191qba.2006.07.05.07.28.27;
        Wed, 05 Jul 2006 07:28:28 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0.8 (X11/20060411)
X-Accept-Language: en-us, en
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>, git@vger.kernel.org
In-Reply-To: <200607051039.53288.Josef.Weidendorfer@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23349>

Josef Weidendorfer wrote:
> On Tuesday 04 July 2006 23:15, Junio C Hamano wrote:
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>
>>> We could introduce a time.maximumSkew variable, and just walk only 
>>> that much further when traversing the commits.
>> We could have had "commit generation number" in the commit
>> object header, and use that instead of commit timestamps for
>> these traversal purposes.
> 
> Isn't this "commit generation number" information that can be
> regenerated on the fly, i.e. a perfect fit for data to be stored
> in a persistant cache, e.g. in ".git/tmp/virtual-commit-timestamps"?

Yes
