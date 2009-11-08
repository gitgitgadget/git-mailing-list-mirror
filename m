From: Bram Neijt <bneijt@gmail.com>
Subject: Re: [gitweb feature request] Release snapshots with vX.X.X tags
 [closed]
Date: Sun, 08 Nov 2009 15:15:51 +0100
Message-ID: <1257689751.14087.89.camel@owl>
References: <1257680442.14087.78.camel@owl>
	 <m3tyx5rv6j.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: Git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Nov 08 15:17:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N78Yi-0001CY-V4
	for gcvg-git-2@lo.gmane.org; Sun, 08 Nov 2009 15:16:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753594AbZKHOPu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Nov 2009 09:15:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753439AbZKHOPt
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Nov 2009 09:15:49 -0500
Received: from mail-ew0-f207.google.com ([209.85.219.207]:64048 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753153AbZKHOPs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Nov 2009 09:15:48 -0500
Received: by ewy3 with SMTP id 3so2388063ewy.37
        for <git@vger.kernel.org>; Sun, 08 Nov 2009 06:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:in-reply-to
         :references:content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=hu6jp9LsEdTtHQtyZthvtxak95rhtZSfVH7HE7H1dJc=;
        b=FZ9JAghF5f/Ef/CTkMeuGFxdR9zdAAEfUI/RAVmCQ/c4EELw5f6OFGorimNfy4gO3h
         3QP/v7sgfZEF0d9EqLACnt31QzARp05JHzSRcqA4JQCTuN7nbgduk9wlT5azcrdpSujF
         zlIhwMzMFeZsd9ZFD+74JQ9+grCCJ9OWKusXM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:in-reply-to:references:content-type:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        b=MNBleV5b2EUNt2CXVyiighhLT17RkQBCzXs3ZWjWKSMrox3GOmuD9UGORCMIFKdOns
         HitinC87Yb/xYwXcm2BbpGIrHDSnr9ihYe1Y4V9lG7TB8dVnNW9H3ADeA43DUR6uNSNf
         EoqxSKqSfVakGZrxLzkeJj7hGmIr+o7GCSKeY=
Received: by 10.213.100.168 with SMTP id y40mr1965761ebn.28.1257689753160;
        Sun, 08 Nov 2009 06:15:53 -0800 (PST)
Received: from ?192.168.1.33? (82-169-1-45.ip.telfort.nl [82.169.1.45])
        by mx.google.com with ESMTPS id 10sm3640742eyz.43.2009.11.08.06.15.52
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 08 Nov 2009 06:15:52 -0800 (PST)
In-Reply-To: <m3tyx5rv6j.fsf@localhost.localdomain>
X-Mailer: Evolution 2.28.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132401>

Dear Jakub,

Thank you for your response, reading the thread you mentioned [1], I
have seen that my feature is already included in the patch in progress
there. I will simply wait for that patch to get through.

I hereby declare this thread closed.

Greetings,
  Bram

[1] http://thread.gmane.org/gmane.comp.version-control.git/132366

On Sun, 2009-11-08 at 05:40 -0800, Jakub Narebski wrote:
> Bram Neijt <bneijt@gmail.com> writes:
> 
> > I would like to create release snapshots with a git tag like "v0.0.1".
> > For proper Debian packaging, a release snapshot of tag "v0.0.1" would
> > have to be named "project-0.0.1.tar.gz" and contain a single directory
> > with "project-0.0.1/" in the archive.
> > 
> > Attached is a very dirty patch to the current head of gitweb.perl to
> > change the snapshot if the requested hash has a tag which matches
> > "m/^v(.+)\^0$/". This regular expression will probably have to be more
> > strict then that in the future, but my main concern is the quality of
> > the patch, and whether or not this feature is something the mainstream
> > would appreciate.
> > 
> > My question to you all is: would this feature be considered as an
> > addition, and if so what would be the best way to get this patch into
> > shape for inclusion?
> 
> See Documentation/SubmittingPatches in git sources or in gitweb:
>   http://git.kernel.org/?p=git/git.git;a=blob;f=Documentation/SubmittingPatches;hb=HEAD
> Patch should be posted _inline_[1] (to make it easy to review the
> patch), and should use _unified_ (diff -u) format (to make it possible
> to apply patch correctly even if file changed in meantime) if you
> can't install git and use it (git format-patch) to generate a patch.
> 
> 
> By the way there is patch on git mailing list addressing part of
> mentioned issue:
>   "[PATCHv2 0/3] gitweb: Smarter snapshot names"
>   Message-ID: <1257606809-23287-1-git-send-email-jnareb@gmail.com>
>   http://thread.gmane.org/gmane.comp.version-control.git/132366
> (earlier version of this patch can be found in 'pu' branch as merge
> from 'mr/gitweb-snapshot' into pu).
> 
> This patch makes snapshot with name "project-version.tar.gz" to
> contain single directory "project-version/" in the archive.  Snapshot
> of tag *if requested* using 'refs/tags/v0.0.1' as 'h' (hash) parameter
> would have "project-v0.0.1.tar.gz" as proposed archive filename...
> but this patch doesn't make gitweb generate such links.
> 
> 
> [1] In very rare cases such as troubles with whitespace, line-wrapping
>     and encoding it might be better to attach it with text/plain
>     mimetype.
> 
