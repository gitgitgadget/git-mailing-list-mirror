From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: GIT on MinGW problem
Date: Fri, 25 May 2007 11:45:09 +0200
Message-ID: <e5bfff550705250245l507e9901o669c9aa57c5fccf7@mail.gmail.com>
References: <1dbc01c79432$b4400a80$0200a8c0@AMD2500> <464534EE.30904@xs4all.nl>
	 <4656A304.AF39A0B6@eudaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Johannes Sixt" <J.Sixt@eudaptics.com>
X-From: git-owner@vger.kernel.org Fri May 25 11:45:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrWMF-0007yf-Gp
	for gcvg-git@gmane.org; Fri, 25 May 2007 11:45:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751254AbXEYJpL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 May 2007 05:45:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751163AbXEYJpL
	(ORCPT <rfc822;git-outgoing>); Fri, 25 May 2007 05:45:11 -0400
Received: from nz-out-0506.google.com ([64.233.162.238]:32817 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751254AbXEYJpK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2007 05:45:10 -0400
Received: by nz-out-0506.google.com with SMTP id n1so289594nzf
        for <git@vger.kernel.org>; Fri, 25 May 2007 02:45:09 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lMN2lG1YJYgsNH/tRtq2V/FnDbKk5wS7tWSFxYYGySkkhNCIJ22Ype4+V/cXNC0j2XMHJ3oE0fdM9GzjRrvpvIunLVsV6ypT2cgQ9wlb8MiLW2c98M3eFpXJzWzDatNILlRykljB2Dcm7UHH9jJ7MQjF/1aGivfuw2h9f2ua6AU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Z4k67jX6o9l18tATkBK8RoZz2v0pm8snh7YirlWosysed9ILus9sKak1IePN1RhFt6KVid7eAERSyTUcuh/5PvS+tmVHQ8Qj+4gA0nhOW+RT7iFcarJVmZpCe8d6oFkU9IMDgTxjuty6Fh2iEVvGRjv5u5OdXA93lSMav5gWVT0=
Received: by 10.114.179.1 with SMTP id b1mr1419228waf.1180086309084;
        Fri, 25 May 2007 02:45:09 -0700 (PDT)
Received: by 10.114.61.9 with HTTP; Fri, 25 May 2007 02:45:09 -0700 (PDT)
In-Reply-To: <4656A304.AF39A0B6@eudaptics.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48347>

On 5/25/07, Johannes Sixt <J.Sixt@eudaptics.com> wrote:
> Han-Wen Nienhuys wrote:
> >
> > Aaron Gray escreveu:
> > > Hello,
> > >
> > > I have installed the git-1.5.1-1.mingw.exe from
> > > http://lilypond.org/git/binaries/mingw/.
> > >
> > > On typing 'git' I get a message box saying :-
> > >
> > >        The procedure entry point libiconv could not be located in the
> > > dynamic link library libiconv-2.dll.
> > >
> > > I cannot seem to find libiconv-2.dll anywhere either.
> >
> > This should be fixed in
> >
> > http://lilypond.org/git/binaries/mingw/git-1.5.1-2.mingw.exe
> >
> > it should also set $PATH.
>
> I gave this some more testing and it turns out to be a well working
> toolset. Thank you very much!
>
> There were still some issues remaining. These are the ones that should
> be fixable easily:
>
> * git version reports just:
>
>         git version -dirty
>
> Since git-gui parses the output of git version, but does not expect it
> to be of this format, and fails with an error message that it cannot
> parse the version.
>

Yes, an error message at startup is shown also with qgit.

Also 'git status' seems to have some issues.


 Marco
