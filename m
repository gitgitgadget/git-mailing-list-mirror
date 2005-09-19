From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: What shall we do with the GECOS field again?
Date: Mon, 19 Sep 2005 12:16:47 -0400
Message-ID: <432EE46F.9000806@gmail.com>
References: <20050919134838.GC2903@pasky.or.cz> <432ECB92.5000505@gmail.com> <pan.2005.09.19.14.47.51.811409@smurf.noris.de>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 19 18:20:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHOLC-000632-UU
	for gcvg-git@gmane.org; Mon, 19 Sep 2005 18:18:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932491AbVISQQ4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Sep 2005 12:16:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932492AbVISQQ4
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 12:16:56 -0400
Received: from xproxy.gmail.com ([66.249.82.195]:19331 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932491AbVISQQy (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Sep 2005 12:16:54 -0400
Received: by xproxy.gmail.com with SMTP id i31so439365wxd
        for <git@vger.kernel.org>; Mon, 19 Sep 2005 09:16:50 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=HcFxBd3h91t5mrgJ29BG7KZAOqIzwc9oKD1YkcaqjDS01VOkbBofpeXlQVmmJCC6FbvGqnRnibSjcOzJ4vleXxsOy2ruHVuH2JKwDz27SBiNdk4u3h5uC7YA2KUftvroyL2b3JOTwpUh57/9FJtlDDgNdqzgBCBL4Vg7ezw1SUg=
Received: by 10.70.31.17 with SMTP id e17mr1369665wxe;
        Mon, 19 Sep 2005 09:16:49 -0700 (PDT)
Received: from ?10.0.0.6? ( [70.89.97.97])
        by mx.gmail.com with ESMTP id i38sm568209wxd.2005.09.19.09.16.48;
        Mon, 19 Sep 2005 09:16:49 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
To: Matthias Urlichs <smurf@smurf.noris.de>
In-Reply-To: <pan.2005.09.19.14.47.51.811409@smurf.noris.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8882>

Matthias Urlichs wrote:
> Hi, A Large Angry SCM wrote:
> 
>>Saying that the user's name is first and a particular punctuation 
>>character SHALL be the standard cut point and everyone not happy with 
>>the results should explicitly set the Git environment variables is the 
>>wrong approach.
> 
> I disagree. Standard add-user tools use the gecos field in one of two ways:

s/two/many/

> - fullname
> - fullname,and,some,other,cruft
- title,name and other stuff
- department, name and other stuff
- other punctuation, etc.

> 
> Sure, many organizations bake their own, but I'd argue that the majority
> doesn't.

The point is we should not be telling them what and how to put stuff in 
the GECOS field.

>>AND/OR to include 
>>the what Git thinks the user's name name might be in the commit message
>>template they're editing (like the file list).
> 
> I think that's a good idea, as long as people are told how to change it
> (i.e., an envvar -- NOT by editing the file).

Yes.
