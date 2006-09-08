From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: Change set based shallow clone
Date: Fri, 08 Sep 2006 10:18:20 -0700
Message-ID: <4501A5DC.609@gmail.com>
References: <9e4733910609071252ree73effwb06358e9a22ba965@mail.gmail.com>	 <7vpse7tjp0.fsf@assigned-by-dhcp.cox.net>	 <46a038f90609072054u5ec8bc46x9878a601953b2c5d@mail.gmail.com>	 <7vac5ancvo.fsf@assigned-by-dhcp.cox.net> <46a038f90609080015u56daae78u9d78584edae7fb72@mail.gmail.com>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, Jon Smirl <jonsmirl@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 08 19:18:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLjzm-0002H1-Jr
	for gcvg-git@gmane.org; Fri, 08 Sep 2006 19:18:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750881AbWIHRSY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Sep 2006 13:18:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750849AbWIHRSX
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Sep 2006 13:18:23 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:39874 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750881AbWIHRSX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Sep 2006 13:18:23 -0400
Received: by py-out-1112.google.com with SMTP id n25so904014pyg
        for <git@vger.kernel.org>; Fri, 08 Sep 2006 10:18:22 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=jyP9xCTpqoc9eCRLHignyB4oLPmqkQ09cqXnesvTmpLQxsNz7KcSqosHn9IyViYJBMX2r8jpnbUFxDpp+gLN4LcFapw+vgRNCWEz1b0lAI1vSlgdqD2nXijnQaneI0H5tB/MH6r7j6Me8m46MhSGV/r0u8oZEPKUFI3J/mK/N/M=
Received: by 10.35.15.11 with SMTP id s11mr3302916pyi;
        Fri, 08 Sep 2006 10:18:22 -0700 (PDT)
Received: from ?10.0.0.6? ( [24.55.157.69])
        by mx.gmail.com with ESMTP id a75sm582454pyf.2006.09.08.10.18.21;
        Fri, 08 Sep 2006 10:18:22 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.5 (X11/20060725)
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90609080015u56daae78u9d78584edae7fb72@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26702>

Martin Langhoff wrote:
> On 9/8/06, Junio C Hamano <junkio@cox.net> wrote:
...
>> [*4*] In git, there is no inherent server vs client or upstream
>> vs downstream relationship between repositories.
> 
> Here an importaant distiction must be made. A "publishing" repo cannot
> be sparse. A sparse repo probably cannot be cloned from.

With the use of "placeholder" objects; neither one of these assertions
is true.
