From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: git-log --parents broken post v1.3.0
Date: Thu, 4 May 2006 10:14:23 +1200
Message-ID: <46a038f90605031514s18bc15d1r48dc03df6a7f3bd7@mail.gmail.com>
References: <46a038f90605030456q679ceebcsa037b834bced9ca2@mail.gmail.com>
	 <46a038f90605030510x6d582804w6c0d2fec60bd56e5@mail.gmail.com>
	 <Pine.LNX.4.64.0605030745550.4086@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: git <git@vger.kernel.org>, "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu May 04 00:14:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FbPc3-0005pm-Va
	for gcvg-git@gmane.org; Thu, 04 May 2006 00:14:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751381AbWECWOZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 May 2006 18:14:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751382AbWECWOZ
	(ORCPT <rfc822;git-outgoing>); Wed, 3 May 2006 18:14:25 -0400
Received: from wr-out-0506.google.com ([64.233.184.233]:39244 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751381AbWECWOY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 May 2006 18:14:24 -0400
Received: by wr-out-0506.google.com with SMTP id 68so228337wri
        for <git@vger.kernel.org>; Wed, 03 May 2006 15:14:24 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KEHKgAMXzl/eLSffiVZQnu25ELmQ0Nqdn66QTQtGlr2gyguBvDjGH5Q25iTbNbvsUcJYkZqabJqVfHW0E5uwC6+Zcdg0K4RjMkQS9Fpd53/lHlD7I3C824lOwCslprp15FKnVBDl6pEWTI6g5JZX6VeZne2QcMRMIKf3sSQzAwA=
Received: by 10.54.114.11 with SMTP id m11mr254723wrc;
        Wed, 03 May 2006 15:14:23 -0700 (PDT)
Received: by 10.54.127.4 with HTTP; Wed, 3 May 2006 15:14:23 -0700 (PDT)
To: "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605030745550.4086@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19526>

On 5/4/06, Linus Torvalds <torvalds@osdl.org> wrote:
> That said, I suspect a git-cvsserver kind of usage is better off using
> "git-rev-list --parents HEAD" instead, which didn't break in the first
> place.

After a good sleep, I woke up thinking exactly the same. Patch coming soon.


m
