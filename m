From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [PATCH 2/2] Implement a simple delta_base cache
Date: Sat, 17 Mar 2007 19:52:23 -0400
Message-ID: <9e4733910703171652n61c08814td78ee5fc7bc5957b@mail.gmail.com>
References: <Pine.LNX.4.64.0703151747110.3816@woody.linux-foundation.org>
	 <Pine.LNX.4.64.0703161636520.3910@woody.linux-foundation.org>
	 <Pine.LNX.4.64.0703161722360.3910@woody.linux-foundation.org>
	 <alpine.LFD.0.83.0703162257560.18328@xanadu.home>
	 <Pine.LNX.4.64.0703171044550.4964@woody.linux-foundation.org>
	 <Pine.LNX.4.64.0703171232180.4964@woody.linux-foundation.org>
	 <Pine.LNX.4.64.0703171242180.4964@woody.linux-foundation.org>
	 <Pine.LNX.4.64.0703171420420.4964@woody.linux-foundation.org>
	 <7vabybqxaj.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.64.0703171619440.4964@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>, "Nicolas Pitre" <nico@cam.org>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Mar 18 00:52:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSihI-000473-Ek
	for gcvg-git@gmane.org; Sun, 18 Mar 2007 00:52:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752421AbXCQXwZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Mar 2007 19:52:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752450AbXCQXwZ
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Mar 2007 19:52:25 -0400
Received: from wr-out-0506.google.com ([64.233.184.237]:1963 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752421AbXCQXwY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Mar 2007 19:52:24 -0400
Received: by wr-out-0506.google.com with SMTP id 41so976823wry
        for <git@vger.kernel.org>; Sat, 17 Mar 2007 16:52:23 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XdNTUZ3RBPhpDy2L5cm/MyVWOiKfciUTJyrYtcNYaHw8jWfvtX9AO06QJzDz4JxFIDZqVbWMP3j9hBTIYwzv306aIpzhO/bF4LymAfOvBqyDUDPxU4sgqdpsRM3L/y0Xdqc7LVegAcXOXXIqcmsovPqruUicPqnEe5mDaouEKCk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bL0gt5tLolKZiUOV93yIgFMvqwMR5ZFZ01Hq7UYyYEON5iujDaH8+oHIEUOmFYIZ762v1snL8/QGphpxyWK1FZBM9p/Q9i402HlzDD5ZFCMtvqHBiVUkvzgZZMuPBYhQH298sV4mxbfGYr2OtfR7AuGCtD9LLi5lV6erWaTCVjE=
Received: by 10.64.242.5 with SMTP id p5mr4665748qbh.1174175543403;
        Sat, 17 Mar 2007 16:52:23 -0700 (PDT)
Received: by 10.114.194.9 with HTTP; Sat, 17 Mar 2007 16:52:23 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0703171619440.4964@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42460>

If you still have a Mozilla pack file around it would be a good test
case. It has delta chains thousands of entries long. If I remember
correctly one had over 4,000 deltas.

-- 
Jon Smirl
jonsmirl@gmail.com
