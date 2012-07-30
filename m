From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Enhancements to git-protocoll
Date: Sun, 29 Jul 2012 18:21:20 -0700
Message-ID: <CAJo=hJsgMz-=pdG=HB3KtTE7g6Gvu9mr56dg2+V3WUST+rpAQg@mail.gmail.com>
References: <20120728214116.GA3591@paksenarrion.iveqy.com> <7vehnvvyta.fsf@alter.siamese.dyndns.org>
 <20120729142458.GB16223@paksenarrion.iveqy.com> <CAMK1S_iTv3BOV3LEoj83feuO2iQnPqTrOq0wyFC-GrvvJQqWTA@mail.gmail.com>
 <7vvch6uw89.fsf@alter.siamese.dyndns.org> <7vr4ruuu2e.fsf@alter.siamese.dyndns.org>
 <CAMK1S_geKq5DkNAy2wxGt5EmoOesxaSKKuQjVaQVcbRVdR+9gA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Fredrik Gustafsson <iveqy@iveqy.com>, git@vger.kernel.org
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 30 03:21:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sveg7-0005jt-GT
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jul 2012 03:21:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753771Ab2G3BVm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jul 2012 21:21:42 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:36575 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753377Ab2G3BVl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jul 2012 21:21:41 -0400
Received: by obbuo13 with SMTP id uo13so8182654obb.19
        for <git@vger.kernel.org>; Sun, 29 Jul 2012 18:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=44GKSiQnHfydjG1rz5F+Ze9tmMnImXgo/GZ5QUyD6ek=;
        b=Nt2CfEUL2r5Hw4wam56bifpZalzWESrHATQBwErzxiJPaPsZB7Adp62ctmDAUTJ9xA
         igFbgtggAuZe4J7sLqTMRZkEei0T2l80IQgBCu2lEsPtopyHpamkZAx0MTbN6vK6EowK
         Ty9F8rJ1Q9d2wBAbqi+EM8nSQ/e0RErHn+h14=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:x-gm-message-state;
        bh=44GKSiQnHfydjG1rz5F+Ze9tmMnImXgo/GZ5QUyD6ek=;
        b=hSkP+U8AYZbG4QUUeZXhOaLf0xqRJy9FnwqSrx36Mwo6HSABpw6+F9XO2aCAgatG1s
         d4BKjmfNZjgq2xmKW0DYcNwYvc+gVZ8/BMZn1GJZqB+dWQEsLrb7DBvVgUSGrVn1ny9g
         n6FdVLbdQee8+H5m3SjD/w1EL654gqOQM0HisLqzDGUKOorDxZ13auZzvUV2Poj7Ny3u
         ASF6M/WSzlUPjmDtkhzrgXaf95P3nd0MwINpskkYZgQSAnYWGcjO7coXEaD5Q40YW1UX
         EaW7LzfELl1qFplKDRHDT2ZVLmGmpndutbwDCktT/+zoKSAEVyHzXkf4wzPijCrcrbwe
         kcNw==
Received: by 10.50.208.105 with SMTP id md9mr7036511igc.12.1343611300791; Sun,
 29 Jul 2012 18:21:40 -0700 (PDT)
Received: by 10.64.14.177 with HTTP; Sun, 29 Jul 2012 18:21:20 -0700 (PDT)
In-Reply-To: <CAMK1S_geKq5DkNAy2wxGt5EmoOesxaSKKuQjVaQVcbRVdR+9gA@mail.gmail.com>
X-Gm-Message-State: ALoCoQnluKNK8VnyHrcmEuHVxC98v2nc34/cRa+pUn1z/dzjkWUU75m2499O5QQcoryx7rOZcuBE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202515>

On Sun, Jul 29, 2012 at 6:04 PM, Sitaram Chamarty <sitaramc@gmail.com> wrote:
> Of course this will only work with ssh.  None of what Fredrik has so
> far suggested would possibly work on smart http without even more
> hacks, I think.

Now that we have smart HTTP, and its somewhat popular for sites to
deploy with, we need to carefully consider all future protocol changes
to make sure they are compatible with the HTTP one. Since the HTTP is
single request/response model, its hard to implement a conversation
with the end-user.

One thing I would like to do with the protocol is add custom site
specific extensions to the protocol, where hooks are able to advertise
in the initial capability list something like a namespace prefix that
`git push` can use to offer site specific command line flags from:

  ....00000000... HEAD^{} report-status delete-refs side-band-64k
ofs-delta hook=gitolite

and the client seeing this would recognize a push command like:

  git push -Lgitolite,create-repository URL master

passing the string "gitolite,create-repository" as data in the header
of the push request. gitolite would need to scan more than just the
git receive-pack command line from SSH to see this data, but you can
use it to implement an "are you sure you want to create this
repository" exchange by failing a push with sideband information
telling the user to reinvoke push with the create-repository flag if
they really mean to create it.

We sort of want this in Gerrit Code Review to pass reviewer names on
the command line of git push, making it easier for users to upload a
code review. The idea is similar to what happens with gcc accepting
linker flags that are just passed onto the linker. From what I
understand, Mercurial already has something like this in their push
system for hooks to accept additional data one-way from the client.
