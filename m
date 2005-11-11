From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Strange merge conflicts against earlier merge.
Date: Fri, 11 Nov 2005 17:40:05 +1300
Message-ID: <46a038f90511102040n3e251252rce54117c51ce0429@mail.gmail.com>
References: <46a038f90511091638k726d605r170717539225a712@mail.gmail.com>
	 <20051110102043.GQ30496@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Nov 11 05:41:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaQin-0002V8-1B
	for gcvg-git@gmane.org; Fri, 11 Nov 2005 05:41:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932340AbVKKEkH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Nov 2005 23:40:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932341AbVKKEkH
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Nov 2005 23:40:07 -0500
Received: from zproxy.gmail.com ([64.233.162.204]:61963 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932340AbVKKEkG convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Nov 2005 23:40:06 -0500
Received: by zproxy.gmail.com with SMTP id x3so646411nzd
        for <git@vger.kernel.org>; Thu, 10 Nov 2005 20:40:05 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KJNLpMuQhj8RCPQapk/9JnDXwySwc5/M9V9h3/8gu+JOja7YZRRwWfshABMMX13ESYAhNmxventPXyLRm0/ZdhCJfCBaZ62l5baA8eCg27rflBjpGM2+8NXZ7zCWUx9+UtCLktDBI7rKpkIFR3Ym2Jn32aryXI3WTJG19jZafVw=
Received: by 10.65.197.18 with SMTP id z18mr1850200qbp;
        Thu, 10 Nov 2005 20:40:05 -0800 (PST)
Received: by 10.64.242.4 with HTTP; Thu, 10 Nov 2005 20:40:05 -0800 (PST)
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20051110102043.GQ30496@pasky.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11554>

On 11/10/05, Petr Baudis <pasky@suse.cz> wrote:
> Interesting. Could you check what the merge base is?
>
>         git-merge-base local remote
>
> It should be the merge from (1).

It seems to be actually one of the parents, not the merge itself.

> > For an example, clone
> > http://locke.catalyst.net.nz/git/moodle.git#mdl-artena-tairawhiti and
> > register also the
> > http://locke.catalyst.net.nz/git/moodle.git#mdl-local branch. Create
> > two heads:
>
> Could you please run git-update-server-info over there?

Should be fixed now...

cheers,


martin
