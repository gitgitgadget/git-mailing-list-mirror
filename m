From: Hin-Tak Leung <hintak.leung@gmail.com>
Subject: Re: git svn's performance on cloning mono's branches/tags...
Date: Sun, 28 Jun 2009 04:08:01 +0100
Message-ID: <3ace41890906272008t96bfb04q7218e95055897900@mail.gmail.com>
References: <3ace41890906251739r45b3eae9oe1b7e32886defc0f@mail.gmail.com>
	 <4A445959.6090403@op5.se>
	 <3ace41890906260259o3be005fq6be9d0e2c3f9af66@mail.gmail.com>
	 <4A44A9A9.6030008@op5.se>
	 <3ace41890906260644t3eddb2d2sb4ddbcb6499801@mail.gmail.com>
	 <3ace41890906261817y523c9321xd621fb3130941d91@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Sun Jun 28 05:08:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MKkkY-0003qi-0n
	for gcvg-git-2@gmane.org; Sun, 28 Jun 2009 05:08:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752262AbZF1DIB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Jun 2009 23:08:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752094AbZF1DIA
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jun 2009 23:08:00 -0400
Received: from mail-ew0-f210.google.com ([209.85.219.210]:62096 "EHLO
	mail-ew0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751836AbZF1DH7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jun 2009 23:07:59 -0400
Received: by ewy6 with SMTP id 6so4584143ewy.37
        for <git@vger.kernel.org>; Sat, 27 Jun 2009 20:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=b09fR7cmJbGQ+gViLZ1hPV5riUOQagiVndmy8ESAkuU=;
        b=I90RuntjsCLXTbQDMO/wObvV7vFWyI++OSs6HzSlFbOt4fBt+K3ceU03Po3dsvhFkP
         gsnYcEau3VaCgfUgB745zCcAFDbRnnn16phKuj3ND/k9R3C28leCrSpBCmNohvZSEzbl
         aHSmkXrcX94mstaehqyBgXrAoF1itf42ACyNI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=HMooDZob9tb7TBdlfh+Sm44wqjq2zLhGx0lXdJ4A+dX3FEBonmVr0E/3ImRsZzjjT0
         h0aM+64aTGA3b/oCW5x3CnoP/opwm6nr+N6+aWvh19TGU0rUfhtd6PKIa3QjgaGO0bRZ
         pp/NPEEYRycQ8wcJydWxWEwQcILCH9hwXTYS0=
Received: by 10.216.13.209 with SMTP id b59mr1634945web.44.1246158481474; Sat, 
	27 Jun 2009 20:08:01 -0700 (PDT)
In-Reply-To: <3ace41890906261817y523c9321xd621fb3130941d91@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122393>

On Sat, Jun 27, 2009 at 2:17 AM, Hin-Tak Leung<hintak.leung@gmail.com> wrote:

> the tags, branches, url entries are effectively the same, I think - so
> the main difference is using trunk instead of fetch.
> Why does it make any difference? The example at the bottom of
> git-svn's man page uses the trunk notation. Maybe it should be
> changed?
>

To answer my question - I think the man page should be updated.

Also, while searching 'git svn speed', I found that a git clone of
mono is available:
http://www.mono-project.com/GitSVN
A shame this page is not referenced my other devel resources on mono's
web site at all... also it uses a real user's account to make the
clone (rather than annonymous svn), so to update the git clone by
git-svn, one needs a real dev account - that is not a problem for the
purpose of sending in patches as the occasional dev.
