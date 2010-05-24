From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: What's cooking extra
Date: Mon, 24 May 2010 11:49:05 +0200
Message-ID: <20100524094905.GA10811@localhost>
References: <7vsk5o9d1f.fsf@alter.siamese.dyndns.org>
 <20100519170656.GA30161@pvv.org>
 <20100522130916.GA28452@localhost>
 <50199F1F-3513-43A6-8990-957F3D0AF58C@gmail.com>
 <20100522222746.GA2694@localhost>
 <CDD31343-2352-434B-B875-2013DAF49CE7@gmail.com>
 <20100523115127.GA20443@localhost>
 <744D05D2-FC47-45E5-92A1-CD93B0901E0C@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Finn Arne Gangstad <finnag@pvv.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 24 11:49:29 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGUHp-0007zO-Ay
	for gcvg-git-2@lo.gmane.org; Mon, 24 May 2010 11:49:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756134Ab0EXJt0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 May 2010 05:49:26 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:42372 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753715Ab0EXJtQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 May 2010 05:49:16 -0400
Received: by fxm5 with SMTP id 5so2198922fxm.19
        for <git@vger.kernel.org>; Mon, 24 May 2010 02:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=cZpHeGwdn1znwYWZbDzT24oSJIO/TmafBN9ol4U7oxM=;
        b=D3JrNIv5aykekq3VQ/9ddtLLxrZ9QJYQRAOMR51VRCrI7vCQybrmQDRXnPQUm8eRyj
         fJ+v6pWgWZIsCsAg/0cYML/MysNz60pPrue9jvZZae7KgkVWN+VmUbIMbNCmMxoh+V7a
         8xNT+3YVe0uI68omOO1M0yRPhcadtdJYuudl0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:bcc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=pNViqkt17/qYaTmmSpRtpn7VU6kuWijK1+p28jESCUFTBKKK4Svf/BCEKfydkp7kY8
         p8jJYvpzif7DjXyRrgF2PNHwvJfM8gPVnE/sC4DQi5w2vvUD4XROgFkrTt6/tWdb8w5r
         rY0ouPi8PjkpUqxSiUojUtpMP4bzgXG+ZsDVc=
Received: by 10.223.16.142 with SMTP id o14mr4590780faa.11.1274694553865;
        Mon, 24 May 2010 02:49:13 -0700 (PDT)
Received: from darc.lan (p549A704B.dip.t-dialin.net [84.154.112.75])
        by mx.google.com with ESMTPS id r25sm18776817fai.11.2010.05.24.02.49.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 24 May 2010 02:49:12 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1OGUHR-0003Ww-2Y; Mon, 24 May 2010 11:49:05 +0200
Content-Disposition: inline
In-Reply-To: <744D05D2-FC47-45E5-92A1-CD93B0901E0C@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147620>

On Sun, May 23, 2010 at 02:53:18PM +0200, Eyvind Bernhardsen wrote:
> On 23. mai 2010, at 13.51, Clemens Buchacher wrote:
> 
> > On Sun, May 23, 2010 at 12:36:51PM +0200, Eyvind Bernhardsen wrote:
> >> Yeah, that's what I initially thought too, but it makes sense to
> >> be able to use normalization to prevent line ending breakages in
> >> your repository.  If a file needs CRLFs for some tool to work,
> >> you don't want anyone to inadvertently convert it to LF, and
> >> "eol=crlf" makes git enforce that.
> > 
> > Unsetting crlf/text already disables converting it to LF. The user
> > would have to change the line endings in his work tree and commit
> > the file with wrong line endings. I do not see how this can happen
> > inadvertently.
> 
> That's because you don't use (or work with people who use)
> editors that mangle line endings without asking.

That I can imagine. But due to their change, the file will not work
any more, not even on their own platform. What did they even make
the change for then?

> I don't have strong feelings about the need for this feature, but
> it has been requested so it's probably useful.

Just because a feature is requested doesn't mean it's useful, or
even harmless. This has nothing to do with version control in the
first place, so I do not see why we should suffer the additional
complication.

> > No, I am aware of autocrlf=input, but apparently I did not
> > understand the meaning of eol=lf correctly. So if a file has CRLF
> > endings in the repository, and eol=lf, it will _not_ be converted
> > to LF in the work tree? Conversely, if it has LF endings in the
> > repository, and eol=crlf, it _will_ be converted to CRLF in the
> > work tree?
> 
> That is correct, but "eol=lf" means that the file _should_ be
> LF-only in the repository.  If it isn't, the repository is
> "corrupted".  Such a file is marked as dirty when it is checked
> out and will be normalized to LF-only line endings when it is
> committed, at which point the repository will be fixed.

With CRLF file in the repository, core.autocrlf=true and
core.eol=lf, I tested the patches currently in pu (0ed6711a) in the
following three scenarios:

1. no attributes are set
2. text attribute is set or auto
3. eol attribute is set to lf

In the first scenario, the behavior is completely asymmetric. LF
files will be converted to CRLF, if core.eol=crlf, but CRLF files
will _not_ be converted to LF, even if core.eol=lf. And it will not
be marked as dirty either. Yet this is the default behavior in
terms of attributes.

The only justification I can think of for this behavior is the fact
that on platforms with LF line endings, most tools can deal with
CRLF line endings. Not very convincing.

In the second scenario, the file is marked as dirty. Neither reset
--hard nor checkout HEAD . fix the problem. The file has to be
added and committed, after which the line endings are _still_ CRLF.
This appears to be the old autocrlf=true behavior. Is this
intentional?

The third scenario is similar to the second scenario, only it warns
me about CRLF conversion during add and commit. The file still ends
up having CRLF line endings in the work tree. git reset --hard does
not fix the line endings. touch'ing the file finally makes git diff
notice that the file is dirty, but git status still does not list
the file.

So to me, end of line conversion is still as confusing as it gets.

> This should only be a problem if you set the "text" or "eol"
> attributes in an existing repository, or if someone adds CRLFs to
> a normalized file using an older version of git.

In other words, this will be a problem all the time, since by
default people will not even know about text or eol.

Clemens
