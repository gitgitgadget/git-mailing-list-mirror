From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [WIP PATCH] Add 'git fast-export', the sister of 'git fast-import'
Date: Fri, 23 Nov 2007 19:31:19 +0700
Message-ID: <fcaeb9bf0711230431x1b0432f6uc9472b2f67514463@mail.gmail.com>
References: <Pine.LNX.4.64.0711210336210.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Nov 23 13:31:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvXh8-0005pA-2q
	for gcvg-git-2@gmane.org; Fri, 23 Nov 2007 13:31:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755746AbXKWMbW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Nov 2007 07:31:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755771AbXKWMbW
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Nov 2007 07:31:22 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:47808 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755746AbXKWMbV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2007 07:31:21 -0500
Received: by nf-out-0910.google.com with SMTP id g13so2758200nfb
        for <git@vger.kernel.org>; Fri, 23 Nov 2007 04:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=CxwY59dDGX1wI6fd891lsbLE1UGirhWjGwp4YA5Sqs4=;
        b=pyVBU+eLJNQWwbOsjV9GqUuKVVAwncYiVkRBByN9OWBakJUMwuX1/WbneqYA901baZlbxu4X1niJ5oQJOQzSQ+OynK7iEDP6swnQhAsQMYQeSjunWExT2SmlYALC1G4m2T8MBqkYqSgshdh1hWzei2GPH9WH+2ZypIZUqwElJIo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qrN5++ahxmKJB+/2xCqYdlslbCoqKvrZsKDM7ogYiwZcMSgwdR/2I0D7IT5gW6CJ0XOL120U9Ki1b8zSwy4eYZigWxQj/fUh3RRTj0as/r5KQMcvmfFUGJs9hVsXRJ7EBTXGmNrm5gZhKiHHADXtOc36okScZORnHheG/K9TIZM=
Received: by 10.86.49.13 with SMTP id w13mr9504129fgw.1195821079693;
        Fri, 23 Nov 2007 04:31:19 -0800 (PST)
Received: by 10.86.68.16 with HTTP; Fri, 23 Nov 2007 04:31:19 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0711210336210.27959@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65896>

On Nov 21, 2007 10:40 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> [WIP: this does not handle tags yet, and it lacks a test script
>  as well as documentation.]
>
> This program dumps (parts of) a git repository in the format that
> fast-import understands.
>
> For clarity's sake, it does not use the 'inline' method of specifying
> blobs in the commits, but builds the blobs before building the commits.B
>
> ---
>         I am way too tired now to continue, but maybe someone else wants
>         to pick up the ball.

Well, I would better be back on setup_git_directory() than picking up
the ball. I have a suggestion though. git-fast-export and
git-fast-import should support bundle. Bundle is very handy for
transferring a bunch of commits, but it does not (cannot?) hold tags
and branches. With git-fast-{im,ex}port, we will have a perfect
transportation for disconnected development.

>         Oh, and it relies on "int" being castable to void * and vice
>         versa.  Is anybody aware of a platform where this can lead to
>         problems?
>
>         And yes, I will add a copyright when I woke up again.
-- 
Duy
