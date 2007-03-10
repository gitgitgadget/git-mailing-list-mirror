From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [PATCH 2/3] git-bundle: die if a given ref is not included in
 bundle
Date: Sat, 10 Mar 2007 13:30:12 -0500
Message-ID: <45F2F934.8060407@gmail.com>
References: <Pine.LNX.4.63.0703090348300.22628@wbgn013.biozentrum.uni-wuerzburg.de> <45F0D1B3.9020204@gmail.com> <7vejny7umx.fsf@assigned-by-dhcp.cox.net> <45F17EF0.5060008@gmail.com> <7v1wjy56qf.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0703101637300.22628@wbgn013.biozentrum.uni-wuerzburg.de> <45F2D955.8050800@gmail.com> <Pine.LNX.4.63.0703101749270.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Mar 10 19:30:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQ6Ku-0000oZ-II
	for gcvg-git@gmane.org; Sat, 10 Mar 2007 19:30:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751153AbXCJSaL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Mar 2007 13:30:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751220AbXCJSaL
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Mar 2007 13:30:11 -0500
Received: from an-out-0708.google.com ([209.85.132.244]:16591 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751153AbXCJSaK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Mar 2007 13:30:10 -0500
Received: by an-out-0708.google.com with SMTP id b33so1071512ana
        for <git@vger.kernel.org>; Sat, 10 Mar 2007 10:30:09 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=HXZmqa7mNUY/+oXYr1uG+zrBL+C2TkSWmKrqLaADRMKamCA/Ym+Od4dhTL164F9f99Fm4EeL0ykXC8uthgvTckZjuMVWMTAW/OCHZfA0frAA0R/NiqiFS36xoIp1qJWgCB/Fe3od3Ab222NVTLIx3lbQc6/ZE3JkcPb8F4/YSdo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=JAAC2QZz7BL7UN82CYPhdVbq5ePzxbLtKIROhtmcV4+/9n9iOrE+v+TwqXBUhKvI8NUzxRlaMjICg2x4q9eDViwWPHv5cM3oy6IwsTxPe3f9DUOhptXuJkWbChvtBJxy7ma4xH0aULYz010+CCbJOXe9nvHjUDV6HCJnIMxcISM=
Received: by 10.114.173.15 with SMTP id v15mr539961wae.1173551409095;
        Sat, 10 Mar 2007 10:30:09 -0800 (PST)
Received: from ?192.168.100.117? ( [71.246.235.75])
        by mx.google.com with ESMTP id 45sm5930093wri.2007.03.10.10.30.08;
        Sat, 10 Mar 2007 10:30:08 -0800 (PST)
User-Agent: Thunderbird 1.5.0.10 (Windows/20070221)
In-Reply-To: <Pine.LNX.4.63.0703101749270.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41875>

Johannes Schindelin wrote:
> Hi,
>   
> So, what do you do if some of your users do, and some others do not, have 
> the "blue-sky" branch? If you say "git bundle create new.bundle --all 
> -10", your bundle will list "blue-sky" as a prerequisite.
>
> Boom.
>
> Some of your users -- those without "blue-sky" -- will _not_ be able 
> to fetch _anything_ from the bundle. They are lacking the prerequisites.
>   
Those who have the prerequisites can apply the bundle. Those who do not, 
cannot. This is unchanged, and completely unrelated to whether the 
bundle defines 0 objects or 10,000. If you do not have the 
prerequisites, you need a different bundle.

Mark
