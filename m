From: Miguel Ramos <mail@miguel.ramos.name>
Subject: Using a git repository on the root directory
Date: Fri, 16 Apr 2010 21:44:20 +0100
Message-ID: <q2k3e2876431004161344vfff638a7ncfa74aa0e3b979dc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 16 22:44:30 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2sOq-0003oY-4L
	for gcvg-git-2@lo.gmane.org; Fri, 16 Apr 2010 22:44:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932520Ab0DPUoW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Apr 2010 16:44:22 -0400
Received: from mail-qy0-f196.google.com ([209.85.221.196]:39971 "EHLO
	mail-qy0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932517Ab0DPUoW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Apr 2010 16:44:22 -0400
Received: by qyk34 with SMTP id 34so3763839qyk.22
        for <git@vger.kernel.org>; Fri, 16 Apr 2010 13:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:date
         :x-google-sender-auth:received:message-id:subject:from:to
         :content-type;
        bh=W6m0MvRqVDU/AkR1BLHYQSWaM81OlschBSOCvl9HRQ0=;
        b=Z1WEd7Sa0QSEXWIGOVWxVxcEa3qBNwus2wPsg4JJSvh9xP5An33CkC3nkD/ayJWpdL
         Frp/2UPKfECPqAXkGKm6Y98hmnCAStHJqSJNjTi37QYZQG0WNJUt66bGBJUhpN9qVJ86
         PjJRwbxi7aI7KG0jpJ+u5CXPR96gbGk8U67Ws=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type;
        b=GXxfZcF/wtoKpEu+oUSNvPaTCiE3zFkwj/9uG+Wuv65MJNIzqZczZbzqIU1+BhnLb/
         rLbV6HcP7eiiGX/+OMduQXjIR4LAFwEJZ0Xa1EuuIqxKJg1rwEqZZYlxvQJL7tgrkwX6
         W96oHscaEG0iE/tWtOOAMfmizpdixS4gpuXQE=
Received: by 10.229.90.199 with HTTP; Fri, 16 Apr 2010 13:44:20 -0700 (PDT)
X-Google-Sender-Auth: 4ad893a267699501
Received: by 10.229.227.149 with SMTP id ja21mr2533052qcb.74.1271450660883; 
	Fri, 16 Apr 2010 13:44:20 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145094>

Hi,

Is it possible with git to use a git repository on the root directory?
I'm trying to replace subversion doing this.
I have a populated repository elsewhere, I can clone this to an empty
directory and then move .git to / to work around the demand that the
target directory is empty and at the same time avoid overwriting
files.
I used this method before to get my home directory versioned with
success, so far.

When I'm on the root directory, things seem to work minimally. I do
git status, etc, and get the expected results.
However, if I change say to /etc, or any other directory, for that
matter, then git status tells me that every file in the repository is
deleted.
Adding files doesn't work, nothing works at all.

I know this is an unforeseen use of git, however, unforeseen might not
imply forbidden.
I'm pretty disappointed I couldn't get it working.

So the motivation for this posting is twofold:
- Is this possible in some other way, or did I do something wrong (I'm
new to git) ?
- I find the resulting behaviour pretty curious, maybe someone who
knows how git works can explain why this is the resulting behaviour.

Thanks,

-- 
Miguel Ramos <mail@miguel.ramos.name>
PGP A006A14C
