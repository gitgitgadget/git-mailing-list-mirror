From: Ping Yin <pkufranky@gmail.com>
Subject: Re: What the best git repack option to avoid out of memory (2G free memory)
Date: Sun, 17 Apr 2011 11:32:44 +0800
Message-ID: <BANLkTi=ABGrsUCxpB6fUXCP0477iq=irhw@mail.gmail.com>
References: <BANLkTimOnuSsSeuZ5QvLQLZBg1QnnDzaNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 17 05:33:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QBIjO-0004KR-Ir
	for gcvg-git-2@lo.gmane.org; Sun, 17 Apr 2011 05:33:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753622Ab1DQDcr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Apr 2011 23:32:47 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:41743 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752101Ab1DQDcp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2011 23:32:45 -0400
Received: by bwz15 with SMTP id 15so3042062bwz.19
        for <git@vger.kernel.org>; Sat, 16 Apr 2011 20:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:content-type;
        bh=Xjy/9qq7RJJnMtV4BV2jHSoStUnAqNU9XFYawXXnemw=;
        b=LOhmABwgsaqOWEUqXDH33Q/oRWfoqr0SO4DmEpHrFbAPfZIG4y25s0NriVniWaaPsd
         E0peZbBPeGHLL0gykH4VDsalxr6PrOmtL/MooxqqIIU6QdJ9TvTtLf6rYxfH0HBhHnzF
         Gvz4DbzPGpl7rcx5zb+LE2cF5nm2Iowvbd81s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        b=eXjhXcOTeB651Ks2gq0ylvxBv8jP3vlkjbo+l6ww/49lDUfjVqaV9LgcjXzV3BgGVA
         wMRBZ62z7XhKtnPqGKqWj2y2h45J9hfWel2wapU47X12/tnWjLA++G+TExSJwOkwUi60
         EeDenNu/s3Pps8xe/XUGlPwUhhAXKqdtROTSA=
Received: by 10.204.189.76 with SMTP id dd12mr306279bkb.206.1303011164355;
 Sat, 16 Apr 2011 20:32:44 -0700 (PDT)
Received: by 10.204.53.18 with HTTP; Sat, 16 Apr 2011 20:32:44 -0700 (PDT)
In-Reply-To: <BANLkTimOnuSsSeuZ5QvLQLZBg1QnnDzaNw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171711>

On Sun, Apr 17, 2011 at 11:24 AM, Ping Yin <pkufranky@gmail.com> wrote:
> When "gc --auto --aggressive --prune" android platform/prebuilt.git, i
> encountered the following error:
>
> Auto packing the repository for optimum performance.
> warning: suboptimal pack - out of memory
> fatal: Out of memory, malloc failed
> error: failed to run repack
>
> I have 2G free memory available and found the --window and
> --window-memory option in git repack. However, i wonder how to compute
> the max memory git-repack will use, is it "window * window-memory"?
>

Or "window * windowMemory * threads"?
