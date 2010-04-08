From: Tor Arntsen <tor@spacetec.no>
Subject: Re: ***SPAM*** Re: What's cooking in git.git (Apr 2010, #03; Wed, 07)
Date: Thu, 8 Apr 2010 11:14:56 +0200
Message-ID: <m2sd2d39d861004080214sedf4a65fm7e081d468f4d88f2@mail.gmail.com>
References: <7v6342ahx9.fsf@alter.siamese.dyndns.org>
	 <4BBD7228.8080403@viscovery.net>
	 <7vwrwi78t7.fsf@alter.siamese.dyndns.org>
	 <o2u4c8ef71004080201pdbdc7aa8j99500d7643c278c9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Fredrik Kuivinen <frekui@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 08 11:15:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nznpf-0000ML-3H
	for gcvg-git-2@lo.gmane.org; Thu, 08 Apr 2010 11:15:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753880Ab0DHJO6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Apr 2010 05:14:58 -0400
Received: from mail-fx0-f223.google.com ([209.85.220.223]:59632 "EHLO
	mail-fx0-f223.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751410Ab0DHJO5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Apr 2010 05:14:57 -0400
Received: by fxm23 with SMTP id 23so1858806fxm.21
        for <git@vger.kernel.org>; Thu, 08 Apr 2010 02:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:received:message-id:subject
         :from:to:cc:content-type;
        bh=Frc4Kpv1ZxGEv1o8+rgCdi+J8R8BrPc881aHrZkmRj8=;
        b=X1rMy0Q9rXdLh8xqFzOK6CeWbqUXAKhT0hRfS0panegAaq0j646HBKrunPfmhbYqDY
         zZpYchavJ0NQkd6WvLoXHre0w1SwJ9Qa9R6WbrQQXKDqnw5NPkawG4d7cRYMIQOu8ybJ
         sIESG8pF6iugzDDAJPj0OPAITQ3dFEpzJGQQU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        b=W+HOy8BHXYAvXpQjpqpqEpgY7KFJ4pEWQv4fDDFnZW6BklSqgEP613SEhPNcNTj+f1
         SJ4kK3y3qDV6YEfSMWsZ1es6OxkUhaXiJdYIUZERWRbCK1ouBjJJNt84ePVLodQcBpSw
         DNEa2zcM0dRPsSqeEYCzFDbcufjj5r6PEhc5E=
Received: by 10.239.179.197 with HTTP; Thu, 8 Apr 2010 02:14:56 -0700 (PDT)
In-Reply-To: <o2u4c8ef71004080201pdbdc7aa8j99500d7643c278c9@mail.gmail.com>
X-Google-Sender-Auth: 546b011b8b24b859
Received: by 10.239.192.65 with SMTP id d1mr1027353hbi.197.1270718096254; Thu, 
	08 Apr 2010 02:14:56 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144349>

On Thu, Apr 8, 2010 at 11:01, Fredrik Kuivinen <frekui@gmail.com> wrote:

> For some reason I looked at Issue 6 of the standard (a previous
> version, released in 2004). In that version pthread_mutexattr_settype
> and PTHREAD_MUTEX_RECURSIVE are optional. See
> http://www.opengroup.org/onlinepubs/009695399/basedefs/pthread.h.html
>
> However, it is probably best to just ignore the issue for now until
> some platform appears where pthreads is available but not recursive
> mutexes.

IRIX 6.2 has one of those early, primitive implementations. It doesn't
seem to have PTHREAD_MUTEX_RECURSIVE, even though it has pthread_mutex
functions.  Every other system I have (irix 6.5/solaris/aix) appears
to have PTHREAD_MUTEX_RECURSIVE.

-Tor
