From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: prune/prune-packed
Date: Sun, 22 Oct 2006 18:26:13 -0700
Message-ID: <453C1A35.70504@gmail.com>
References: <20061022035919.GA4420@fieldses.org> <7vy7r954k7.fsf@assigned-by-dhcp.cox.net> <20061022231422.GA9375@fieldses.org> <20061023005336.GA12932@fieldses.org>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "J. Bruce Fields" <bfields@fieldses.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 23 03:26:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gboa8-0001rk-EI
	for gcvg-git@gmane.org; Mon, 23 Oct 2006 03:26:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751045AbWJWB0T (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Oct 2006 21:26:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751047AbWJWB0T
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Oct 2006 21:26:19 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:56008 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751039AbWJWB0S (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Oct 2006 21:26:18 -0400
Received: by ug-out-1314.google.com with SMTP id o38so1136490ugd
        for <git@vger.kernel.org>; Sun, 22 Oct 2006 18:26:17 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=mvU9htujrpTo5rlJtjxVLrRFRrHtDLs0yRfi3oSeGIKw9ZnCuIM8Y7KyfB4rj/32BHPPu0r3xhEcCUWtrrEScJwoqXfGuFokwkaJ2ub5sH1+VetFls6urfndI58Lw1bYpQ9kCVa5KnQ0tvTmc1LTajJh/5lTfpNaJju272ijSSQ=
Received: by 10.78.160.2 with SMTP id i2mr6499220hue;
        Sun, 22 Oct 2006 18:26:17 -0700 (PDT)
Received: from ?10.0.0.6? ( [67.20.71.142])
        by mx.google.com with ESMTP id 2sm2842155hue.2006.10.22.18.26.16;
        Sun, 22 Oct 2006 18:26:17 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.7 (X11/20060911)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <20061023005336.GA12932@fieldses.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29811>

J. Bruce Fields wrote:
> Junio C Hamano <junkio@cox.net> writes:
>> I am considering the following to address irritation some people
>> (including me, actually) are experiencing with this change when
>> viewing a small (or no) diff.  Any objections?
> 
> So for me, if I run
> 
> 	less -FRS file
> 
> where "file" is less than a page, I see nothing happen whatsoever.
> 
> At a guess, maybe it's clearing the screen, displaying the file, the
> restoring, all before I see anything happen?

Junio,

How about reverting this change? From the reports here, is causing 
problems on a number of different distributions.

These settings are probably something that is better set by the user in 
an environment variable. Or, make the default something that does work 
everywhere and have a config item for those that wish to customize their UI.
