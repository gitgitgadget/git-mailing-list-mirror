From: Noel Grandin <noel@peralex.com>
Subject: Re: [PATCH 1/3] Introduce "rev-list --stop-at=<commit>".
Date: Fri, 13 May 2005 08:07:15 +0200
Message-ID: <42844413.5020004@peralex.com>
References: <7v3bssc770.fsf@assigned-by-dhcp.cox.net> <20050513052901.GB16464@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----------=_1115964436-66243-650"
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 13 08:01:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWTEY-0003Bm-Ao
	for gcvg-git@gmane.org; Fri, 13 May 2005 08:01:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262256AbVEMGI1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 May 2005 02:08:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262257AbVEMGI0
	(ORCPT <rfc822;git-outgoing>); Fri, 13 May 2005 02:08:26 -0400
Received: from mail.peralex.com ([168.210.54.172]:54511 "EHLO mail.peralex.com")
	by vger.kernel.org with ESMTP id S262256AbVEMGIG (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 May 2005 02:08:06 -0400
Received: from [192.168.1.230] (noel.ct [192.168.1.230])
	by mail.peralex.com (8.13.3/8.13.1) with ESMTP id j4D67GOV091914;
	Fri, 13 May 2005 08:07:16 +0200 (SAST)
	(envelope-from noel@peralex.com)
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050513052901.GB16464@pasky.ji.cz>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
X-Scanned-By: MIMEDefang 2.42
X-Synonym: Copied by Synonym (http://www.modulo.ro/synonym) to: mailbackup@peralex.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format...

------------=_1115964436-66243-650
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Also, it should be called --stop-before given it's behaviour.
--stop-at implies that it includes the given commit.

Petr Baudis wrote:

>Dear diary, on Fri, May 13, 2005 at 02:15:15AM CEST, I got a letter
>where Junio C Hamano <junkio@cox.net> told me that...
>  
>
>>Additional option, --stop-at=<commit>, is introduced.  The
>>git-rev-list output stops just before showing the named commit.
>>
>>This is based on Thoms Gleixner's patch but slightly reworked.
>>
>>Signed-off-by: Junio C Hamano <junkio@cox.net>
>>    
>>
>
>Won't apply for now - as I already said in the relevant thread, this
>makes no sense with the current git-rev-list output order, and even
>encourages using it in wrong way. It is ok when the merges are reported
>in a different way, but that's impossible without some repoid (I yet
>have to catch up with that thread :-).
>
>  
>


NOTICE: Please note that this email, and the contents thereof, 
are subject to the standard Peralex email disclaimer, which may 
be found at: http://www.peralex.com/disclaimer.html

If you cannot access the disclaimer through the URL attached 
 and you wish to receive a copy thereof please send 
 an email to email@peralex.com

------------=_1115964436-66243-650--
