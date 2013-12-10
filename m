From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Compiling git svn from source
Date: Tue, 10 Dec 2013 11:01:29 -0800
Message-ID: <20131210190129.GD2311@google.com>
References: <CAHCisteVsy4_GX_1PNZfO44w1WmW28vAY0PBfwo9CL_Ze8fw2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: avinash r <nashpapa@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 10 20:01:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VqSYt-0002v1-3M
	for gcvg-git-2@plane.gmane.org; Tue, 10 Dec 2013 20:01:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752671Ab3LJTBe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Dec 2013 14:01:34 -0500
Received: from mail-yh0-f46.google.com ([209.85.213.46]:54299 "EHLO
	mail-yh0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752094Ab3LJTBd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Dec 2013 14:01:33 -0500
Received: by mail-yh0-f46.google.com with SMTP id l109so4191021yhq.19
        for <git@vger.kernel.org>; Tue, 10 Dec 2013 11:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=GOrFZtl+/2ZX5cZBRz5aMz7VMpxkqPI+w6P9E5bCZuc=;
        b=A6oqfelkR5IkQgrfrWSE4PrUQqALSS16+o4ih7ZiaK10tvRRHZ/iX7jhBdFdGEv/Ea
         TptZld5eW33Q9R1xUooItQ8STPc4vl7p/Wax2BaYkzQmw5H052bjr4ebQj7gAMw0918n
         ivYWdwXs0lZCi9E1TsyZkv7dDMUjkF6wHppkYyxXwVugY7eNwPFN1JCUpYFUp+l8jACp
         rST1ZJ7HaNVuX/d9iSvNC14o0cYTamirvIPktS4GRI+fr0BHQXp17veK7rAubeE8PxVB
         uTwrcX8sUL/ko6jtD0xs2FicsZPuu+rIJSVMEyp865zlxxnbEv8QJIBC1XPh0AsZlffu
         85tg==
X-Received: by 10.236.135.15 with SMTP id t15mr2530745yhi.106.1386702093117;
        Tue, 10 Dec 2013 11:01:33 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id s21sm23973254yhk.9.2013.12.10.11.01.31
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 10 Dec 2013 11:01:32 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAHCisteVsy4_GX_1PNZfO44w1WmW28vAY0PBfwo9CL_Ze8fw2A@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239149>

Hi,

avinash r wrote:

>                    I followed the installation instructions at
> git-scm.com, but somehow the sub-command svn (git svn) is not being
> installed.
[...]
> Here is how i'm compiling:
>
> $ make all
>
> $ sudo make install

What is the content of "config.mak"?  Is there a file named
"config.mak.autogen"?  What is the output of "git help -a | grep svn"?

Curious,
Jonathan
