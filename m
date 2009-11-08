From: Bram Neijt <bneijt@gmail.com>
Subject: Re: [gitweb feature request] Release snapshots with vX.X.X tags
Date: Sun, 08 Nov 2009 22:08:42 +0100
Message-ID: <1257714522.14087.133.camel@owl>
References: <1257680442.14087.78.camel@owl>
	 <7vbpjcetlp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: Git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Nov 08 22:09:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7F0L-0007E9-Ij
	for gcvg-git-2@lo.gmane.org; Sun, 08 Nov 2009 22:08:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755169AbZKHVIl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Nov 2009 16:08:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755167AbZKHVIl
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Nov 2009 16:08:41 -0500
Received: from mail-ew0-f207.google.com ([209.85.219.207]:55340 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755124AbZKHVIk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Nov 2009 16:08:40 -0500
Received: by ewy3 with SMTP id 3so2592606ewy.37
        for <git@vger.kernel.org>; Sun, 08 Nov 2009 13:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:in-reply-to
         :references:content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=MmbyEp1FEend/YKbHJY0cY5wq+fxsckHozqwL+V0AG0=;
        b=iyTZUnlH1fMWKrBnCBiTRnvzsdVyVmjqO0neW/bqwFhp5EBP1YBUB0HEkX7ppH+Z+X
         9gj5ezRBRlr79Duqzl1QoUR47Kbaz9/IB4/UOYJyKd1E+W/DWWRnZcUawMEdNUhXemn3
         6KXNkYZkKtYX+KrJSoKC/lrrDq+dLTT2KIdAI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:in-reply-to:references:content-type:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        b=mTm/nFzeKzVJ2V21MKtytanPDVmSq2IoQ0+IG7qB4sYqgcHFSjNb64WLYZX8mHU8se
         P1STQ3qFZlde1Zx6Z58rrBVDS7Rh8PAuxw8UfcYWBsYldLckvpV+xxKQD6dSxVJ9CwL/
         /bTXEP5VzflJCnd9BD3qwJeGVwZYxn+Ymdwy4=
Received: by 10.213.104.10 with SMTP id m10mr7854711ebo.62.1257714524728;
        Sun, 08 Nov 2009 13:08:44 -0800 (PST)
Received: from ?192.168.1.33? (82-169-1-45.ip.telfort.nl [82.169.1.45])
        by mx.google.com with ESMTPS id 5sm4407926eyh.26.2009.11.08.13.08.43
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 08 Nov 2009 13:08:43 -0800 (PST)
In-Reply-To: <7vbpjcetlp.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 2.28.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132416>

I was going to comment inline but I think the general question can be
read as "why would you want this?". For me it's just an extra bit of
automation. It would keep me from having to make release tarballs. I
would just refer all the users to a gitweb snapshot link of the "v..."
tag. Having a release tarball with "projectname-version" with a single
directory called "projectname-version/" in it is just good practice if
you ask me.

Therefore it would benefit any developer like me :D : a spare time
hobbyist who likes to automate as much of the administrative tasks, that
go into running an open source project, as possible.

Greets,
  Bram

PS I've found that cgit: http://hjemli.net/git/cgit/
has this feature, so I'm probably going to give that a try and get back
to you if I find any problems with it (the feature that is).

On Sun, 2009-11-08 at 10:53 -0800, Junio C Hamano wrote:
> Bram Neijt <bneijt@gmail.com> writes:
> 
> > I would like to create release snapshots with a git tag like "v0.0.1".
> > For proper Debian packaging, a release snapshot of tag "v0.0.1" would
> > have to be named "project-0.0.1.tar.gz" and contain a single directory
> > with "project-0.0.1/" in the archive.
> 
> What the intended audience of this feature?  IOW,
> 
>  - who are going to "click" such a link on gitweb to obtain
>    project-0.0.1.tar.gz with project-0.0.1/?
> 
>  - how are they going to use that tarball?
> 
> I somehow suspect that they won't be the official Debian distro packagers.
> 
> Most likely they actually have a clone of the upstream project (how else
> they can stay up to date?  In addition they would want to track their own
> changes), so it would be more efficient for them to generate such a
> tarball from a tag, and more importantly, doing it locally means that they
> can they can verify the tag (and the whole history leading to it) before
> doing so, instead of relying on somebody else's gitweb.
> 
> You could be a mere Debian user who produces a *.deb for his own use out
> of such tarball, and in such a case you are a lot less likely be tracking
> the project (meaning, reading the history and keeping track of fixed bugs,
> new regressions and such) than just getting a snapshot that happens to be
> there and building it blindly, and I can understand it would be nicer if
> you did not have to unpack, rename and regenerate an archive.
> 
> Also, whose gitweb installations are you envisioning to enable this new
> feature?  Are you going to convince all the gitweb administrators of
> projects packaged by Debian (and derivatives) that have gitweb, and what
> are the incentive for these upstream projects to do so?  I would guess
> that most of the upstream projects do not consider Debian as their sole
> target distribution, and it would be a tough sell if changing the snapshot
> name to suit Debian breaks some other distro's (or human users) needs.
> 
> Jakub is polishing Mark's patch to change the snapshot name and contents
> hierarchy, but I think it won't satisfy Debian's naming guideline (it will
> have v0.0.1, not 0.0.1 in the name).  Changing the series's default to
> drop 'v' from the beginning of the tagname when the rest of it consists of
> all digits and dots would not be a correct solution, as Debian is not the
> only system in the world and other people may want different naming rules.
> 
> In order to make his series useful for your objective, it probably would
> require a bit more customizability, but because I cannot tell whom such a
> feature is really trying to help, and what the deployment plans are, I
> cannot judge if extra complexity to add such a customizability is worth
> it.  Also because there will be conflicts in the desired archive format
> ("Distro X people want this kind of archive, distro Y people want this
> different kind"), the choice somehow how to come from whoever is clicking
> the link, not from the gitweb administrator, and it probably would mean
> the codepath involved would need a lot more careful audit than just a
> server only "this gitweb installation would use this format"
> configuration.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
