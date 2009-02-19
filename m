From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH 1/2] add basic branch display tests
Date: Wed, 18 Feb 2009 22:51:27 -0500
Message-ID: <76718490902181951p54dc222ai5ac6397f3471fc44@mail.gmail.com>
References: <20090219033329.GA13666@coredump.intra.peff.net>
	 <20090219033444.GA18970@coredump.intra.peff.net>
	 <20090219034504.GA19862@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 19 04:54:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZzz1-0004se-Uw
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 04:53:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751570AbZBSDv3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2009 22:51:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751388AbZBSDv3
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Feb 2009 22:51:29 -0500
Received: from rv-out-0506.google.com ([209.85.198.224]:62669 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751382AbZBSDv2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2009 22:51:28 -0500
Received: by rv-out-0506.google.com with SMTP id g37so223128rvb.1
        for <git@vger.kernel.org>; Wed, 18 Feb 2009 19:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=kfjYkbGex4TalKpRQ4wM2fl2X2vowGUGIBtOx/Df5Ps=;
        b=eU6W5rzSoxqfqfrb/lry41UHIM4ACUUwkDjMHuUjlluJMvOIPMoHAL7ASB1k7Epi+J
         sCec/9/yh461yuwpXlpCPf0EiJlt9TazJKoyZNygImroXZ1ndXMRe0jkUVEecgYRmbko
         zDujS7uXPeJ5X+SXjz7ZZ2uZ/tnqOGjRSxR2A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=o+NTmTRub3VVevBXwGXqQoL6zi/HcFDfe9zroDzJPvEUElz5NAsGdyLvFriUxlSUcp
         GsrEfNV8tQYpMEjH8ed+HFcUF97au3PaQZNgf/woZCCcqvcmz+8DlCorTiJ9jN6ch2XW
         zj7MBIZrUdCf/hmetVMxuy3JzaTBpbVhU81cc=
Received: by 10.141.63.20 with SMTP id q20mr4327725rvk.224.1235015487312; Wed, 
	18 Feb 2009 19:51:27 -0800 (PST)
In-Reply-To: <20090219034504.GA19862@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110619>

On Wed, Feb 18, 2009 at 10:45 PM, Jeff King <peff@peff.net> wrote:
> But here we stick the "remotes/" head on, since we are showing both
> types. But the right hand side of the symref doesn't get the same
> treatment.
>
> I don't think it's a big deal, but I wasn't sure if it was intentional,

It was intentional on my part. I thought appending it a second time
was redundant, and the remotes/ prefix on the LHS is just their to
distinguish remote branches from local.

> I also had a brief thought that reprinting the <remote> is pointless.
> That is, printing
>
>  origin/HEAD -> master
>
> shows what is happening with less text due to the context (i.e., we
> already know we are talking about remote "origin" -- and if it isn't in
> origin, we already show more). But that is probably a bad idea; that
> context is missing if you were to try to do something like "git show";
> <remote>/<branch> would work, but <branch> wouldn't.

Exactly. :-)

Thanks for the tests. If I had added them myself I wouldn't have you
publicly questioning my intent. ;-)

j.
