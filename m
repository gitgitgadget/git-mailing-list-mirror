From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [PATCH] Additional merge-base tests
Date: Tue, 04 Jul 2006 17:26:34 -0700
Message-ID: <44AB073A.9040301@gmail.com>
References: <44A9E6AE.10508@gmail.com> <7v3bdhoraa.fsf@assigned-by-dhcp.cox.net> <44AA0DAE.1060308@gmail.com> <7vpsgllsnp.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0607041019580.29667@wbgn013.biozentrum.uni-wuerzburg.de> <7v8xn9gjh5.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0607050021330.29667@wbgn013.biozentrum.uni-wuerzburg.de> <44AAF49F.6090008@gmail.com> <e8esnn$mb5$1@sea.gmane.org>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Jul 05 02:27:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxvEV-0000WK-B4
	for gcvg-git@gmane.org; Wed, 05 Jul 2006 02:27:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932368AbWGEA0i (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Jul 2006 20:26:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932365AbWGEA0i
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Jul 2006 20:26:38 -0400
Received: from wx-out-0102.google.com ([66.249.82.206]:48028 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932364AbWGEA0h (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jul 2006 20:26:37 -0400
Received: by wx-out-0102.google.com with SMTP id t10so743231wxc
        for <git@vger.kernel.org>; Tue, 04 Jul 2006 17:26:36 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:x-accept-language:mime-version:to:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=Hp17iQXU++ko2rPVgyq53Lg7XgUscYjnC++iRHrKCtyT8NukBkcxwwbnNwyiURzE7BcojbGqf/apxlW+bSncqHDHE/WRYBY9a0JXFQX+H1gPzYB4r7bBcAxZF5YYiCP5YxLLkEIGsbh8p0dP/nVFA+Lv/+VtZqxaFVBFLy8SFqE=
Received: by 10.70.99.7 with SMTP id w7mr3400997wxb;
        Tue, 04 Jul 2006 17:26:36 -0700 (PDT)
Received: from ?10.0.0.6? ( [69.160.147.208])
        by mx.gmail.com with ESMTP id i19sm6871337wxd.2006.07.04.17.26.35;
        Tue, 04 Jul 2006 17:26:36 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0.8 (X11/20060411)
X-Accept-Language: en-us, en
To: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
In-Reply-To: <e8esnn$mb5$1@sea.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23332>

Jakub Narebski wrote:
> A Large Angry SCM wrote:
> 
>> It works[*] and it does what using the timestamp was trying to do. 
>> Namely, work from "more recent" (or "closer") commits toward "older" (or 
>> "farther") commits until you've gone past the point you care about.
>>
>> It's a little late to be changing the structure of a commit and you'd 
>> have to deal with some size/scale issues, but it's do-able. A better 
>> idea may be to generate and keep the generation number on a per 
>> repository basis, and you'd be able to work around changing grafts.
> 
> What about timestamp = MAX(now(), timestamps of parents) idea, which
> doesn't need changing the structure of a commit?
> 

So, do you really want your name as committer on a commit with a date 
300 years in the future because one of the parents had a bad date?
