From: Peter Harris <git@peter.is-a-geek.org>
Subject: Re: git svn and multiple cloned repositories
Date: Tue, 30 Jun 2009 09:44:28 -0400
Message-ID: <eaa105840906300644s6bc9b619i24bd54537f4a67d4@mail.gmail.com>
References: <h2d043$4tm$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Bruno Harbulot <Bruno.Harbulot@manchester.ac.uk>
X-From: git-owner@vger.kernel.org Tue Jun 30 16:19:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from mail-forward2.uio.no ([129.240.10.71])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLe9C-0000ux-Th
	for gcvg-git-2@gmane.org; Tue, 30 Jun 2009 16:17:22 +0200
Received: from exim by mail-out2.uio.no with local-bsmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1MLddX-00081H-Jx
	for gcvg-git-2@gmane.org; Tue, 30 Jun 2009 15:44:39 +0200
Received: from mail-mx3.uio.no ([129.240.10.44])
	by mail-out2.uio.no with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1MLddX-00081E-Ip
	for gcvg-git-2@gmane.org; Tue, 30 Jun 2009 15:44:39 +0200
Received: from vger.kernel.org ([209.132.176.167])
	by mail-mx3.uio.no with esmtp  (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1MLddV-0004Nn-UF
	for gcvg-git-2@gmane.org; Tue, 30 Jun 2009 15:44:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751781AbZF3No1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2009 09:44:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751754AbZF3No1
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jun 2009 09:44:27 -0400
Received: from mail-ew0-f210.google.com ([209.85.219.210]:44422 "EHLO
	mail-ew0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751606AbZF3No1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2009 09:44:27 -0400
Received: by ewy6 with SMTP id 6so179194ewy.37
        for <git@vger.kernel.org>; Tue, 30 Jun 2009 06:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=96r/TgBp/Jx829JvT0uHI8PzbqrdKalE0pJKw6kvoAg=;
        b=SbtBSeS+od36fvZZe1UwFo+xMEiySTQbAHzp9u0zCSvkJc0hCuEKS3aDwK2ZuX6DHO
         MucaDEUD6nGJFya6i1EP0AWZ1UXRf2ELEjmj+tDB/2q0LbscFG+Sy2DuCXQWtZrLL7WC
         aH1Qm7O6w6d6roVITc2g/LYZ+wcfP2FFKc0rA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=LMNUtHufUBHw0mdm40X5Tvh7ggcuuJF7hhKM6ni4bmF7n2W5T8y9XyiIM7rQHqNfqu
         lhJ6jaHTcCeUBWNVx3nCYOnFqbfFlr5yB27DGxMYSjQW2hYF0EZqHlY4n/O6xdNSMa0m
         jkUt4SiXQ10I5lOx9tstqyiKBSgYzz2z73JVg=
Received: by 10.210.53.1 with SMTP id b1mr125823eba.81.1246369468117; Tue, 30 
	Jun 2009 06:44:28 -0700 (PDT)
In-Reply-To: <h2d043$4tm$1@ger.gmane.org>
X-Google-Sender-Auth: c583cdb472e9afaa
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
X-UiO-Spam-info: not spam, SpamAssassin (score=-7.0, required=5.0, autolearn=disabled, RCVD_IN_DNSWL_MED=-4,UIO_VGER=-3, uiobl=NO, uiouri=_URIID_)
X-UiO-Scanned: EDC090FF815059DB4311698EDCFE3CC1C510FB4E
X-UiO-SPAM-Test: remote_host: 209.132.176.167 spam_score: -69 maxlevel 80 minaction 2 bait 0 mail/h: 103 total 2547669 max/h 849 blacklist 0 greylist 0 ratelimit 0
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122514>

On Tue, Jun 30, 2009 at 8:23 AM, Bruno Harbulot wrote:
> I participate in a few open-source projects for which I provide patches
> sometimes, but most of these projects use Subversion. git-svn is very
> convenient for trying out patches without interfering with the main branch
> (so as to submit them when they're ready). I presume many 'git svn' users do
> something like this too.
>
> However, I'd like to keep multiple copies of this repository (on a few
> machines, including one on a backup server) with the appropriate SVN
> metadata. I'd also like to be able to do 'git svn fetch' on only one of
> these cloned repositories (perhaps via crontab on the server) and to be able
> to push/pull this SVN metadata along with the commits between the cloned git
> repositories.
>
>
> Is there a recommended way to do this?
>
>
> I have found 3 ways of achieving this, but none of them seem ideal:
>
> 1. Copying the entire cloned repository as regular files and doing 'git svn
> fetch' regularly on each copy.

> 2. Transferring the SVN references by hand.

> 3. Using 'git clone --mirror' (only works with --bare option).

I use 4. Set up git remotes by hand to populate svn remotes directly.

  - On 'backup-server':
git svn clone -s svn://upstream/project
crontab -e  # run git svn fetch periodically

  - On 'machineX':
mkdir project
cd project
git init
git remote add origin git://mirror/project
git config --add remote.origin.fetch refs/remotes/*:refs/remotes/*
git fetch
git svn init -s svn://upstream/project
git reset --hard trunk
git svn rebase

Peter Harris
