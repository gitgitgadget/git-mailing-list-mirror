From: "Thomas Adam" <thomas.adam22@gmail.com>
Subject: Re: Extremely simple Vim interface for Git
Date: Sun, 7 Sep 2008 14:23:41 +0100
Message-ID: <18071eea0809070623v4a54cbb8j2face0724651ef56@mail.gmail.com>
References: <20080906193744.GA3122@mithlond.arda.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Teemu Likonen" <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Sun Sep 07 15:24:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcKG2-000125-9u
	for gcvg-git-2@gmane.org; Sun, 07 Sep 2008 15:24:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753727AbYIGNXo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Sep 2008 09:23:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753734AbYIGNXo
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Sep 2008 09:23:44 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:28300 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753724AbYIGNXn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Sep 2008 09:23:43 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1166903fgg.17
        for <git@vger.kernel.org>; Sun, 07 Sep 2008 06:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=kGgzlsFQAAyk3xfoLcfQO4rBaDzDpuDIclBk7Thsjw4=;
        b=rVpsdbJbPBjjR6X2E89cwaIUcxaO9ltUPvEzCEn+dWlo/0H9zTfDua4tQc4Pu2z6lb
         VP98xIcQApolLA/OLK0DRW7GtAPn/nYUz/aQJ5IZo/+3VuNi43mkjKECbYEMeC2ADTTX
         paxFpRj/8rvueFsbVxRQxLhv5SJ11oIU5AaPE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=o8zPPdhZN10JlleqmNk7b9hK1bq63x0yckEjMp7MhXo869/tAmM1xPv9sfegeblMI1
         YdROF3xkG4Q2hDLN/tNp2Xp15ax4/ulrLHtRjG8Ul0EDrMjYU5XdVJGcDxpzWDd4oxAN
         dcJqgu9g6ki4WP+HIefuc+K62gGyZDWFqn3S8=
Received: by 10.103.170.13 with SMTP id x13mr9393416muo.52.1220793821760;
        Sun, 07 Sep 2008 06:23:41 -0700 (PDT)
Received: by 10.103.182.8 with HTTP; Sun, 7 Sep 2008 06:23:41 -0700 (PDT)
In-Reply-To: <20080906193744.GA3122@mithlond.arda.local>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95137>

Hi --

2008/9/6 Teemu Likonen <tlikonen@iki.fi>:
> Here's a very simple idea for using Git from Vim editor. Add these lines
> to your ~/.vimrc file:
>
>
>    command! -complete=file -nargs=* Git   call s:RunShellCommand('git '.<q-args>)
>    command! -complete=file -nargs=* Svn   call s:RunShellCommand('svn '.<q-args>)
>    command! -complete=file -nargs=+ Shell call s:RunShellCommand(<q-args>)

Looks interesting.  Have you seen this though:

http://code.google.com/p/vcscommand/

-- Thomas Adam
