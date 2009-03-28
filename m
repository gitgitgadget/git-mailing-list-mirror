From: Jacob Helwig <jacob.helwig@gmail.com>
Subject: Re: Fork of abandoned SVN mirror - how to keep up to date with the 
	SVN
Date: Sat, 28 Mar 2009 13:27:07 -0700
Message-ID: <8c9a060903281327j33056807j78a2cd03b8151979@mail.gmail.com>
References: <22756729.post@talk.nabble.com> <8c9a060903280922r6514de83mea4dea84c4116225@mail.gmail.com> 
	<1238258794470-2549665.post@n2.nabble.com> <8c9a060903281102r3eae26edta34899485feb884b@mail.gmail.com> 
	<1238263580197-2549943.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: jamespetts <jamespetts@yahoo.com>
X-From: git-owner@vger.kernel.org Sat Mar 28 21:28:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lnf9E-0005it-KW
	for gcvg-git-2@gmane.org; Sat, 28 Mar 2009 21:28:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752888AbZC1U1Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Mar 2009 16:27:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752802AbZC1U1Y
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Mar 2009 16:27:24 -0400
Received: from wf-out-1314.google.com ([209.85.200.170]:3006 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751211AbZC1U1X convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 Mar 2009 16:27:23 -0400
Received: by wf-out-1314.google.com with SMTP id 29so1924104wff.4
        for <git@vger.kernel.org>; Sat, 28 Mar 2009 13:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=2rQ/GgIK3b60yKPlfEg0PMXtv2DqNbUydB697YI4AkY=;
        b=kJjrl/BU018/xRQpsvOVpW2Ot4vqRIaT0CRle0OuV4r/3JLfCDfnsgKrJFHbMLwysq
         oVN/jIUhYQCedz0N/KLaF/eeI76+eL908896bnRrs2sNKTKZruSEzrFAqb26zbtkWX1c
         Zotp0Qy50ugpS5KO6eIGOVXgv90fHVdr05GqI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=BaUDV8CnSVdVav5vTK6w8FZpR3KLxKJ3gBd0bdEjF2Z1vB60mw/TjDxQ34mt0ioF5T
         WKsJ2xx+85xHiEdHjpPfyKaau4873zUidgS86KJOpTjuDht4X2ZDtAeCNGvjBhVe9FmR
         JBVFQgWNV4dtAZnh9mKMnfMZMKlPIFwkWtwZU=
In-Reply-To: <1238263580197-2549943.post@n2.nabble.com>
Received: by 10.142.214.11 with SMTP id m11mr1451041wfg.183.1238272042245; 
	Sat, 28 Mar 2009 13:27:22 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114975>

On Sat, Mar 28, 2009 at 11:06, jamespetts <jamespetts@yahoo.com> wrote:
>
> Thank you very much for your reply :-) Ahh, I didn't realise that that sort of SVN URL should be avoided. Is there any way around that when the project itself uses that sort of URL? And I think that it does require a username and empty password. I haven't tried the Github IRC channel - I must confess - I did not know that there was one.
>
> Any suggestions about how to deal with the other problem?
>

It looks like GitHub won't keep the project in sync for you, so you're
probably best off doing the git-svn clone yourself, and maintaining it
that way.

http://github.com/guides/import-from-subversion
