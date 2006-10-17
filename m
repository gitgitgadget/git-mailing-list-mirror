From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: VCS comparison table
Date: Tue, 17 Oct 2006 14:02:02 +0200
Message-ID: <200610171402.03373.jnareb@gmail.com>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <vpqejt76vgz.fsf@ecrins.imag.fr> <200610171345.32313.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Aaron Bentley <aaron.bentley@utoronto.ca>,
	Linus Torvalds <torvalds@osdl.org>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 17 14:01:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZndb-0005vO-JC
	for gcvg-git@gmane.org; Tue, 17 Oct 2006 14:01:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750696AbWJQMBh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 08:01:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750698AbWJQMBg
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 08:01:36 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:32943 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750696AbWJQMBg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Oct 2006 08:01:36 -0400
Received: by ug-out-1314.google.com with SMTP id o38so963800ugd
        for <git@vger.kernel.org>; Tue, 17 Oct 2006 05:01:34 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=nLBbGe4newYpIBIb6ZX0nJXYpdlDv7iWl0Wo6QgI24FperIa6rc5jS8LwsRNdTWD7zliMxrtDQKb9dv4Bslxh5ya2gUOEDIQL30c4t/l5LX1lwCLRuAvxqyaL4tPJ1/WEa8WjAiYkpOYfvFQOH/skrTyQdVMJqGQ9zhR73dBXTk=
Received: by 10.67.101.10 with SMTP id d10mr9620886ugm;
        Tue, 17 Oct 2006 05:01:34 -0700 (PDT)
Received: from host-81-190-17-207.torun.mm.pl ( [81.190.17.207])
        by mx.google.com with ESMTP id e33sm51405ugd.2006.10.17.05.01.33;
        Tue, 17 Oct 2006 05:01:34 -0700 (PDT)
To: Matthieu Moy <Matthieu.Moy@imag.fr>
User-Agent: KMail/1.9.3
In-Reply-To: <200610171345.32313.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29062>

Jakub Narebski wrote:
> In git by default in the top directory of working area you have .git 
> directory which contains whole repository (object database, refs (i.e. 
> branches and tags), information which branch is current, index aka. 
> gitcache, configuration, etc.). You can share object database locally 
> (which includes network filesystem).
> 
> You can have .git (usually <project>.git then) directory without working 
> area.

So called "bare" repository.
> 
> And you can symlink (and in the future "symref"-link) .git directory.

And you can use GIT_DIR environmental variable or --git-dir option
to git wrapper.
-- 
Jakub Narebski
Poland
