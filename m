From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: GIT on MinGW problem
Date: Mon, 21 May 2007 14:22:54 -0400
Message-ID: <fcaeb9bf0705211122sef3abf6sb3633f09228a7e7d@mail.gmail.com>
References: <1e5001c794a0$aac23140$0200a8c0@AMD2500>
	 <033501c79710$a2eb0290$0200a8c0@AMD2500>
	 <f329bf540705151251n10c05452s5a74e8eaa513bf90@mail.gmail.com>
	 <464ABAAF.C6603C5@eudaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Johannes Sixt" <J.Sixt@eudaptics.com>
X-From: git-owner@vger.kernel.org Mon May 21 20:23:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqCX8-0005M4-T0
	for gcvg-git@gmane.org; Mon, 21 May 2007 20:23:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756365AbXEUSW4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 May 2007 14:22:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756613AbXEUSW4
	(ORCPT <rfc822;git-outgoing>); Mon, 21 May 2007 14:22:56 -0400
Received: from an-out-0708.google.com ([209.85.132.243]:36729 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756365AbXEUSWz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2007 14:22:55 -0400
Received: by an-out-0708.google.com with SMTP id d18so394540and
        for <git@vger.kernel.org>; Mon, 21 May 2007 11:22:54 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WdcZrnaoDqTgDwspOTZIVDrLWMcSyxITvId7vu55gfjz6M2b3Wy8/fS5fYTrZLr0LxBe/evJix/wfwYyO4wrQ5ZWYQ1B8uZWgs0CITl/+rtEouk9t2hhu0mKgNyeSdFVii+gkZPYPNrwcn4BqVGNiuuHKKk4p/pzFso5hyW6M0I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lzkEvOKCO/NKkdw5YLmNbyzT4x712i8svMQm9OAGDSM65c1oFOJzcTqahzZ6+JuZOeOY6v1WMGvACA1DNGBCCWJWgNMhU1PXS24yrvXCMmwmlxEFYLJve+rYSndocf4WTA6clCPsyUEQUbhH6xwnS++0LPbubZnJdfmltzG2huI=
Received: by 10.100.254.10 with SMTP id b10mr3176606ani.1179771774763;
        Mon, 21 May 2007 11:22:54 -0700 (PDT)
Received: by 10.100.127.2 with HTTP; Mon, 21 May 2007 11:22:54 -0700 (PDT)
In-Reply-To: <464ABAAF.C6603C5@eudaptics.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48038>

On 5/16/07, Johannes Sixt <J.Sixt@eudaptics.com> wrote:
> Han-Wen Nienhuys wrote:
> >
> > I think it might be a bug. Patches are welcome.
> >
> > I suppose git-clone has a hardcoded path. Paths under windows should
> > be either taken from registry (yuck) or dynamically detected from
> > $PATH and argv[0].
> >
> > 2007/5/15, Aaron Gray <angray@beeb.net>:
> > > Han-Wen,
> > >
> > > Dont know whether you got the message or not so I'll try you again.
> > >
> > > On doing a git-clone I get the message :-
> > >
> > >         warning: templates not found /usr/share/git-core/templates/
> > >
>
> This should have been fixed by 2d84ffaf (currently master~1 in
> git://repo.or.cz/git/mingw.git) and its parent. Can you make sure that
> your build picks up the new Makefile setting that these commits
> introduce?

That commit didn't work for me because template_dir was overridden by
config.mak.autogen
-- 
Duy
