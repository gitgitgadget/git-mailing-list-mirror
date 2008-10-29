From: "Felipe Contreras" <felipe.contreras@gmail.com>
Subject: Re: [PATCH] Implement git-staged, an alias for 'git diff --cached'.
Date: Wed, 29 Oct 2008 21:49:09 +0200
Message-ID: <94a0d4530810291249x3a1c499xb5dde96de1ac39b3@mail.gmail.com>
References: <1225237145-95435-1-git-send-email-dsymonds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: "David Symonds" <dsymonds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 29 20:50:27 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvH3i-0000Q1-DF
	for gcvg-git-2@gmane.org; Wed, 29 Oct 2008 20:50:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753323AbYJ2TtM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Oct 2008 15:49:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753172AbYJ2TtL
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Oct 2008 15:49:11 -0400
Received: from rv-out-0506.google.com ([209.85.198.239]:14528 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753171AbYJ2TtK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Oct 2008 15:49:10 -0400
Received: by rv-out-0506.google.com with SMTP id k40so163501rvb.1
        for <git@vger.kernel.org>; Wed, 29 Oct 2008 12:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=NiQaSZWdwyU0z0boLoKSNOgV5MPdk+wi4B5inUF9lqk=;
        b=XRU9QF9d53l7ohHOvapkZMuTTmcrrn+Lsd70KyRvF0V/FRCY0gHdcoS4cjzo7S1btB
         zD7lj3cpd8hXzZRecL/kpMo2mBYlysYHrO3SQ/CXbJPA6Vy7X3LdKigNyzz6CHWpu1M4
         lUP8KyW/JJVN3vVDxbFcO++qpnLK0ZZI1OT50=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=xezNomqODJjmUtmjm90Igp2nMs+VP8zmCI37v7sc6irzPoy6uRC7a1NvD6chJNWXg5
         e68COT6TJSR9o5zGGniWWQCd3H3JyNWHhWQBSR/iLD7jCrt/8visNJM7IjsMsUAzLrP4
         15oZpi53+aOWHR6F3U7fQF2bABmbcvD/TV1JI=
Received: by 10.141.116.17 with SMTP id t17mr5116086rvm.251.1225309749384;
        Wed, 29 Oct 2008 12:49:09 -0700 (PDT)
Received: by 10.140.166.19 with HTTP; Wed, 29 Oct 2008 12:49:09 -0700 (PDT)
In-Reply-To: <1225237145-95435-1-git-send-email-dsymonds@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99398>

On Wed, Oct 29, 2008 at 1:39 AM, David Symonds <dsymonds@gmail.com> wrote:
> Signed-off-by: David Symonds <dsymonds@gmail.com>
> ---
>  This isn't a particularly serious patch, but is very relevant to our
>  current discussion at GitTogether '08.

I've thought about some commands like:
git stage $file (git add $file)
git unstage $file (git reset $file)

Perhaps
git stage add
git stage rm

And then your proposal would fit with:
git stage diff

Or something like that.

-- 
Felipe Contreras
