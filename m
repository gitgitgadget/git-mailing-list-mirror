From: Shawn Bohrer <shawn.bohrer@gmail.com>
Subject: Re: [PATCH] Make git-clean a builtin
Date: Wed, 7 Nov 2007 23:37:50 -0600
Message-ID: <20071108053750.GC6768@mediacenter.austin.rr.com>
References: <11944127311587-git-send-email-shawn.bohrer@gmail.com> <7vabppbxef.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, johannes.schindelin@gmx.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 08 06:37:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iq05F-0002GQ-0P
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 06:37:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751035AbXKHFhZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 00:37:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750872AbXKHFhY
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 00:37:24 -0500
Received: from wx-out-0506.google.com ([66.249.82.234]:23391 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750738AbXKHFhY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 00:37:24 -0500
Received: by wx-out-0506.google.com with SMTP id h31so62896wxd
        for <git@vger.kernel.org>; Wed, 07 Nov 2007 21:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        bh=WHnB0bLFywxvW/1O6+gaL8CGKc2QFNuJLO7lITE5ILw=;
        b=VlbEhy4GokArED97xipN52cLiQJrz262s9YJY/DP2meiZjfRa1qEhJNz6LirqD4HvQ1Kuh1BtYQWVI5hgwdKV8k90p8jjO+9y6tTRQ/I+IU0byUL7NZ2sa1wVXigDEiZujLyDVKsq13i7gEs/lOrR+4T/kms4xmyJhcuODjXEkA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=uH9ocvdolQ7jy2J89e9cgkd7HHrNTYrS8Zv1+1CASwl98JVI0dzmPFYmP0wL0QgwiyR7yTmp27knVQ/4ZKmKQzCwGxeXL8K7ucJXD3ROopOoCQpqRA9MIqikqlGbsKab9JfMQCkAvPo2Ju0RnhTbL43Mgdd0t18XqjkpbBJ/I84=
Received: by 10.70.68.9 with SMTP id q9mr302617wxa.1194500242902;
        Wed, 07 Nov 2007 21:37:22 -0800 (PST)
Received: from mediacenter.austin.rr.com ( [70.112.149.232])
        by mx.google.com with ESMTPS id h8sm351501wxd.2007.11.07.21.37.20
        (version=SSLv3 cipher=OTHER);
        Wed, 07 Nov 2007 21:37:21 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vabppbxef.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.15 (2007-04-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63933>

On Wed, Nov 07, 2007 at 12:42:16PM -0800, Junio C Hamano wrote:
> 
> Having said that, I do not particularly agree with the way the
> new implementation resolves the existing inconsistencies.  
> 
> Wouldn't it be better to remove "dir" when the user explicitly
> told you to clean "dir", with or without the trailing slash?
> That's what the user asked you to do, isn't it?

Yes I suppose I agree.  Of course I need to spend some more time staring
at the code to figure out how to do so.  Perhaps I can figure out what
is causing the original inconsistency in git-ls-files while I'm at it.
