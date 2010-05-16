From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH v2] ls-remote: print URL when no repo is specified
Date: Sun, 16 May 2010 12:36:22 +0200
Message-ID: <AANLkTikKZAinLGeRMnqUPsTbBjMiAQuOCXxr4VEPBhHW@mail.gmail.com>
References: <1273416140-5044-1-git-send-email-rctay89@gmail.com> 
	<1273598423-3156-1-git-send-email-rctay89@gmail.com> <7veihh8y8b.fsf@alter.siamese.dyndns.org> 
	<AANLkTinxm8hwX53LE9_7rDPoKs9UnGAyFFfVcoh-WGxE@mail.gmail.com> 
	<C21B68F7-E430-4BCA-A1D1-80446B0B76DE@adacore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Tay Ray Chuan <rctay89@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Geert Bosch <bosch@adacore.com>
X-From: git-owner@vger.kernel.org Sun May 16 12:36:51 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ODbDG-0006L9-6i
	for gcvg-git-2@lo.gmane.org; Sun, 16 May 2010 12:36:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753054Ab0EPKgp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 May 2010 06:36:45 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:39190 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752058Ab0EPKgo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 May 2010 06:36:44 -0400
Received: by gwaa20 with SMTP id a20so32457gwa.19
        for <git@vger.kernel.org>; Sun, 16 May 2010 03:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=1JekI5IrU1+nAEMSGR2Jl0nZ6fYiAtaeBvC+uIdXEmY=;
        b=YncAhf30ypYJU+XTI0Tm9gOuJC0hpkq1Uldx638ymvsF8f1wPb8KmkN6/Lz/yUl3ZO
         4PoqpIYaPt41j120qfy+cq2UYTEjdxW4U5L166aK/Griw1//Dvro6ycehHSDVwYG+4/+
         +mHZKnnWfTnMXLoDTOdFZ6a+r9/hsZtBT/q3w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=ZyPO7vF/vJC58lHro7+v9mZCPcvXC92I28chSWsNCnKdvfxgJUZ90jwFIlOf+FIuge
         oGXAnHMpwbxD6aphc386qguRj4oBk0n9hFROxKpS5+jWt8Vi/UolfG9KoyzkecZ0jF+T
         ssbDMy2pjMN243KlY2jCsL6WPOYyHZcZBcYJ0=
Received: by 10.150.119.30 with SMTP id r30mr4858855ybc.5.1274006202227; Sun, 
	16 May 2010 03:36:42 -0700 (PDT)
Received: by 10.151.125.11 with HTTP; Sun, 16 May 2010 03:36:22 -0700 (PDT)
In-Reply-To: <C21B68F7-E430-4BCA-A1D1-80446B0B76DE@adacore.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147183>

Heya,

On Sun, May 16, 2010 at 04:14, Geert Bosch <bosch@adacore.com> wrote:
> What git seems to be missing is a "git info" command, which
> would print out essentially something like what "svn info" does:
> name of remote repo that we're tracking, name of current branch,
> date/author/subject of last commit.

You can get information about the remote with:

$ git remote -v

And then for the branch etc you can do (although it doesn't list the author):

$ git branch -v

-- 
Cheers,

Sverre Rabbelier
