From: Eric Wong <normalperson@yhbt.net>
Subject: Re: GSoC proposal for svn remote helper
Date: Sat, 9 Apr 2011 23:19:31 +0000
Message-ID: <20110409231931.GA24345@dcvr.yhbt.net>
References: <BANLkTinYyxxkZpmEF2PYXMb_BjCVcbTkYw@mail.gmail.com> <BANLkTinHE-E5_mK8aKYv2f7yExVvfOFVRw@mail.gmail.com> <20110408052126.GA22256@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dmitry Ivankov <divanorama@gmail.com>, git@vger.kernel.org,
	artagnon@gmail.com, david.barr@cordelta.com, srabbelier@gmail.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 10 01:19:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8hRK-0000oQ-8w
	for gcvg-git-2@lo.gmane.org; Sun, 10 Apr 2011 01:19:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755818Ab1DIXTd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Apr 2011 19:19:33 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:48457 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755794Ab1DIXTc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Apr 2011 19:19:32 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E0001F4F1;
	Sat,  9 Apr 2011 23:19:32 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20110408052126.GA22256@elie>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171224>

Jonathan Nieder <jrnieder@gmail.com> wrote:
> [1] git-svn.perl is a work of art and a wonder to behold, and if your aim
> is to make a compatible replacement for it, the first step will be to
> understand its design deeply.  And the thing is, that much, while
> valuable anyway, is pretty hard already.

Thanks.  I credit the use of automated tests for making things work
as well as it does, especially given how ugly the code has gotten.

I think the first step to understanding much of it is to split the
modules into individual files and then understanding the test cases.

> and people rely a lot on an odd coincidence:
> 
>  - using "git svn clone" twice with the same configuration on the same
>    repository will, at least most of the time, give the same commit
>    names.

I did design that in mind when I first started, I'm glad it still mostly
works after all this time :)

> That is the dream.

*My* dream was to replace Subversion and get people using git.  git-svn
was designed to be self-obsoleting from the start.  For the most part
I consider it a success since I no longer need to use it :)

-- 
Eric Wong
