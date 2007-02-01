From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] Make gitk work reasonably well on Cygwin.
Date: Thu, 1 Feb 2007 09:03:23 +0100
Message-ID: <81b0412b0702010003t7becddf3x8fe6b36b0d84599b@mail.gmail.com>
References: <BAY13-F213DF79906B3889D42369D0A50@phx.gbl>
	 <Pine.LNX.4.63.0701311612420.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <45C14563.8060707@verizon.net>
	 <7vk5z2r27s.fsf@assigned-by-dhcp.cox.net> <m264am5u1r.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org,
	"Mark Levedahl" <mdl123@verizon.net>
To: "Seth Falcon" <sethfalcon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 01 09:03:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCWuo-0003kG-3q
	for gcvg-git@gmane.org; Thu, 01 Feb 2007 09:03:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422646AbXBAID0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Feb 2007 03:03:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161226AbXBAID0
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Feb 2007 03:03:26 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:25908 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161212AbXBAIDZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Feb 2007 03:03:25 -0500
Received: by ug-out-1314.google.com with SMTP id 44so398427uga
        for <git@vger.kernel.org>; Thu, 01 Feb 2007 00:03:23 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WA7i9sJq7vuejFMsDm1BInYdCwoKAQkfq8uqD7ro15Cl+V5xAyOPyRwzK/9QB4ubNpsbzzMRRNqoLVrYKnXt7haM+ZoLDoJxSTmWrAI3DwHD0ib71Z/O8drrYRccBSydgzgBnrWyNY5LF0b7MzKfKRHB2OSabdQtDbI8XcrBljg=
Received: by 10.78.150.7 with SMTP id x7mr445801hud.1170317003263;
        Thu, 01 Feb 2007 00:03:23 -0800 (PST)
Received: by 10.78.139.7 with HTTP; Thu, 1 Feb 2007 00:03:23 -0800 (PST)
In-Reply-To: <m264am5u1r.fsf@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38331>

On 2/1/07, Seth Falcon <sethfalcon@gmail.com> wrote:
>
> > I am not in X right now and won't be able to look at it myself
> > tonight.  Could folks on MacOS comment on Mark's patch?
>
> I gave it a quick spin on OS X.  gitk loads with a different geometry
> than it had before, but seems to work the same.  If this fixes things
> elsewhere, it seems fine here.
>

FWIW, I confirm that. Much better. Mouse selection still does not
work in patch pane, but broken layout was the most annoying.
Thanks, Mark!
