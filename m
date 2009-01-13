From: "Jay Soffian" <jaysoffian@gmail.com>
Subject: Re: git-svn fails to fetch repository
Date: Tue, 13 Jan 2009 16:46:42 -0500
Message-ID: <76718490901131346i41fb58c2s527480d394745ef0@mail.gmail.com>
References: <loom.20090113T145019-951@post.gmane.org>
	 <loom.20090113T150220-345@post.gmane.org>
	 <496CD49D.1070201@drmicha.warpmail.net>
	 <loom.20090113T185918-397@post.gmane.org>
	 <20090113203922.GD30404@atjola.homenet>
	 <loom.20090113T204616-845@post.gmane.org>
	 <76718490901131312j28f8283bi94f55000e70c532e@mail.gmail.com>
	 <loom.20090113T211437-12@post.gmane.org>
	 <76718490901131328x5ec30805u3cae29132defd695@mail.gmail.com>
	 <loom.20090113T213400-985@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Eric Wong" <normalperson@yhbt.net>
To: "Vladimir Pouzanov" <farcaller@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 13 22:48:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMr7f-0002RG-PJ
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 22:48:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757524AbZAMVqp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2009 16:46:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752650AbZAMVqo
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jan 2009 16:46:44 -0500
Received: from rv-out-0506.google.com ([209.85.198.226]:11497 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757382AbZAMVqn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2009 16:46:43 -0500
Received: by rv-out-0506.google.com with SMTP id k40so192216rvb.1
        for <git@vger.kernel.org>; Tue, 13 Jan 2009 13:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=20svCBUypdHvVh+2iDuBCsxToKNnUAABBzJiehORvyg=;
        b=rWPqsSXCqWGo3XdTqgj4cJdgQD8H8adKPGNvyGPNPaJ8gMiMcgztz+XaE6LjPuPVw6
         GMGzN0CbM4gK67fwwU2HKKd+nm4gEmCM5amjSFPUC9xfRMJf1oQSp/2POpkouifZQJO1
         VMDElRCAgifN5CceZPo3wwtIJr0rXf3bItPvI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=QBrk3Wrc94apoaWI6Of+kw9MwC3HCNhYMTQjhCBlOJqIolGELGfArA7Vya795/c2t9
         vcyGmSEHQwpXPbyCeps5VDk/6S2eoLkTMy4okU6cDccivVOsDZBohlszqfkz87TBLfhU
         uiv15L1Jss/6vLXwXY4hOKe7OrV2Nm1Fqh2ec=
Received: by 10.141.76.21 with SMTP id d21mr15474969rvl.154.1231883202267;
        Tue, 13 Jan 2009 13:46:42 -0800 (PST)
Received: by 10.140.204.11 with HTTP; Tue, 13 Jan 2009 13:46:42 -0800 (PST)
In-Reply-To: <loom.20090113T213400-985@post.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105542>

On Tue, Jan 13, 2009 at 4:34 PM, Vladimir Pouzanov <farcaller@gmail.com> wrote:
> Jay Soffian <jaysoffian <at> gmail.com> writes:
>> Perhaps this will help in tracking down the problem.
>
> $ git svn clone http://qsb-mac.googlecode.com/svn/trunk qsb-mac
> Initialized empty Git repository in /Users/farcaller/temp/qsb-mac/.git/
> r1 = 810fe584c48b884460b5403a28bc61d872452b93 (git-svn)
> Temp file with moniker 'svn_delta' already in use at /opt/local/lib/perl5/
> site_perl/5.8.8/Git.pm line 1011.

Hrmm, to me that doesn't help very much. Perhaps the author of git-svn
(cc'd) might have an idea.

BTW, I installed git-core via DarwinPorts and I can clone w/that
version as well.

$ port info --name --version  git-core subversion perl5.8
version: 1.6.1
name: git-core
--
version: 1.5.5
name: subversion
--
version: 5.8.9
name: perl5.8

I was hoping it would fail for me so I could poke and prod.

j.
