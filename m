From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: git-log --parents broken post v1.3.0
Date: Thu, 4 May 2006 00:10:00 +1200
Message-ID: <46a038f90605030510x6d582804w6c0d2fec60bd56e5@mail.gmail.com>
References: <46a038f90605030456q679ceebcsa037b834bced9ca2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Wed May 03 14:10:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FbGBC-0007Qa-0J
	for gcvg-git@gmane.org; Wed, 03 May 2006 14:10:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965166AbWECMKB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 May 2006 08:10:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965167AbWECMKB
	(ORCPT <rfc822;git-outgoing>); Wed, 3 May 2006 08:10:01 -0400
Received: from wr-out-0506.google.com ([64.233.184.228]:34707 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S965166AbWECMKA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 May 2006 08:10:00 -0400
Received: by wr-out-0506.google.com with SMTP id 68so114184wri
        for <git@vger.kernel.org>; Wed, 03 May 2006 05:10:00 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JWXd5ZNoPtEQoRQsyYCGANJu97GLfhaH3HkvqMsEnyNrBc+GwDSgMnwUnXie+cTYlnuFXdY9HPCgkf7BrNSLjIWBdKYdJG0pS1kM8KyWiyRec88T83m5yMoJ+6B8MCd6GKgbMDzTcmmICI3iKtfN5vfnd7orck+YZrjgVDenKRU=
Received: by 10.54.102.9 with SMTP id z9mr33004wrb;
        Wed, 03 May 2006 05:10:00 -0700 (PDT)
Received: by 10.54.127.4 with HTTP; Wed, 3 May 2006 05:10:00 -0700 (PDT)
To: git <git@vger.kernel.org>, "Junio C Hamano" <junkio@cox.net>,
	"Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <46a038f90605030456q679ceebcsa037b834bced9ca2@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19478>

On 5/3/06, Martin Langhoff <martin.langhoff@gmail.com> wrote:
> Soon after v1.3.0 git-log --parents got broken. When using --parents,

Ok -- perhaps that was a bit of a rushed statement. Reading back on
the archives, it seems like it may have been intentional. The new
header format is more succint, but while technically I can fish the
data at the porcelain layer, it is quite convenient to get it directly
from the commit header. Specially given that git-log has the info at
that time...

I have to confess, I don't quite follow the changes happening in that
series of commits. If --parents is really not coming back I'll change
the log entry parsing in cvsserver. However, I suspect git-log should
error out on it ("fatal: deprecated option") so porcelains break
explicitly, rather than silently.

cheers,


martin
