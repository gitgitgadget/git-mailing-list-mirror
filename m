From: "Han-Wen Nienhuys" <hanwenn@gmail.com>
Subject: Re: GIT on MinGW problem
Date: Tue, 15 May 2007 16:51:44 -0300
Message-ID: <f329bf540705151251n10c05452s5a74e8eaa513bf90@mail.gmail.com>
References: <1e5001c794a0$aac23140$0200a8c0@AMD2500>
	 <033501c79710$a2eb0290$0200a8c0@AMD2500>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: "Aaron Gray" <angray@beeb.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 15 21:51:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ho33p-0000ov-Be
	for gcvg-git@gmane.org; Tue, 15 May 2007 21:51:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754921AbXEOTvp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 May 2007 15:51:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754920AbXEOTvp
	(ORCPT <rfc822;git-outgoing>); Tue, 15 May 2007 15:51:45 -0400
Received: from an-out-0708.google.com ([209.85.132.242]:12617 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754711AbXEOTvo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 May 2007 15:51:44 -0400
Received: by an-out-0708.google.com with SMTP id d18so545632and
        for <git@vger.kernel.org>; Tue, 15 May 2007 12:51:44 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SzIpSqGLt8s8KQcb5Wgax1L20IYfGpJtVrXbgNLK01GGaJWhE37fVeRwIF+PV2SQ8kMGMXWzGxsyShuhUK2vpHrpzzFYENPgYiwWZbiFJ2ASQYszZuMfNln3crT4KvIopT/zD28bdxRBGo1l4SKJ4y9v6hb7Mlxd61Rw2X8Fwgo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=r9Uni+vgbuZeRKBBO9rg8jEc4y/kwqx7/fFS92GH++i519y10X+qmBgDfgHAVMs+6brxF1XPdm6LnSEa6bofBTvuYEqKOVoG9nFUzXEXhN5POmqWzImPyVfvRye+yFbw8gn7iRQPPwVFpWO5hEh3e64ksHwNHuVBDAwN28P93QM=
Received: by 10.100.12.18 with SMTP id 18mr5722859anl.1179258704153;
        Tue, 15 May 2007 12:51:44 -0700 (PDT)
Received: by 10.100.142.1 with HTTP; Tue, 15 May 2007 12:51:44 -0700 (PDT)
In-Reply-To: <033501c79710$a2eb0290$0200a8c0@AMD2500>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47370>

I think it might be a bug. Patches are welcome.

I suppose git-clone has a hardcoded path. Paths under windows should
be either taken from registry (yuck) or dynamically detected from
$PATH and argv[0].

2007/5/15, Aaron Gray <angray@beeb.net>:
> Han-Wen,
>
> Dont know whether you got the message or not so I'll try you again.
>
> On doing a git-clone I get the message :-
>
>         warning: templates not found /usr/share/git-core/templates/
>
> Regards,
>
> Aaron
>
> > >This should be fixed in
> >>
> >>http://lilypond.org/git/binaries/mingw/git-1.5.1-2.mingw.exe
> >
> > Great.
> >
> > I could not get commands like git-clone to work from CMD although this is
> > not really a handycap for the time being.
> >
> > On doing a clone I get the message :-
> >
> >        warning: templates not found /usr/share/git-core/templates/
>
>


-- 
Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
