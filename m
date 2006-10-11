From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: Clueless bisect error message
Date: Wed, 11 Oct 2006 15:30:20 +0700
Message-ID: <fcaeb9bf0610110130r42afc270l8e0b5db0b9861c05@mail.gmail.com>
References: <fcaeb9bf0610110008g642da719pb17f7f52169097e2@mail.gmail.com>
	 <7vpsczuxj9.fsf@assigned-by-dhcp.cox.net>
	 <fcaeb9bf0610110050h4c3a56fbge19607ff0bc094af@mail.gmail.com>
	 <7v1wpfuv9d.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 11 10:30:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXZTv-00058j-7M
	for gcvg-git@gmane.org; Wed, 11 Oct 2006 10:30:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965170AbWJKIaW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Oct 2006 04:30:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965171AbWJKIaW
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Oct 2006 04:30:22 -0400
Received: from wx-out-0506.google.com ([66.249.82.235]:7336 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S965170AbWJKIaV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Oct 2006 04:30:21 -0400
Received: by wx-out-0506.google.com with SMTP id s14so146945wxc
        for <git@vger.kernel.org>; Wed, 11 Oct 2006 01:30:21 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cN5AqA0VgRjBE1Kmbo4CsCsuaKQWjL154gRpquqoi5CQEhoWW4UW8/atmolnepf514FDEXuP0aVhcWDzn5gZvoRYjM8EobiSO+oMF45AN058L7vj3J3A48m2ikTnhJF5g1Bza5iCbdKiysKiC+e4BMzeA2QH/V4A8RIt4tb/qUo=
Received: by 10.70.97.13 with SMTP id u13mr245009wxb;
        Wed, 11 Oct 2006 01:30:20 -0700 (PDT)
Received: by 10.70.46.13 with HTTP; Wed, 11 Oct 2006 01:30:20 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7v1wpfuv9d.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28705>

On 10/11/06, Junio C Hamano <junkio@cox.net> wrote:
> My point actually was that even a simple rewording is harder
> than it seems, because that cluelessness actually was introduced
> to help Cogito.  If we do not care about it, we can just reword
> it to say "Hey you are in the middle of another bisect, or maybe
> you left your bisect by doing git-checkout earlier?  In either
> case git-bisect --reset is your friend, oh, and we can run that
> for you now if you want".  We could even remove head-name in
> git-checkout when we see one.
>
> But I suspect that doing either of these things would harm
> Cogito users.  After cg-seek the user is not "in the middle of
> another bisect", and if we run "git bisect --reset" when we see
> head-name, it would probably break it too.
Thanks. Now I understand the issue. I'm sorry for my ignorant because
I haven't used cogito yet.

-- 
Duy
