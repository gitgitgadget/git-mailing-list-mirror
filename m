From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: GSoC Application [ Parallelism + Git.pm ]
Date: Sun, 18 Mar 2012 09:31:17 -0700 (PDT)
Message-ID: <m37gyhlvkz.fsf@localhost.localdomain>
References: <CAB3zAY1cbjmJvPQo2i38Vxv=1CTzcusvtBTPQehi30cYsDe1Zw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Subho Banerjee <subs.zero@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 18 17:31:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9J0u-0003zK-TI
	for gcvg-git-2@plane.gmane.org; Sun, 18 Mar 2012 17:31:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754973Ab2CRQbU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Mar 2012 12:31:20 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:56119 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754508Ab2CRQbT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2012 12:31:19 -0400
Received: by wibhq7 with SMTP id hq7so2901216wib.1
        for <git@vger.kernel.org>; Sun, 18 Mar 2012 09:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=dgBJOUNERpUWyh9fri5QCt7K2LONXgUjAFSZfzAtg9Y=;
        b=eMfP4QZo9MuDN+6R58LSYg6Mvx6mVbz4fNjaqZOjjSmDP6KqZ3rlW6NaZ7f/EJl2Om
         4DoSxx6Zy4/tO09ItcYTrYQ8AVHOZgF70pptIGUjQT8PPgkiKf8ZcsdpWhVQ9MHdR8Bm
         mS16tFe0L/2Q5puaTk6mtx7PS5GXlu30ZkGpvc4jQtfEUaTwZSA3TbY52S9KPQg1A4JN
         AdRgWxChrysHLU5vHHcfeuvzgoRhh0wUZwQWn/HxUwdlAizlh1WstZ3Kh+uHTNinVB33
         SB/WelXK1sWT+yy0ToNeCCyS9HUyDpmDQRX67mHw3Ua5RgjqegPffwO9th1gkwbwxYaD
         UxdQ==
Received: by 10.180.79.72 with SMTP id h8mr1485719wix.1.1332088278072;
        Sun, 18 Mar 2012 09:31:18 -0700 (PDT)
Received: from localhost.localdomain (abvx54.neoplus.adsl.tpnet.pl. [83.8.221.54])
        by mx.google.com with ESMTPS id gp8sm17988212wib.5.2012.03.18.09.31.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 18 Mar 2012 09:31:17 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id q2IGVPuO021361;
	Sun, 18 Mar 2012 17:31:26 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id q2IGVPLe021358;
	Sun, 18 Mar 2012 17:31:25 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <CAB3zAY1cbjmJvPQo2i38Vxv=1CTzcusvtBTPQehi30cYsDe1Zw@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193384>

Subho Banerjee <subs.zero@gmail.com> writes:

[...]
> I had a look at the "Ideas" page on the GSoC website and I really
> liked two particular project ideas, in which I believe I can
> contribute to a larger extent.
> 
> * Improving parallelism in various commands
> * Modernizing and expanding Git.pm

[...]
> From what I understand of these tasks --
[...]
> * For the second one, which aims at improving the Git perl module. I
> tried looking around for this one on the net. I was a little confused
> since I could not make out which module this was on CPAN. Is this one
> of the Git::* modules or is it all of them. Because the the
> functionality of the Git::Config and Git::Commit as mentioned in the
> Ideas page seems to be there in the Git::Repository module on CPAN.
> Could some one please clarify this.

The "Modernizing and expanding Git.pm" project refers to the Git
module in git sources[1], that is used by git commands implemented in
Perl like git-svn, git-send-email, and interactive part of git-add.

It is not on CPAN (though if you feel like it putting it on CPAN might
be part of this project, but it must be "dual-lived").

[1]: http://repo.or.cz/w/git.git/blob/HEAD:/perl/Git.pm
     http://git.kernel.org/?p=git/git.git;a=blob;hb=HEAD;f=perl/Git.pm
     https://github.com/git/git/blob/master/perl/Git.pm

You can of course take inspiration and code (if it is with compatibile
license) from various Git::* modules on CPAN to implement the
"expanding" part of this project.

Note that Git.pm must remain extremly portable, which includes
ActivePerl on MS Windows (msysGit or Cygwin).  Use of non-core modules
(for 5.8.0) should be also probably limited.
 
> I would really appreciate any ideas or advice for making my
> application for GSoC 2012 better.

HTH
-- 
Jakub Narebski
