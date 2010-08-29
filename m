From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH 02/13] fast-export: support done feature
Date: Mon, 30 Aug 2010 07:42:45 +0800
Message-ID: <AANLkTikx__RWGhxZUtdOKJy=X=0trfdnd50tcstHhRO3@mail.gmail.com>
References: <1283053540-27042-1-git-send-email-srabbelier@gmail.com>
	<1283053540-27042-3-git-send-email-srabbelier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 30 01:42:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OprWX-0002JM-PM
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 01:42:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753964Ab0H2Xmr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Aug 2010 19:42:47 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:40341 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752192Ab0H2Xmr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Aug 2010 19:42:47 -0400
Received: by eyg5 with SMTP id 5so2865017eyg.19
        for <git@vger.kernel.org>; Sun, 29 Aug 2010 16:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=tLsebB9MN+7c27mwrJK0dCpPHURsSeQ8XS8q6DStr+Q=;
        b=Kge1mFy0r+5RPPnCnVdnFud4xsJBjv6cC0iMf0lXydJQ2ascPce1kATnzGbYUoXJBm
         FLkjWO0RI8W9tGXDOrzgyliaCJ1CzAr48NVvj99mPVjI1bv5Ly7YOZvVk4bC+Ioh8Nky
         x+kOImgJYP2LvYIrwNuo9BgSIASuqhzEv37KQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=cSS6NQBWYnIxQsplABTJG23DRldZ4vwyaqufC715sY8J2OgMaG7gRfsZy6fvzPzWhs
         FLCL2UkvFKrH4jqDNtOdZdqCSvzbdV+dsdB2vWhRWc1UoO63vknvyH6j92N64e8TcAmB
         zmg2CpE8fM2X93ap+YXpsH4Zt3sPDMN4fVqcY=
Received: by 10.213.35.72 with SMTP id o8mr6862909ebd.80.1283125365787; Sun,
 29 Aug 2010 16:42:45 -0700 (PDT)
Received: by 10.213.28.201 with HTTP; Sun, 29 Aug 2010 16:42:45 -0700 (PDT)
In-Reply-To: <1283053540-27042-3-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154733>

Hi,

On Sun, Aug 29, 2010 at 11:45 AM, Sverre Rabbelier <srabbelier@gmail.com> wrote:
> If fast-export is being used to generate a fast-import stream that
> will be used afterwards it is desirable to indicate the end of the
> stream with the new 'done' command.
>
> Add a flag that causes fast-export to end with 'done'.

For a user, what are the advantages of running it with the
--use-done-feature? Perhaps this should just be made a
non-configurable default (ie. always use it) to save the user from
some thinking.

-- 
Cheers,
Ray Chuan
