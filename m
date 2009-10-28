From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] mergetool--lib: add p4merge as a pre-configured
 mergetool option
Date: Wed, 28 Oct 2009 02:00:24 -0700
Message-ID: <20091028090022.GA90780@gmail.com>
References: <d411cc4a0910271536u5817802at43f7477dd8ccabc7@mail.gmail.com>
 <20091027230043.GA11607@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Scott Chacon <schacon@gmail.com>, git list <git@vger.kernel.org>
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Wed Oct 28 10:00:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N34Ob-0002Kq-E2
	for gcvg-git-2@lo.gmane.org; Wed, 28 Oct 2009 10:00:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932736AbZJ1JA2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2009 05:00:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932718AbZJ1JA1
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 05:00:27 -0400
Received: from mail-yw0-f202.google.com ([209.85.211.202]:61995 "EHLO
	mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932717AbZJ1JA1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2009 05:00:27 -0400
Received: by ywh40 with SMTP id 40so447178ywh.33
        for <git@vger.kernel.org>; Wed, 28 Oct 2009 02:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=OxPLjMjhwrbPDg3h+OPzsLjgJsdSs1p6PfApG86hBBA=;
        b=mxnNXSUBbi7Ts6MTXgwghH1QM2WMRFMlNteKDfwhO/zzggPL5wCKAZCc7WholScXv4
         a0zzZTIDn6+S+haXznnLjLhgIZhgnQltU/D7H/5tQ2tSd37tvj25Ms3YF9GmVelHhlv/
         pxTomke0PXeWXsVyz2ar69CLTtfsHtsjp/q4s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=k2vfOXnol0TjnkesAOpIz7hMRcqU96RCdfQDDturPW+IdNkBjju1ASzl7TiTJRmvoo
         hGBH74dJKC7OLLxC5PGJaFsAX8XdRjDuW1PLdwMjfLi2mE/jb9gBNChTYATY14ZKOxEz
         kVFLRb8eW7NazfbH6sHphoYhpdsQTYikK78fs=
Received: by 10.91.26.31 with SMTP id d31mr88674agj.44.1256720431267;
        Wed, 28 Oct 2009 02:00:31 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id 9sm354739yxf.59.2009.10.28.02.00.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 28 Oct 2009 02:00:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20091027230043.GA11607@hashpling.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131436>

On Tue, Oct 27, 2009 at 11:00:43PM +0000, Charles Bailey wrote:
> On Tue, Oct 27, 2009 at 03:36:49PM -0700, Scott Chacon wrote:
> > p4merge is now a built-in diff/merge tool.
> > This adds p4merge to git-completion and updates
> > the documentation to mention p4merge.
> > ---
> 
> I approve (but haven't had a chance to test this). p4merge is a
> good mergetool, but now I'll have to find something else as an example
> that you need to use custom mergetool support for.

Ditto, looks good to me.


> I'm just wondering, does this work well with unixes and Mac OS X? I
> think it's recommended install practice to symlink p4v as p4merge on
> *nix, but Mac OS X needs some sort of 'launchp4merge' to be called
> IIRC, or is this something that users can just configure with
> mergetool.p4diff.path?

I just tested this on Mac OS X with the latest version of
p4merge.  It worked great.

	$ git config difftool.p4merge.path \
	  /Applications/p4merge.app/Contents/MacOS/p4merge

	$ git difftool -t p4merge HEAD^


So...

Tested-by: David Aguilar <davvid@gmail.com>


P.S.  thanks for the patch, Scott.

Sorry I haven't gotten around to forking progit yet
but we did at least get Disney Animation to go with
git + github =)

http://github.com/wdas/ptex

(there's only some headers up there right now,
 but we'll have more to share soon)


Have fun,

-- 
		David
