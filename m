From: Thomas Anderson <zelnaga@gmail.com>
Subject: unable to checkout branches and proper procedure for creating a new 
	branch based off of another one
Date: Wed, 16 Jun 2010 21:41:23 -0500
Message-ID: <AANLkTilZ6zoByCngAGoCbgQ9yd424VcChpTKh_XLnogd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 17 04:41:39 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OP52u-00087q-Fa
	for gcvg-git-2@lo.gmane.org; Thu, 17 Jun 2010 04:41:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756717Ab0FQClZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jun 2010 22:41:25 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:60670 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752876Ab0FQClZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jun 2010 22:41:25 -0400
Received: by pxi8 with SMTP id 8so4244524pxi.19
        for <git@vger.kernel.org>; Wed, 16 Jun 2010 19:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=cFopjghIgI8qT0HG4ymfaRbhxG4E4ji22srOz59/94g=;
        b=UyGLBqyrnGScac73NaWMNHNYNgw/RhtFwHR4eN1bCdUcDyNUhWf3ScI5SXCRJe/f0i
         JZVp9FftkFbg6d1r2NRD79aKNCRZVutwHEbvmFFnsLMfxAVMR2KtkivHLcwfYWT1DOcp
         ygDHN33lIjgVQvQTdDIruZRJOMhOfmEd9IlRs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=vul5BHbhBzyEUObNcUJAPfBEBmsqzCQb9QOQqwLZe8bX65QTBu4/JcrMQmEdCl40s4
         N7dLkjr6fAvHkZ+zA2crGL6Y3rsGUP+k8locsNZaEGJUHKO2Of6LUvkO85bGYZz9O1YB
         cglP5hisvUOvaDOQVpC+dpZR4C+XcKl/0V8S0=
Received: by 10.142.202.17 with SMTP id z17mr6929380wff.140.1276742483841; 
	Wed, 16 Jun 2010 19:41:23 -0700 (PDT)
Received: by 10.142.87.4 with HTTP; Wed, 16 Jun 2010 19:41:23 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149285>

Say there's a Git repository with two branches: default (which is the
default branch) and branch.  I want to checkout branch and start
working on that but am unsure of how to do it.  Here are the commands
that I did:

git clone git@github.com:username/repo.git
cd repo
git checkout branch

But that gets me the following error:

fatal: Not a git repository (or any of the parent directories): .git

I do "git branch" and here's what I see:

* default

Where's "branch"?

And let's say I wanted to create my own branch based on "branch".
Let's say "branch-zelnaga".  How would I do that?  Do I just checkout
that branch, create a new branch while the current working directory
contains files from the desired branch and then push / commit as
appropriate?
