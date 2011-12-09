From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 3/9] revert: tolerate extra spaces, tabs in insn sheet
Date: Sat, 10 Dec 2011 01:45:39 +0530
Message-ID: <CALkWK0n3-X3EXptFqSB_L3eAsu-5LXsM3jJETPf3pN5C3ghSSg@mail.gmail.com>
References: <1323445326-24637-1-git-send-email-artagnon@gmail.com>
 <1323445326-24637-4-git-send-email-artagnon@gmail.com> <7vty59ec6w.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 09 21:16:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZ6rY-0006Xr-IZ
	for gcvg-git-2@lo.gmane.org; Fri, 09 Dec 2011 21:16:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754776Ab1LIUQB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Dec 2011 15:16:01 -0500
Received: from mail-qw0-f53.google.com ([209.85.216.53]:37742 "EHLO
	mail-qw0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754773Ab1LIUQA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Dec 2011 15:16:00 -0500
Received: by qadb15 with SMTP id b15so3163494qad.19
        for <git@vger.kernel.org>; Fri, 09 Dec 2011 12:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=EGj+o5i4IFmi8HyJmeiP5uxo0l5qGimwC04v5q/fcmQ=;
        b=aNxZSBmRViWs0BZNs+TsO288vZy9g9rcuPQoHWRC/nTKKpg8RINwGvuoEQwcsU4W+g
         SQsLxC5D9Sg7WxHCfoq2kz8gPNUXQjk2UZ9KwEdrXUt/8IvthyT1XWqQz3m9ZliFa6+Q
         GKIPvOjGVtSPcC7kTF87/fpFeVzU/6PorIWb0=
Received: by 10.224.180.131 with SMTP id bu3mr8584815qab.5.1323461760185; Fri,
 09 Dec 2011 12:16:00 -0800 (PST)
Received: by 10.229.165.194 with HTTP; Fri, 9 Dec 2011 12:15:39 -0800 (PST)
In-Reply-To: <7vty59ec6w.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186680>

Hi Junio,

Junio C Hamano wrote:
> Also if you are using strcspn() why use a hand-rolled loop instead of
> strspn()?

Honestly, it didn't occur to me: this is the first time I'm using
either strcspn() or stcspn().

Thanks.

-- Ram
