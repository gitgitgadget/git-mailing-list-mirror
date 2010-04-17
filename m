From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Using a git repository on the root directory
Date: Sat, 17 Apr 2010 01:42:35 -0700 (PDT)
Message-ID: <m3zl12eaif.fsf@localhost.localdomain>
References: <q2k3e2876431004161344vfff638a7ncfa74aa0e3b979dc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Miguel Ramos <mail@miguel.ramos.name>
X-From: git-owner@vger.kernel.org Sat Apr 17 10:42:47 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O33bx-0007iO-UX
	for gcvg-git-2@lo.gmane.org; Sat, 17 Apr 2010 10:42:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753296Ab0DQImj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Apr 2010 04:42:39 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:48790 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752014Ab0DQImi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Apr 2010 04:42:38 -0400
Received: by fg-out-1718.google.com with SMTP id 19so776715fgg.1
        for <git@vger.kernel.org>; Sat, 17 Apr 2010 01:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=TL4UcrScoMfV0GPW/hkzOsKxyZWLhVKp5prp9rTwozI=;
        b=S533K3gNovWm7w1F0hNTAoUDVWc4aJ/VecjBK4wqcz6rh7EJxf+31hoJ2eACnfI7kl
         OBbfTtHI6nX+FJs13UhxjL0z129v0am59mDAcY4RkrrORFkKzqK9pBzIC44xXPRCKeYo
         UQBwWdO5Hv8XPtZo/HImLQCIFui1i2uLONKkc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=O/2tAokLolAp+wZAa5yMlg5JAV1BVbYgY0nr675kAiZy8DFrPg/YjJN/QEBRGwFA31
         N3IXF5CacNkTcFck+MA/Ic/mxxotuxZv2yFKYtN1CKXCZWKsGhCKo+wAJoZIR1lG7r3J
         bqshXWLtpgwuhToIrLR7peqja/u9T8M+CQA6w=
Received: by 10.87.63.1 with SMTP id q1mr2141838fgk.38.1271493756571;
        Sat, 17 Apr 2010 01:42:36 -0700 (PDT)
Received: from localhost.localdomain (abwa84.neoplus.adsl.tpnet.pl [83.8.224.84])
        by mx.google.com with ESMTPS id 4sm6266173fge.23.2010.04.17.01.42.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 17 Apr 2010 01:42:35 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o3H8g135026443;
	Sat, 17 Apr 2010 10:42:11 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o3H8fiEA026438;
	Sat, 17 Apr 2010 10:41:44 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <q2k3e2876431004161344vfff638a7ncfa74aa0e3b979dc@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145123>

Miguel Ramos <mail@miguel.ramos.name> writes:

> Is it possible with git to use a git repository on the root directory?
> I'm trying to replace subversion doing this.
> I have a populated repository elsewhere, I can clone this to an empty
> directory and then move .git to / to work around the demand that the
> target directory is empty and at the same time avoid overwriting
> files.
> I used this method before to get my home directory versioned with
> success, so far.
> 
> When I'm on the root directory, things seem to work minimally. I do
> git status, etc, and get the expected results.
> However, if I change say to /etc, or any other directory, for that
> matter, then git status tells me that every file in the repository is
> deleted.
> Adding files doesn't work, nothing works at all.
> 
> I know this is an unforeseen use of git, however, unforeseen might not
> imply forbidden.
> I'm pretty disappointed I couldn't get it working.

The 'nd/root-git' branch (merged into 'master' as v1.7.1-rc0~89)
might have addressed the issue you are seeing.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
