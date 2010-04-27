From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: How to continue to run 'git svn fetch' for a repo with no git-svn 
	metadata
Date: Tue, 27 Apr 2010 14:51:29 +0000
Message-ID: <z2l51dd1af81004270751yf026e946p4b00552eaf4f2632@mail.gmail.com>
References: <t2u46dff0321004270248l49d1ae30l6b168342e01a5bfd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git mailing list <git@vger.kernel.org>
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 27 16:51:41 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6m8Q-0001vM-7t
	for gcvg-git-2@lo.gmane.org; Tue, 27 Apr 2010 16:51:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756157Ab0D0Ovc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Apr 2010 10:51:32 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:63789 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756142Ab0D0Ovb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Apr 2010 10:51:31 -0400
Received: by bwz19 with SMTP id 19so152263bwz.21
        for <git@vger.kernel.org>; Tue, 27 Apr 2010 07:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=aulZ5sFpYNYBrYPHvevqefXx1hieZY+gjsclwKSnovk=;
        b=kw2pBIpC6YHG16sD/v6MRslT4PsBqwmb2/fd2qj38zwZ8vfYOBTbfWsNovIdADWokp
         oKi9AZUFDvAaByvViPcjXpk6BJdMPvGKvw5woOzpXr2dTbSmaN410oSEeRGOzKqzkhYT
         o42kMLXYcB2J2w5b2paE94+rx4rbLE+uBBoBk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=jQ8jPkTqLv4XNr7Pc1BLgwXWZ36Ka2Ik9K35NuMYtkYclKpsSJEq6Vp/+dxtErjMjV
         rdYGYqiDsIGznWvJVTn+taeL0QWz3Fw3E76aidjoDiGUH9cP83KdRa/GKNqADWstos4f
         +sy3VbSwmam1BB9EQs2yHEegTHZbZ3DQMxMBU=
Received: by 10.204.152.17 with SMTP id e17mr3812749bkw.105.1272379889929; 
	Tue, 27 Apr 2010 07:51:29 -0700 (PDT)
Received: by 10.204.65.144 with HTTP; Tue, 27 Apr 2010 07:51:29 -0700 (PDT)
In-Reply-To: <t2u46dff0321004270248l49d1ae30l6b168342e01a5bfd@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145924>

On Tue, Apr 27, 2010 at 09:48, Ping Yin <pkufranky@gmail.com> wrote:
> I cloned a repo from a central repo which is mirrored by git-svn. Now
> i want to mirror the svn in the cloned local repo by myself, however,
> i don't have the git-svn metadata (which is in the central repo). What
> should i do to run "git svn fetch" without refetching all the
> versions?

Read these:

    http://code.google.com/p/chromium/wiki/UsingGit#Initial_Setup
    http://trac.parrot.org/parrot/wiki/git-svn-tutorial

This should probably be in the git-svn documentation itself.
