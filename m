From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: update-index --assume-unchanged doesn't make things go fast
Date: Wed, 25 Jun 2008 14:02:04 -0400
Message-ID: <32541b130806251102l6e71a050o82fbd4f272d1d23f@mail.gmail.com>
References: <32541b130806250944x717cf609x7aa520c77a7c6911@mail.gmail.com>
	 <g3tvqd$2jj$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Michael J Gruber" <michaeljgruber+gmane@fastmail.fm>
X-From: git-owner@vger.kernel.org Wed Jun 25 20:03:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBZKj-0004y3-LL
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 20:03:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752591AbYFYSCJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 14:02:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752263AbYFYSCI
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 14:02:08 -0400
Received: from fk-out-0910.google.com ([209.85.128.191]:5598 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751631AbYFYSCG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 14:02:06 -0400
Received: by fk-out-0910.google.com with SMTP id 18so3324067fkq.5
        for <git@vger.kernel.org>; Wed, 25 Jun 2008 11:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=tJUDPDQgwmmliDWdV26SH9bca+dlKVbYKnLZaptEmtU=;
        b=AJ6ah4Tu32Ug3B7u/Zm5d2YUNrrajnLPPC/tJBEyUFf49ckqM0uQEu7Y0ASf3hraXE
         kk8LI9pJEvB59N5UCKZp68fFvXSJz6ywifQC5dTuSX672SM1rnfGxq9kr7alJBs8atLn
         XSDDZEVOJwCDi87jcLFxXaYZM7feaVSkedqPo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Kim6HAuY1YnExBXkyNUPv8cDPZkBJhoKEGRaJLwbUxq+7K3ZHCH4Uuo0vFG26XkBOY
         UrBDcsLWWrPjO+z5vG4X8ZFk5Hmo+Bc2zNWQYLeJ1jSkv2QExVNu9YRilfolflf1LuNB
         C2TjHBup1KzLdsrrvPCckR7veJG5SGG4G/F4Q=
Received: by 10.82.135.7 with SMTP id i7mr657349bud.42.1214416924972;
        Wed, 25 Jun 2008 11:02:04 -0700 (PDT)
Received: by 10.82.175.10 with HTTP; Wed, 25 Jun 2008 11:02:04 -0700 (PDT)
In-Reply-To: <g3tvqd$2jj$1@ger.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86313>

On 6/25/08, Michael J Gruber <michaeljgruber+gmane@fastmail.fm> wrote:
> > 4) My idea is to eventually --assume-unchanged my whole repository,
> > then write a cheesy daemon that uses the Win32 dnotify-equivalent to
> > watch for files that get updated and then selectively
> > --no-assume-unchanged files that it gets notified about.  That would
> > avoid the need to ever synchronously scan the whole repo for changes,
> > thus making my git-Win32 experience much faster and more enjoyable.
> > (This daemon ought to be possible to run on Linux as well, for similar
> > improvements on gigantic repositories.  Also note that TortoiseSVN for
> > Windows does something similar to track file status updates, so this
> > isn't *just* me being crazy.)
>
>  Looks like users on slow NFS would profit, too. Hate to say it, but hg
> feels faster on (slow) NFS than git. Yet I use git, for other reasons ;)

Hmm, can you do dnotify over NFS?

I'd like to know how hg goes any faster.  As far as I can see, git is
going as fast as can be without some kind of daemon or other magic.
(Except for my point #3, which seems relatively minor.)

Thanks,

Avery
