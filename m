From: Howard Miller <howardsmiller@googlemail.com>
Subject: Re: Newbie "svn update" question
Date: Tue, 1 Dec 2009 09:45:20 +0000
Message-ID: <26ae428a0912010145k61dbfc41l8243363493918445@mail.gmail.com>
References: <loom.20091201T101313-496@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Mikko Oksalahti <mikko@azila.fi>
X-From: git-owner@vger.kernel.org Tue Dec 01 10:45:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFPIY-0004Tq-4h
	for gcvg-git-2@lo.gmane.org; Tue, 01 Dec 2009 10:45:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753856AbZLAJpQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Dec 2009 04:45:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753803AbZLAJpP
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Dec 2009 04:45:15 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:55413 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753781AbZLAJpO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Dec 2009 04:45:14 -0500
Received: by ewy19 with SMTP id 19so4712842ewy.21
        for <git@vger.kernel.org>; Tue, 01 Dec 2009 01:45:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=sdNJiZpgN7PTBR5kBRaMl3LvLHkYNQib25Mcy6E0120=;
        b=AjC2m2mkRPAv1QQnmAHrIz7Sdo47RubleAGoRfWIXFJIqS1H0KnaIio8TTjaQDEOpR
         3g+NlOGPhN/XIIMTeuwXp71A4AmYUiCQgyDvULdSEO1k1GiGtSPJW1mA/BAd+AdmRFrI
         0KGZZ6tF5l3TGvifJr2vXlzgLqXmYXB9/O4dY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=E/HeECrq+ZSImtiUGqMR6u4VJ3HcxPK4zLEvwG5Uf3l0JWyve4/j2Ji4AxAiUeNJDh
         XzGSlRKzgMVW63BXsu2p7wIT7FgkQ7k86j008R9I84PmtIwkjX75yBd1MdHgdhstkFi3
         8H/ikFrDoFLqIieqtE+Z+543LKvCzhfowlYXk=
Received: by 10.213.0.144 with SMTP id 16mr6176978ebb.37.1259660720038; Tue, 
	01 Dec 2009 01:45:20 -0800 (PST)
In-Reply-To: <loom.20091201T101313-496@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134189>

2009/12/1 Mikko Oksalahti <mikko@azila.fi>:
> Hi,
>
> I just started using git for my personal projects at home. Basic usag=
e seems
> pretty straight-forward as well as setting up everything. However, I =
have a
> simple question about how do I mimic an "svn update" command on a loc=
ally
> created repository. Here's what I do:
>
> some_existing_project_dir> git init
> some_existing_project_dir> git add .
>
> (about 1000 files added...)
>
> some_existing_project_dir> git commit -a -m "initial commit"
>
> (now I edit 10 files and accidentally delete some files that I'm not =
aware of)
>
> How do I now get the accidentally deleted files back from the reposit=
ory without
> losing local changes made to 10 files?
>
> I've tried using: "git checkout HEAD ." but my local changes after la=
st commit
> will be lost.
>
> I've tried using: "git pull ." but the deleted files are not restored=
=2E
>
> So I'm looking for an "svn update" equivalent command that would sema=
ntically do
> this: "Get the latest version of all files from the repository and me=
rge them
> with any local changes I've made to files."
>
> I know a suitable command is available and I'm just a moron who can't=
 read the
> manual correctly but help me out anyway :P
>
> =A0Regards,
> =A0 =A0 Mikko

'git status' should show you what files you have deleted.  'git
checkout filename' should get them back. I can't think of a way of
recovering every file you have just deleted although - I suspect it
might be tricky. Thinks like 'git pull' only apply to remote
repositories and you don't have one of those. You're not thinking of
it the right way (yet) :-)

Howard
