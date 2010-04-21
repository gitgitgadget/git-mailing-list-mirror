From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: git pull behavior changed?
Date: Wed, 21 Apr 2010 23:22:47 +0200
Message-ID: <v2hfabb9a1e1004211422ybbf47ef0gd5dfd1791eb03c16@mail.gmail.com>
References: <u2z3abd05a91004211413rcd2440fdq7946ef4764b24362@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git list <git@vger.kernel.org>
To: Aghiles <aghilesk@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 21 23:23:20 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4hO9-0002fl-Kc
	for gcvg-git-2@lo.gmane.org; Wed, 21 Apr 2010 23:23:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755848Ab0DUVXM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Apr 2010 17:23:12 -0400
Received: from mail-bw0-f209.google.com ([209.85.218.209]:49338 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755593Ab0DUVXL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Apr 2010 17:23:11 -0400
Received: by bwz1 with SMTP id 1so10706972bwz.2
        for <git@vger.kernel.org>; Wed, 21 Apr 2010 14:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type;
        bh=kTtxyJ2hedQ183rZC8sk0tnEVwjZfI4gS4oxh8eu+nc=;
        b=LnNPBJimrK3PgckgCd3qIBEtt8VKdPb305Gvsxr3ECRrW/Xzcz3uXBJP/oGsAZqpd+
         xGoZVkt6gI1cGEd2kM9qeBEXvX1f5rMQVPaAZg0bACyDWBwzGCe9USu2WpGQ/U6HqK/M
         6kH/uYuiNBEAedDQ4F8oG7itiqJU4uOChVcvI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=J2Qhuae/0EBEG2qxpotSQDD8SnM2DTtHz2WkDtDrJldLxNPYDBiN6QjdxgDRclfutc
         XFRryFLfTB8J4fogNLgNIp2cdVozKNqz3jG1zlElHjJ6pesLlzdRwsmaIzKgjh+Z14M6
         ugp5SaRP55idxVqzUHhaagXAn/HSkmw7pkdCw=
Received: by 10.103.168.14 with HTTP; Wed, 21 Apr 2010 14:22:47 -0700 (PDT)
In-Reply-To: <u2z3abd05a91004211413rcd2440fdq7946ef4764b24362@mail.gmail.com>
Received: by 10.102.14.25 with SMTP id 25mr1727934mun.30.1271884988117; Wed, 
	21 Apr 2010 14:23:08 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145459>

Heya,

On Wed, Apr 21, 2010 at 23:13, Aghiles <aghilesk@gmail.com> wrote:
> git checkout -b test

When you do this you're telling git "I want a new branch from where I
am right now". If you want to be able to pull in a similar way to how
master works, use the '--track' option.

-- 
Cheers,

Sverre Rabbelier
