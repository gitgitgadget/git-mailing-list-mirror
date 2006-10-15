From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [PATCH] pack-objects: use of version 3 delta is now optional.
Date: Sun, 15 Oct 2006 12:29:29 -0700
Message-ID: <45328C19.8070109@gmail.com>
References: <7v4pu62ite.fsf@assigned-by-dhcp.cox.net>	<7virim10rb.fsf@assigned-by-dhcp.cox.net>	<Pine.LNX.4.64.0610151135110.17085@xanadu.home> <7vac3xzbze.fsf@assigned-by-dhcp.cox.net>
Reply-To: git@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Sun Oct 15 21:29:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZBg1-0006Hh-E3
	for gcvg-git@gmane.org; Sun, 15 Oct 2006 21:29:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932134AbWJOT3e (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Oct 2006 15:29:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932139AbWJOT3e
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Oct 2006 15:29:34 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:24365 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932134AbWJOT3e (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Oct 2006 15:29:34 -0400
Received: by py-out-1112.google.com with SMTP id n25so2023585pyg
        for <git@vger.kernel.org>; Sun, 15 Oct 2006 12:29:32 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=fNgNHgRixYwiQ2+YD2JMr0PwKlHxP0AYnmdg0rR9QN6s+i9qnZH9X20ZouhffF+0u/H6ti+osCgrieEkaSXU4YTzt7dPrvH0k5U4ECuRoLpRDBqJn03WAa3xHjL/AVAnH014WZS3S5mSHVC+PCd7rKDQxQTevN3vvV1cQ0hFl5U=
Received: by 10.65.133.8 with SMTP id k8mr8730900qbn;
        Sun, 15 Oct 2006 12:29:32 -0700 (PDT)
Received: from ?10.0.0.6? ( [68.233.231.217])
        by mx.google.com with ESMTP id 1sm3750831qbh.2006.10.15.12.29.31;
        Sun, 15 Oct 2006 12:29:32 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.7 (X11/20060911)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vac3xzbze.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28930>

Junio C Hamano wrote:
[...]
> 
> I think that is sensible.  I also was thinking that we should
> call the current one packv3 and the one with delta-base-offset
> packv4.

+1
