From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [git-svn] How to produce log of only remotes/git-svn regardless 
	of current branch
Date: Tue, 20 Jul 2010 16:13:13 +0000
Message-ID: <AANLkTinlJkhCYrBaViD8DB1mR6EoDbwRP7yT4cHog0TU@mail.gmail.com>
References: <AANLkTilX2SN8CFTkrHDaIx3NvhlQACYRq-QLPUVW3IJh@mail.gmail.com>
	<AANLkTimmXzi17GdT199-YiP2nWmmsU4-YW2wd2objWdb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Raymond Auge <raymond.auge@liferay.com>
X-From: git-owner@vger.kernel.org Tue Jul 20 18:13:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ObFRY-00050i-Qw
	for gcvg-git-2@lo.gmane.org; Tue, 20 Jul 2010 18:13:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758409Ab0GTQNP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jul 2010 12:13:15 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:46406 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753840Ab0GTQNP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jul 2010 12:13:15 -0400
Received: by iwn7 with SMTP id 7so5832493iwn.19
        for <git@vger.kernel.org>; Tue, 20 Jul 2010 09:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=vBfw5oD5QR0gcetsS72bUWE2EDGQnYp1c7EwbDnHe4I=;
        b=LKhrVAckkpkxqGLgqkg8Xia4LXzbrW1tAOV0AK7DD8jfiz86ofUYEfdk+FtwWufWgf
         2k9OpvBg96VMrbOo54F4JYQcVdPdLV7sJzRHJ55q61JlxphbVAESUp+5uLDz2cZ/Z2DM
         kkKT93p6lBAUpiq44eeuVN8ix6LFwJfb1Q66c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=Zd3JoPn3wXlXtT5SQp2JtXuEyivGs4JirOWQ2tfzKnmJsJz5XJFh4QHNUl+P9GCmnt
         mge5W1ujLZgxjXi3aRO3NO9uv/RHpFIhkNtkLzUkAy8eNSFG+r4PGBK2e2KKnloIl6zv
         PYLJkAIEK+9zyJGCYi1ay90mQkUp3/tFtW0HI=
Received: by 10.231.34.70 with SMTP id k6mr7329768ibd.25.1279642393362; Tue, 
	20 Jul 2010 09:13:13 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Tue, 20 Jul 2010 09:13:13 -0700 (PDT)
In-Reply-To: <AANLkTimmXzi17GdT199-YiP2nWmmsU4-YW2wd2objWdb@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151323>

On Tue, Jul 20, 2010 at 16:08, Raymond Auge <raymond.auge@liferay.com> wrote:
> Hello All,
>
> In trying to produce a log of only remotes/git-svn regardless of
> current branch, I've tried many variations of:

It's:

    git log $branch

not:

    git log --remotes=$branch

or something like that.
