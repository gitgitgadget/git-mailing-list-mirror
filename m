From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] string-list.h: Add STRING_LIST_INIT macro and make use
 of it.
Date: Sat, 26 Jun 2010 18:04:25 -0500
Message-ID: <20100626230425.GA2265@burratino>
References: <ef57c1f7439b43564af4ec88ddf100a9a908b745.1277591559.git.tfransosi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 27 01:04:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OSeQb-00041v-MB
	for gcvg-git-2@lo.gmane.org; Sun, 27 Jun 2010 01:04:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754546Ab0FZXEo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jun 2010 19:04:44 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:52197 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754429Ab0FZXEn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jun 2010 19:04:43 -0400
Received: by iwn41 with SMTP id 41so3195425iwn.19
        for <git@vger.kernel.org>; Sat, 26 Jun 2010 16:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=+b01odW4i7nVc9At0rMBt8VWB0iZViwBXbimb/Y0Dmk=;
        b=SV6RL/XFnGHDLHj8JcYent64JXwMIAWJPeVhgAovnFpxdaGx+lK2iT9brjByZZGHEe
         qy8rllERLTkEIDJoweYoxUyRkGCRCTZhZS9B8sAstEdN1ZU362m9kwIdDAndm6gfs/vq
         u8QZ3dQ8lGiveW1DmrS1KJs32/ZcmCEnoztnI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=tsPXeMUCqGuSXAjGjE66NecdmPKb+5UqF2u4xE0c4uEF4D36Xom5SqUYwwfZzjkuEN
         4VNr5GpyU+ddI5ylQjHacYS4+uDZHLnjQmMftCN8ueRONQTa7tkhGwixsqGUfCmxY/IM
         4gM3n6q2yPO4O6MlrkJdhSA7m/hh4IVz1STQM=
Received: by 10.231.145.85 with SMTP id c21mr2773843ibv.104.1277593482940;
        Sat, 26 Jun 2010 16:04:42 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id g8sm931113ibb.11.2010.06.26.16.04.40
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 26 Jun 2010 16:04:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <ef57c1f7439b43564af4ec88ddf100a9a908b745.1277591559.git.tfransosi@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149781>

Thiago Farina wrote:

>  builtin/fast-export.c  |    2 +-
>  builtin/fetch.c        |    8 ++++----
>  builtin/receive-pack.c |    2 +-
>  builtin/remote.c       |    4 ++--
>  builtin/show-ref.c     |    2 +-
>  remote.c               |    4 ++--
>  string-list.h          |    2 ++
>  7 files changed, 13 insertions(+), 11 deletions(-)

 $ git grep -e 'string_list.*=' origin/master | grep { | grep -v 1 |
 > wc -l
 16
 $ git grep -e 'string_list.*=' origin/master | grep { | grep -v 1 |
 > cut -d: -f2 | uniq
 builtin/fast-export.c
 builtin/fetch.c
 builtin/mv.c
 builtin/receive-pack.c
 builtin/remote.c
 builtin/show-ref.c
 merge-recursive.c
 remote.c
 transport-helper.c

Looks like you missed a few.  Still,

Acked-by: Jonathan Nieder <jrnieder@gmail.com>
