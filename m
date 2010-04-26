From: Chris Packham <judge.packham@gmail.com>
Subject: Re: RFD: git-bzr: anyone interested?
Date: Mon, 26 Apr 2010 14:41:59 -0700
Message-ID: <p2ka038bef51004261441x7e4857f1mc3f03a4104f8e018@mail.gmail.com>
References: <4B7D8358.1080108@gmail.com>
	 <fabb9a1e1002181037n58d6942dpa63a57a23f506d9c@mail.gmail.com>
	 <4B7E3856.3080609@gmail.com> <20100219135549.GA31796@Knoppix>
	 <4B820B4E.7050405@gmail.com> <20100222105133.GA10577@Knoppix>
	 <4B834989.50502@gmail.com> <20100223124553.GA19153@Knoppix>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Gabriel Filion <lelutin@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 26 23:42:25 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6W4M-0002fy-UD
	for gcvg-git-2@lo.gmane.org; Mon, 26 Apr 2010 23:42:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755364Ab0DZVmE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Apr 2010 17:42:04 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:62555 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755361Ab0DZVmB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Apr 2010 17:42:01 -0400
Received: by vws13 with SMTP id 13so256006vws.19
        for <git@vger.kernel.org>; Mon, 26 Apr 2010 14:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=kK6hx5TlyBjKlg+mocfmp6Tnw9iRvVmC4oP0kjBQH1U=;
        b=twSd+edAWOe+qKcQv8rgrXBTpySfsFIcBcov1fhHNRIQsH6wVoJjeBQA8mvR3UhcxR
         zlyk0qW04b8qSM2v7qftK4STIAle5ANtAK/XTA09mM6ZY4aTHWRjJmfdPGfwXBGiFsnW
         L0oggp3DI/pahT6ZazwXSaInHRWFBtTjQ5zak=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=YUbI0REu5KWVKFbEIAuqohUSRIeVF6Rv+D72GLr+eXzAVwfeJfGnxOIRK+sbR3XkaZ
         oq2msME/C0QMyZlFNSZPgTp8QT4ScbqJ1FLZAxMrbqxTLe/5TuewA104WZ5KqxR7Noox
         8Ax9Pe3tjrZ+H7TOAIeHe7tFg3SdbxhJVn6m8=
Received: by 10.229.232.144 with SMTP id ju16mr5780276qcb.107.1272318120070; 
	Mon, 26 Apr 2010 14:42:00 -0700 (PDT)
Received: by 10.229.11.77 with HTTP; Mon, 26 Apr 2010 14:41:59 -0700 (PDT)
In-Reply-To: <20100223124553.GA19153@Knoppix>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145856>

Hi,

How far did git-bzr or git-remote-bzr get?

I've tried git-bzr from the repo and I seem to be stumbling on bzr not
having the fast-export command after I install the fast-import plugin
as per [1]. So I think its a bazzar problem not a git-bzr one. Has
anyone got a fully worked example including the installation of the
required bits and pieces.

Alternatively what I'm really trying to do is update a series of
patches for an upstream project that is managed with bazzar. We have
30 or so patches with our customizations so I'd like to get git (or
bzr) to do the heavy lifting for me. In git I'd do something like this

git clone <upstream>
git checkout <tag that corresponds to the version of the tarball we use>
git checkout -b our-patches
git am <patches>
git rebase <tag that corresponds to the new version we want to use>
git format-patch ...

Anybody got a similar recipe for bzr? (yes I'll go ask on the bzr list too)

[1] http://github.com/kfish/git-bzr/blob/master/README
