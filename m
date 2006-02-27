From: "Adrien Beau" <adrienbeau@gmail.com>
Subject: Re: the war on trailing whitespace
Date: Mon, 27 Feb 2006 12:26:34 +0100
Message-ID: <94fc236b0602270326s3079d737l102d5728d59f0c98@mail.gmail.com>
References: <20060225174047.0e9a6d29.akpm@osdl.org>
	 <7v1wxq7psj.fsf@assigned-by-dhcp.cox.net>
	 <20060225210712.29b30f59.akpm@osdl.org>
	 <Pine.LNX.4.64.0602260925170.22647@g5.osdl.org>
	 <20060226103604.2d97696c.akpm@osdl.org>
	 <Pine.LNX.4.64.0602261213340.22647@g5.osdl.org>
	 <20060226202617.GH7851@redhat.com> <1141008633.7593.13.camel@homer>
	 <Pine.LNX.4.63.0602271004130.5937@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "MIke Galbraith" <efault@gmx.de>, "Dave Jones" <davej@redhat.com>,
	"Linus Torvalds" <torvalds@osdl.org>,
	"Andrew Morton" <akpm@osdl.org>, junkio@cox.net,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 27 12:26:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDgWV-0002h3-8d
	for gcvg-git@gmane.org; Mon, 27 Feb 2006 12:26:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188AbWB0L0g (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Feb 2006 06:26:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751195AbWB0L0g
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Feb 2006 06:26:36 -0500
Received: from zproxy.gmail.com ([64.233.162.204]:5189 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751188AbWB0L0f convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2006 06:26:35 -0500
Received: by zproxy.gmail.com with SMTP id 13so867456nzp
        for <git@vger.kernel.org>; Mon, 27 Feb 2006 03:26:35 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Dt7a33KemqGXSdsgQBkGu2lA0lG38QM7aVoDGFFRjBUxhjMAv48k9suHVEaA90r+7/aOAOPVl8bJW2dTY1xvlRqICNSUzHWfK1hPP4cPLFaP1MR84fslv/1jiXQBpwpAHID8tcVDQqJF1NnaEtANvCRA4dZlXEoWFG7eSalliQM=
Received: by 10.36.220.54 with SMTP id s54mr3820149nzg;
        Mon, 27 Feb 2006 03:26:34 -0800 (PST)
Received: by 10.36.250.33 with HTTP; Mon, 27 Feb 2006 03:26:34 -0800 (PST)
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0602271004130.5937@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16834>

On 2/27/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>
> there is a good reason not to enable the no-whitespace-at-eol checking in
> pre-commit by default (at least for *all* files) for git development:
>
>         Python.
>
> Just do a "/ $" in git-merge-recursive.py. These whitespaces are not an
> error, but a syntactic *requirement*.

No, they aren't.

A logical line that contains only spaces and tabs is ignored by
Python. (All the "dirty" lines in git-merge-recursive.py are such
lines.)

Besides, spaces, tabs and newlines can be used interchangeably to
separate tokens, so trailing whitespace is never *required*.

Hope this helps,

Adrien
