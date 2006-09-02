From: =?UTF-8?B?S3Jpc3RpYW4gSMO4Z3NiZXJn?= <krh@redhat.com>
Subject: Re: [PATCH] Rewrite branch in C and make it a builtin.
Date: Sat, 02 Sep 2006 13:39:00 -0400
Message-ID: <44F9C1B4.70409@redhat.com>
References: <1156562127979-git-send-email-krh@redhat.com> <20060902010806.GA24234@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 02 19:40:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GJZUH-0004fT-IL
	for gcvg-git@gmane.org; Sat, 02 Sep 2006 19:40:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751228AbWIBRkr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Sep 2006 13:40:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751233AbWIBRkr
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Sep 2006 13:40:47 -0400
Received: from mx1.redhat.com ([66.187.233.31]:57029 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751228AbWIBRkq (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 2 Sep 2006 13:40:46 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id k82HehHQ003845;
	Sat, 2 Sep 2006 13:40:43 -0400
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id k82HehxD010979;
	Sat, 2 Sep 2006 13:40:43 -0400
Received: from [127.0.0.1] (sebastian-int.corp.redhat.com [172.16.52.221])
	by pobox.corp.redhat.com (8.13.1/8.12.8) with ESMTP id k82HegZw016037;
	Sat, 2 Sep 2006 13:40:42 -0400
User-Agent: Thunderbird 1.5.0.5 (X11/20060803)
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060902010806.GA24234@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26345>

Shawn Pearce wrote:
> Kristian  H??gsberg <krh@redhat.com> wrote:
>> A more or less straight port to C of the shell script version.
> 
> [snip]
>> +static void create_reflog(struct ref_lock *lock)
> 
> I'm attaching a patch to the reflog code which introduces a new
> force_log option.  You can use set this after you lock the ref
> but before writing it, provided that the user supplied -l on
> the command line.
> 
> This completely replaces the create_reflog function with common code.

Yeah, that should work, I'll send out a new version that uses the new flag.

> I apologize for taking so long to get around to this but I've been
> busy with other stuff lately.  :-)

No problem at all, I'm working on this on and off anyway :)

Kristian


-- 
VGER BF report: U 0.499995
