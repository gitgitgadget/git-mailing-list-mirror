From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [BUG] git shortlog hangs in bare repo
Date: Fri, 23 Apr 2010 01:36:46 +0530
Message-ID: <y2kf3271551004221306i9a08c06bl7abad4e56c0bbc28@mail.gmail.com>
References: <u2i76c5b8581004221222ge8bb0b8cp55cb1f13d5f9692a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 22 22:08:24 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O52hD-0004FC-KM
	for gcvg-git-2@lo.gmane.org; Thu, 22 Apr 2010 22:08:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932243Ab0DVUHN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Apr 2010 16:07:13 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:60631 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932151Ab0DVUHI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Apr 2010 16:07:08 -0400
Received: by gwj19 with SMTP id 19so2260816gwj.19
        for <git@vger.kernel.org>; Thu, 22 Apr 2010 13:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type;
        bh=8sN7XM06liCohajYat1tntmziLU0RAva1gGqy2YRCJo=;
        b=hw4h9WK9/IaHf7Lg4NzW6U+GK18vySJJUnpy1ZCkLjEHDlMwQQuzHZl62oql6yyuKa
         V2V4mBzR8c71GPxAELUMHdWxxSPuw0Ub+osMrHVvuQXwwlXHGKXjwGkS63/MJ7ndFUKp
         JnUq4eWpigbFY651LyKs0WpcP17nCZwembzuI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=xkmSEkcfcOZ1KU5vyCw5eHMXgvDBR1z1AtyRmMWo7HaVqo7YLsXaBRyJO+eBLSkTLu
         qleGfvzdcPJTrcVdSb0iJQGNVzq+uraJtcIo34AqYfsJbDL/wSPgO4wn/EpBlRYzelhf
         rFYSc03ea/3yKzG3NIxW7f055vlaJgyyFW1A4=
Received: by 10.90.69.14 with HTTP; Thu, 22 Apr 2010 13:06:46 -0700 (PDT)
In-Reply-To: <u2i76c5b8581004221222ge8bb0b8cp55cb1f13d5f9692a@mail.gmail.com>
Received: by 10.91.7.2 with SMTP id k2mr5405278agi.108.1271966826128; Thu, 22 
	Apr 2010 13:07:06 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145553>

Hi,

> I have tried to run this command in order to get some stats from the
> mainline bare repo. The result is that "shortlog" hangs for long
> period of time and nothing happens. At the same time git log works OK.

As far as I can tell, this problem is already fixed in the latest
upstream version- expect it to be fixed in the next release.

-- Ram
