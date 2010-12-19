From: Taylor Hedberg <tmhedberg@gmail.com>
Subject: Re: Commiting automatically (2)
Date: Sun, 19 Dec 2010 10:08:51 -0500
Message-ID: <20101219150850.GC12136@foodlogiq3-xp-d620.thebe.ath.cx>
References: <loom.20101219T090500-396@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Maaartin <grajcar1@seznam.cz>
X-From: git-owner@vger.kernel.org Sun Dec 19 16:15:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PUKyx-0004gF-GJ
	for gcvg-git-2@lo.gmane.org; Sun, 19 Dec 2010 16:15:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932256Ab0LSPIy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Dec 2010 10:08:54 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:51237 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932176Ab0LSPIx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Dec 2010 10:08:53 -0500
Received: by qyj19 with SMTP id 19so3171778qyj.19
        for <git@vger.kernel.org>; Sun, 19 Dec 2010 07:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=+axG1nK1Zqf1BeBPbjqAJUgt0LgPnh8wfNr9rFFHG5s=;
        b=ma+I24WwglYv3546ALKg63wWnl4t9dp+q3xuqldJO7DbtqmqRxN+FH6z1SNnFVb+BE
         4lPYfmoSGb6lAX3nKti4ZUWnk9aOalY11L84uunSSYxx3HP63k8lJLxKJ2omRz8Mr4+z
         HXRPI8iqFApCRnm5v/zc4em5+fod3yFr4hqBw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=l4fOaNJbOZY8Jj87va7zfolUDPTLfO2vgjgp572ePFr5SSJ6RUgbDQhW7mn+Yd7xxA
         /fTJLWZfn3unOKkbU/XI8vX7wAdSOMLREoUhpxfZ73nKf2zZUCtjRT3vElj91AA7zbjS
         NLK4e6kNIEpoho6SqbtescN/+FmnT+ZqhlOmE=
Received: by 10.229.250.9 with SMTP id mm9mr2832520qcb.264.1292771332493;
        Sun, 19 Dec 2010 07:08:52 -0800 (PST)
Received: from foodlogiq3-xp-d620.thebe.ath.cx (cpe-075-182-067-204.nc.res.rr.com [75.182.67.204])
        by mx.google.com with ESMTPS id m14sm1561336qcu.32.2010.12.19.07.08.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 19 Dec 2010 07:08:51 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <loom.20101219T090500-396@post.gmane.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163958>

On Sun, Dec 19, 2010 at 08:29:50AM +0000, Maaartin wrote:
> There's one more problem. My script doesn't recognize deleted files, since
> git add -A
> does nothing to them. I'm quite sure I saw a solution to this, but can't find 
> it now...

I believe "git add -u" will do the same thing as "git add -A", plus
handle deleted files.
