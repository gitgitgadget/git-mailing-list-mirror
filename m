X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH/RFC] gitweb: New improved patchset view
Date: Sun, 29 Oct 2006 21:29:15 +0100
Message-ID: <200610292129.15372.jnareb@gmail.com>
References: <20061029195554.77410.qmail@web31813.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 29 Oct 2006 20:29:51 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=VqlT2dPh+VSYMPg5HWhS9ltktmhkxN1azhC3yDZ8cXuj5aIKz6bkcW1DOP+p2fu5ZFj1KnGkGyn+Fg2vXMojXMt6XTTV6T78qG0aITJI5KUFJmf0Ljv6l47clk09KMdPkPZfXSyFJLWEAnfD/oX/kRJsM/5zCEcze9egn19GD2A=
User-Agent: KMail/1.9.3
In-Reply-To: <20061029195554.77410.qmail@web31813.mail.mud.yahoo.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30454>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GeHHd-0005RZ-QN for gcvg-git@gmane.org; Sun, 29 Oct
 2006 21:29:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030179AbWJ2U30 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 29 Oct 2006
 15:29:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965431AbWJ2U30
 (ORCPT <rfc822;git-outgoing>); Sun, 29 Oct 2006 15:29:26 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:33854 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S965430AbWJ2U3Z
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 29 Oct 2006 15:29:25 -0500
Received: by ug-out-1314.google.com with SMTP id 32so1010217ugm for
 <git@vger.kernel.org>; Sun, 29 Oct 2006 12:29:24 -0800 (PST)
Received: by 10.67.97.18 with SMTP id z18mr2973464ugl; Sun, 29 Oct 2006
 12:29:24 -0800 (PST)
Received: from host-81-190-18-116.torun.mm.pl ( [81.190.18.116]) by
 mx.google.com with ESMTP id o24sm2370113ugd.2006.10.29.12.29.23; Sun, 29 Oct
 2006 12:29:24 -0800 (PST)
To: Luben Tuikov <ltuikov@yahoo.com>
Sender: git-owner@vger.kernel.org

Luben Tuikov wrote:
> --- Jakub Narebski <jnareb@gmail.com> wrote:
> > A couple of questions regarding new patchset/diff look for gitweb.
> > Currently patch starts with "git diff" header
> > 
> >   diff --git a/file1 b/file2
> > 
> > then we have a couple of extended header lines
> > 
> >   old|new|deleted file|new file mode <mode>
> >   copy|rename from|to <path>
> >   (dis)?similarity index <percent>
> >   index <hash>..<hash> [<mode>]
> > 
> > then we have two-line from-file/to-file header
> 
> First revert back to monospace in the commit message.
> As I mentioned in that other email, where the person
> didn't CC you and thus so I didn't, see commit 
> 4b7ce6e2d6ba088da50de1df38b040ea2c0b8f18.

This regression was caused by the not-accepted (I think) patch
"gitweb: Slight visual improvements to commitdiff view",
and is not caused by _this_ patch.

I'll redo abovementioned patch correctly later.

> Can you please hyperlink what you had intended to
> quote?  I.e. filenames which can lead the user browsing to a
> state (pre-rename, post-rename, etc).  Thanks.

I don't understand this comment. The above is pre-changes git-diff
patch output. The changes are/were mentioned below.

> > 
> >   --- a/file1
> >   +++ b/file2
> > 
> > then patch itself.
> > 
> > 
> > 1. Which parts to convert to hyperlinks, and which to do not? Which
> >    links have visible and which hidden (underline on mouseover, the same
> >    color as neighbouring text)?
> 
> I think the current state of your patch is good, sans the comments
> received so far: monospace, that bug in the index links, etc.
> Lets get that in, and then you can RFC another improvement on top of this.

O.K. I send the corrected version (as "take 2") in a while.

-- 
Jakub Narebski
