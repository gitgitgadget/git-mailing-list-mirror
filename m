From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: Re: How to prevent changes to repository by root
Date: Wed, 16 Jun 2010 17:09:51 +0200
Message-ID: <20100616150951.GA13073@vidovic>
References: <AANLkTikLixhYITdJKMFb3Hw2hZvaas1DtiV3x9ThCTZz@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
To: Nazri Ramliy <ayiehere@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 16 17:10:16 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOuFm-0003LW-Qg
	for gcvg-git-2@lo.gmane.org; Wed, 16 Jun 2010 17:10:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758909Ab0FPPKD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jun 2010 11:10:03 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:34964 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758772Ab0FPPKA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jun 2010 11:10:00 -0400
Received: by wyb40 with SMTP id 40so5785738wyb.19
        for <git@vger.kernel.org>; Wed, 16 Jun 2010 08:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=cYDfQWZCwe4BoZHfsHM1hZYd7kXeC64eV0i5zDwR0h8=;
        b=TBC9jQYtunyOSxpHmKCQ5q55g0cR/Tx65B0Bc2+zR45iMgtsmrij22PljCjAln41Tf
         Q/+rC7fdz8vHkNI/uvnsQoHh1Zsc5SECJu2KKEkqflJ7GzSbXWXEVOVil+v8AixuTpjt
         pBWc4aTIiNYADt6QTMGWjq4Ec1NloOG7HCuzs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ZDz5pl8+2KaxnT526s6lPH3F4qdj/kqZd8j22/3HwDYAED1J4TGVq5NJf4E6zPRmQy
         cdzkXgy6PmDhZgQC10LBKodeZS6V83L2etJvePD6g5OxVzrOtf4k3eWBQjQoNe3xfafb
         MNbvGRzJcWokmmhrroCelgr9ME/oRwXN5zzV8=
Received: by 10.227.143.206 with SMTP id w14mr8698834wbu.219.1276700998320;
        Wed, 16 Jun 2010 08:09:58 -0700 (PDT)
Received: from @ (88-121-122-184.rev.libertysurf.net [88.121.122.184])
        by mx.google.com with ESMTPS id g66sm2324744wej.25.2010.06.16.08.09.55
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 16 Jun 2010 08:09:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTikLixhYITdJKMFb3Hw2hZvaas1DtiV3x9ThCTZz@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149261>

The 14/06/10, Nazri Ramliy wrote:

> I have a git repository owned by a non-privileged user account on a
> machine that is logged into (via ssh) by multiple users. These multiple users,
> all of them (not at at the same time) do "git pull" on this repository.
> 
> Everything is fine as long as they don't do the "git pull" as root.
> 
> Murphy's law and all, someone is bound to do "git pull" as root on that repo
> and that would sometime cause problem for the non-privileged user (who 'own')
> the git repo to do subsequent git operations on that repository.
> 
> My question is:
> 
> How do I limit any action on this repository to this non-privileged user only?

Don't give root access to your users. This is the only sane thing to do
in the unix world. ,-p

-- 
Nicolas Sebrecht
