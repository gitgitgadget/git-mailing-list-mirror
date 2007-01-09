From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [ANNOUNCE] qgit4 aka qgit ported to Windows
Date: Tue, 9 Jan 2007 23:30:34 +0100
Message-ID: <e5bfff550701091430r759c083bse99bd79046f3205f@mail.gmail.com>
References: <e5bfff550701091314k71e282e8x125db65d5c287a94@mail.gmail.com>
	 <200701092255.17091.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "GIT list" <git@vger.kernel.org>, "Petr Baudis" <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Tue Jan 09 23:30:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4PUM-0003N7-Fw
	for gcvg-git@gmane.org; Tue, 09 Jan 2007 23:30:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932478AbXAIWag (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 17:30:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932474AbXAIWag
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 17:30:36 -0500
Received: from nz-out-0506.google.com ([64.233.162.226]:63911 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932478AbXAIWaf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 17:30:35 -0500
Received: by nz-out-0506.google.com with SMTP id s1so4109529nze
        for <git@vger.kernel.org>; Tue, 09 Jan 2007 14:30:34 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UgBnKpJ/lCKBuomdb1VFd4qH5YnWyxCVtidBGb2q/WQikusQUlXh8hK2h/rBtN42KTcAfqqRdcgXSUtvRB3wcf3atVKn24UofGwu+XJ9im9XA/aOC7OWedXwcvW+JtlP4ms6kQzc9ET2bWhQI/NYyvcjj1G/ZsNrVuBpy0qw+aA=
Received: by 10.35.101.1 with SMTP id d1mr51791344pym.1168381834543;
        Tue, 09 Jan 2007 14:30:34 -0800 (PST)
Received: by 10.35.42.4 with HTTP; Tue, 9 Jan 2007 14:30:34 -0800 (PST)
To: "Josef Weidendorfer" <Josef.Weidendorfer@gmx.de>
In-Reply-To: <200701092255.17091.Josef.Weidendorfer@gmx.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36415>

On 1/9/07, Josef Weidendorfer <Josef.Weidendorfer@gmx.de> wrote:
> On Tuesday 09 January 2007 22:14, Marco Costalba wrote:
> > I have setup, (thanks Pasky) the repository
> >
> >      git://repo.or.cz/qgit4.git
> >
> >
> > With an experimental version of qgit, called qgit4.
>
> Nice.
>
> Why not as branch in the original qgit repository?
> You are losing all your history this way.
>

Well, Qt4 it's completely different from Qt3, porting it's a nice way
to say rewrite. So moving patches between the two branches it's very
difficult already now and it will be impossible in a near future not
because of development forking, but because of API. This means two
different and *not mergeable* branches.

Being not mergeable they lose the main motivation to be in the same
repository IMHO. Also I would like to continue to support and improve
the stable and proven Qt3 version on kernel.org that is and will be
the main version.

Perhaps when qgit4 will be stable enough I will ask to move to
kernel.org but now, for easier development I asked to Pasky, that
kindly accepted, to host this repo.

Marco
