From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH v2 00/14] daemon-win32
Date: Fri, 15 Jan 2010 23:51:15 +0100
Message-ID: <40aa078e1001151451t657dcbdbk202c7374ac7f6724@mail.gmail.com>
References: <1263591033-4992-1-git-send-email-kusmabite@gmail.com>
	 <201001152327.23189.j6t@kdbg.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: msysgit@googlegroups.com, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Fri Jan 15 23:51:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVv0i-0004c6-MH
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jan 2010 23:51:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758556Ab0AOWvR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 17:51:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758552Ab0AOWvR
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 17:51:17 -0500
Received: from mail-ew0-f209.google.com ([209.85.219.209]:42860 "EHLO
	mail-ew0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758550Ab0AOWvQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2010 17:51:16 -0500
Received: by ewy1 with SMTP id 1so654693ewy.28
        for <git@vger.kernel.org>; Fri, 15 Jan 2010 14:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=+I0pHd9ONs5gxhDNAINqQPsyl5cfwGQDyNhHxX0Bnig=;
        b=mWkuHqQ5G/QIlATn5q4JXnD2QWkwTL6cm6mfemV5NsOyUgbaa+r/Gbx1gu4c33Jo1F
         0rlCmAjLfRp9GEQsFXgMGfdGVzSSLZJzwSCNq9i5PyFzm0GcV/dOMPkWO8VYrMoq6Vu7
         RTYQ8QMlPaqOnJOjFEJEXISCwHSJdO/1ccUt0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        b=c/ZsRZqo0YPG3CoNpXZfgeRHpI1AEHqfznnJhcZfDrieZRddGgOjHW/6jzFO/o6cKz
         3Lj6hRQJSYlOX7gU88eabB6IC0s8cXJVFEEk6I1McI7owlwy+zBAjM7al47PFj8NF8z0
         Vl58KId9Y5Vlu+rcZhoB4Pkl/C6PNEIZ19k2w=
Received: by 10.216.86.66 with SMTP id v44mr1069001wee.163.1263595875083; Fri, 
	15 Jan 2010 14:51:15 -0800 (PST)
In-Reply-To: <201001152327.23189.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137151>

On Fri, Jan 15, 2010 at 11:27 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> A very nicely done series. Thank you very much!
>
> On Freitag, 15. Januar 2010, Erik Faye-Lund wrote:
>> Here's the long overdue v2 of my daemon-win32 attempt. A lot
>> has happened since v1. Most importantly, I abandoned using
>> the async API to replace fork(), and went for explicitly
>> spawning child process that handle the connection.
>
> IOW, you run git-daemon recursively in inetd mode (almost). Let's see what
> people say about this approach.
>
> -- Hannes
>

Yes. Or, a subset of the inetd-mode.

-- 
Erik "kusma" Faye-Lund
