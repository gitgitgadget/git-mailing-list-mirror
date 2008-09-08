From: "Bert Wesarg" <bert.wesarg@googlemail.com>
Subject: Re: [ANNOUNCE] Guilt v0.31
Date: Mon, 8 Sep 2008 20:50:03 +0200
Message-ID: <36ca99e90809081150v4ad6e7a0n72b5cca39e02b1bc@mail.gmail.com>
References: <20080908135244.GB27550@josefsipek.net>
	 <36ca99e90809081133s58e3d32h8b85804f5bb76902@mail.gmail.com>
	 <20080908184322.GE27550@josefsipek.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
	guilt@lists.josefsipek.net, "Brandon Philips" <brandon@ifup.org>
To: "Josef 'Jeff' Sipek" <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Mon Sep 08 20:51:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KclpS-0007Nw-R2
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 20:51:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753289AbYIHSuH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2008 14:50:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753129AbYIHSuH
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Sep 2008 14:50:07 -0400
Received: from wx-out-0506.google.com ([66.249.82.225]:51666 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752994AbYIHSuF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2008 14:50:05 -0400
Received: by wx-out-0506.google.com with SMTP id h27so248785wxd.4
        for <git@vger.kernel.org>; Mon, 08 Sep 2008 11:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=3ztpwC20SwuIz3Y3ADBJApvlE4AXOmL0fLnJ9K1Ij94=;
        b=viDOaAfAu2b2ypelPjxNOtF1ZDYBSKTVilu7MHLaC8NmOqATb9EKQWAh0f7nX6ror0
         rt8a6GQ4WCvJtyu3IQ8yiGMyq35gYD+OCstXeftQzwn/ElOn76ZaBt5o0ykdiCoTuunt
         lFsR3wodb6dQgIiP/0eD+zSwqMkCJRNzbqiX8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=kF3b9q3Y6d3TdQtBnkL05tV7YzIcIUUzRAfIv5WIvHWdZ4+X62Q4XbGDGsw8qcNnH0
         mbkKvBIkoqq4jv2r14wj7Fs3t0KJcc/+L0wmp+QzfY70CrRegcaIFJuJ1oV/OHgxUeKQ
         qzd+mtU5wBxh5R50PhVSK5laB4b5LXsYP462A=
Received: by 10.100.165.13 with SMTP id n13mr16006624ane.155.1220899803995;
        Mon, 08 Sep 2008 11:50:03 -0700 (PDT)
Received: by 10.70.49.12 with HTTP; Mon, 8 Sep 2008 11:50:03 -0700 (PDT)
In-Reply-To: <20080908184322.GE27550@josefsipek.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95289>

On Mon, Sep 8, 2008 at 20:43, Josef 'Jeff' Sipek <jeffpc@josefsipek.net> wrote:
> On Mon, Sep 08, 2008 at 08:33:23PM +0200, Bert Wesarg wrote:
>> Hi,
>>
>> On Mon, Sep 8, 2008 at 15:52, Josef 'Jeff' Sipek <jeffpc@josefsipek.net> wrote:
>> > Guilt v0.31 is available for download.
>>
>> Is it possible to include pre-generated docs in the tarballs?
>>
>> I downloaded one and run 'make doc' and get these messages:
>>
>> fatal: Not a git repository
>>
>> which looks like it comes from this line in Documentation/Makefile:
>>
>> VERSION=$(shell git describe)
>>
>> Its not critical, but looks awkward.
>
> 1) I already commit generated man pages for each release - on the man branch
>   (there's also html branch with the html-formated man pages).
>
> 2) I'm aware of the git error you saw, and it is on my todo list
>
> 3) I just checked the git tarballs, and they don't include man pages either.
>   Should I include the manpages in the source tarball, or should I just
>   create another tarball with the manpages? (The git error will get fixed
>   regardless - that's the only invocation of git during the manpage build
>   process, and it's there only to get a nice looking version number to
>   include in the manpages.)
I must admit, that I don't like these extra tarballs with docs. I
always expect, that the manpages are nicely installed if I type 'make
install' (or at least with a install-doc target). But I need to
download this extra package, and extract it to the right place, there
is no Makefile whatsoever. In case of git its really annoying, because
the help mechanism is relying on the manpages (i.e. git help <cmd> or
git <cmd> --help, but you know this).

Thanks
Bert
>
> Josef 'Jeff' Sipek.
