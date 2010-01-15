From: Janos Laube <janos.dev@gmail.com>
Subject: Re: [msysGit] [PATCH v2 02/14] mingw: implement syslog
Date: Sat, 16 Jan 2010 00:09:14 +0100
Message-ID: <9d6091531001151509m52cd1f4dk4035d313ca2de292@mail.gmail.com>
References: <1263591033-4992-1-git-send-email-kusmabite@gmail.com>
	 <1263591033-4992-3-git-send-email-kusmabite@gmail.com>
	 <9d6091531001151457v4c446b61k40c93f7c6180683d@mail.gmail.com>
	 <40aa078e1001151501s462802ffua3aec600ed38f516@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: msysgit@googlegroups.com, git@vger.kernel.org, j6t@kdbg.org,
	Mike Pape <dotzenlabs@gmail.com>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Sat Jan 16 00:09:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVvI8-0002op-TA
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jan 2010 00:09:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758599Ab0AOXJR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 18:09:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758597Ab0AOXJR
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 18:09:17 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:38633 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758259Ab0AOXJR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2010 18:09:17 -0500
Received: by bwz27 with SMTP id 27so1011044bwz.21
        for <git@vger.kernel.org>; Fri, 15 Jan 2010 15:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=1gG26NVXL8dKtjxv0iNMO9hzGcpDU5dW17ZN9pI6YhU=;
        b=HJzmaU2PJ67VN/SZz5gboh+siOEPV5aPe9J5twPRXG4nGEbAuACOWW/XoypAizC3GI
         QzjcGy4QPBhscHDHjsgUb5IB46bSqiJ/6tseaUrnI1ib5AZVduX0gqEbaXW2dwZBJ2gj
         S5Y/Ztbs9PN3t3s/gXvXD6SupVtiI3MhKEiLY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=gtXds8IJOwwyG/6rJ6/cYgnMidsRV8jUHZAAOTHcM/WkeO0jCHYImQZf5e3Z8hzljR
         li9TVNsi2WfqXL/0+Ya2FHJFIqiGZZKE7V0SrN9SSbRAKWdUw2+wgGk4XhUCprMWvVq2
         X7kJxSy2ked6xRg/JYzEhvt/v6ieSq/uEue+Q=
Received: by 10.204.16.81 with SMTP id n17mr1671327bka.102.1263596954907; Fri, 
	15 Jan 2010 15:09:14 -0800 (PST)
In-Reply-To: <40aa078e1001151501s462802ffua3aec600ed38f516@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137157>

> Since the code that use it isn't multi-threaded, I fail to see the
> point. In fact even if it were, I'm not sure I see the big point...
> especially since the "__thread"-keyword isn't used (AFAICT) at all in
> the git source code so far.

that's why i have put a question mark behind my sentence. it was just
an idea :-). it would allow different threads to be an own event
source. but yes, i wasn't sure how much git makes use of threads. if
it doesn't, it does not make much sense at the moment, indeed.

janos
