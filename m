From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: RFC: Subprojects
Date: Sat, 14 Jan 2006 11:32:06 -0800
Message-ID: <43C951B6.5030607@gmail.com>
References: <43C52B1F.8020706@hogyros.de> <Pine.LNX.4.63.0601111740220.17966@wbgn013.biozentrum.uni-wuerzburg.de> <43C537C9.4090206@hogyros.de> <Pine.LNX.4.64.0601110928350.5073@g5.osdl.org> <7vacdzkww3.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0601141055210.13339@g5.osdl.org>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <junkio@cox.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Simon Richter <Simon.Richter@hogyros.de>
X-From: git-owner@vger.kernel.org Sat Jan 14 20:32:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Exr8M-0000yt-98
	for gcvg-git@gmane.org; Sat, 14 Jan 2006 20:32:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750855AbWANTcP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Jan 2006 14:32:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750856AbWANTcP
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jan 2006 14:32:15 -0500
Received: from xproxy.gmail.com ([66.249.82.204]:39529 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750845AbWANTcO (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Jan 2006 14:32:14 -0500
Received: by xproxy.gmail.com with SMTP id i30so675739wxd
        for <git@vger.kernel.org>; Sat, 14 Jan 2006 11:32:14 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=nYbutmkV/PIMbOCGrA5C5BfaUTMPRbSHp5mk9RsKULBuG5TenZ+w9kNO4Q0ULx/3Yq96FVov4AiYnwxcfANPik97zKxBcrVihsayJhtO5gQWcQZTch70p5jI6SFzb5AcTGQJt1+MjN42z3OpjkOdMi3hA4qW60vlnFtUjbymuWU=
Received: by 10.70.110.9 with SMTP id i9mr5369673wxc;
        Sat, 14 Jan 2006 11:32:14 -0800 (PST)
Received: from ?10.0.0.6? ( [68.234.172.144])
        by mx.gmail.com with ESMTP id h20sm5413342wxd.2006.01.14.11.32.13;
        Sat, 14 Jan 2006 11:32:13 -0800 (PST)
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0601141055210.13339@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14675>

So far I've not seen any convincing arguments why the sub-projects can 
not be managed by the Makefile, or equivalent, of the super-project. 
Particularly when the sub-projects have a life of their own.
