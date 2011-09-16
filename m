From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: zealous git convert determined to set up git server
Date: Fri, 16 Sep 2011 22:30:35 +0530
Message-ID: <CAMK1S_jK2w8v4ushsZztQ0QY-eZq8axso-DpmCCvA=Gp7iXkBg@mail.gmail.com>
References: <CAOZxsTqtW=DD7zFwQLjknJR8g0nnh0WPUPna6_np4bVoGnSntQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, Git List <git@vger.kernel.org>
To: Joshua Stoutenburg <jehoshua02@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 16 19:00:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R4bmN-0003OS-Ee
	for gcvg-git-2@lo.gmane.org; Fri, 16 Sep 2011 19:00:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755204Ab1IPRAh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Sep 2011 13:00:37 -0400
Received: from mail-vw0-f42.google.com ([209.85.212.42]:53573 "EHLO
	mail-vw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751683Ab1IPRAg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Sep 2011 13:00:36 -0400
Received: by vwl1 with SMTP id 1so7361861vwl.1
        for <git@vger.kernel.org>; Fri, 16 Sep 2011 10:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=A/B6anv68BGEgyX/X7s4kE6Qaf2hcnMeaGIdrl9H+UA=;
        b=dhg39xYJnk2vhv2NUxZDUPO2cnA0N+q6HROVWoKVaxWWizPcQQ5DVvdLYTMpOTzbMt
         WsXS5lVQ42IomK3UTdXSWH+4a8BE27By8aUPBXMbHMo3uLMuixnZYZmUyE1ZYy3sRh4o
         x+3bx2EOo/Rkt8K+DzoSDmPo5Df9890xkvL/Y=
Received: by 10.52.89.165 with SMTP id bp5mr974138vdb.339.1316192435645; Fri,
 16 Sep 2011 10:00:35 -0700 (PDT)
Received: by 10.52.161.197 with HTTP; Fri, 16 Sep 2011 10:00:35 -0700 (PDT)
In-Reply-To: <CAOZxsTqtW=DD7zFwQLjknJR8g0nnh0WPUPna6_np4bVoGnSntQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181539>

On Thu, Sep 15, 2011 at 5:08 PM, Joshua Stoutenburg
<jehoshua02@gmail.com> wrote:

> Question 2: It seems gitolite is the popular choice for git user
> management. =C2=A0Any reason why?

Well it *is* pretty darn powerful (I'm the author; allow me some
preening!) but I believe the real reason is that it is the most
*transparent* solution.

The other contendors *all* involve web-based setup/management, and
often include things like wikis, issue tracking, graphical views on
the web, commenting on commits, code review (in case of gerrit), etc.
etc.  Gitolite is the only system where the end user (developer) may
not even realise it's installed unless he runs up against an access
restriction.
