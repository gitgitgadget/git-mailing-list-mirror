From: Michael Witten <mfwitten@gmail.com>
Subject: Re: With feature branches, what is ever committed directly to master
Date: Tue, 10 Aug 2010 14:15:47 -0500
Message-ID: <AANLkTik5MdbSFAN83B1D3ZbPmUutQ3ouqqAvYw+qECS1@mail.gmail.com>
References: <AANLkTin0VgH8CvnUn_tCJPTkhh7Ce-tYWo52qouoVvRN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Bradley Wagner <bradley.wagner@hannonhill.com>
X-From: git-owner@vger.kernel.org Tue Aug 10 21:16:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OiuJG-0004wT-70
	for gcvg-git-2@lo.gmane.org; Tue, 10 Aug 2010 21:16:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933016Ab0HJTQW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Aug 2010 15:16:22 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:32796 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932524Ab0HJTQV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Aug 2010 15:16:21 -0400
Received: by fxm13 with SMTP id 13so924847fxm.19
        for <git@vger.kernel.org>; Tue, 10 Aug 2010 12:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=9bQQ0v1VUdqpzgBFcc85X4IBE3xQpnt+KDQWFiO26oM=;
        b=ZBR8FLcZjM3SOVNUPjjnt+shr2ezDY0adDHrwiACG+DgBi009dzuvtW9v0F90wWH6r
         M6JucJSmLt1kcCHm3nd86GgcRDSFB7rdOm3I91k1NvkhJtCiEsztKfYN08MxcOwM8ArW
         AcIR6CTZOeLFvznTZsjDbD7jkBtQWogoXSjSs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=BesvGJl2IUob+JKE6C+WbVshZ4dGR2oagxAY5ic8/TvaczCWZNpYVaean5tEQuzXFo
         adWrnGzfWJaQjNqTfKdqRC/I8r1Y8KNT4EGnHNJtL0vremJktljsovEcTYhqCf9pQomJ
         sFieLlistc45ohWuoGW6b8zfMtMKTv7qnvxQU=
Received: by 10.239.165.84 with SMTP id w20mr848446hbd.193.1281467777268; Tue, 
	10 Aug 2010 12:16:17 -0700 (PDT)
Received: by 10.239.186.139 with HTTP; Tue, 10 Aug 2010 12:15:47 -0700 (PDT)
In-Reply-To: <AANLkTin0VgH8CvnUn_tCJPTkhh7Ce-tYWo52qouoVvRN@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153142>

On Tue, Aug 10, 2010 at 14:02, Bradley Wagner
<bradley.wagner@hannonhill.com> wrote:
> what kind of stuff is ever committed
> directly to "master" or is master
> typically the place where things are
> merged into from other stable/features
> branches?
>
> Is "master" really even unstable at
> that point?
>
> Thanks in advance! I realize this
> question is pretty open-ended.

See here:

  http://git.kernel.org/?p=git/git.git;a=blob_plain;f=MaintNotes;hb=todo

The `master' branch is indeed considered the most stable version of
the software when it comes to the way `git' itself is maintained.
