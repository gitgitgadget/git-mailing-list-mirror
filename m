From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: [PATCH] Documentation: Fix git.7 dependencies.
Date: Fri, 19 Jan 2007 21:20:22 +0100
Message-ID: <8aa486160701191220v73836c20h74e044f7d2dcfd7d@mail.gmail.com>
References: <873b67735m.fsf@gmail.com>
	 <7vbqkuhlhi.fsf@assigned-by-dhcp.cox.net>
	 <8aa486160701191138v7fc29e53xbf809b1495e30b3d@mail.gmail.com>
	 <7vtzymg5dg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 19 21:20:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H80Dr-0003ZK-UT
	for gcvg-git@gmane.org; Fri, 19 Jan 2007 21:20:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964899AbXASUUZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 19 Jan 2007 15:20:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964907AbXASUUZ
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jan 2007 15:20:25 -0500
Received: from wr-out-0506.google.com ([64.233.184.236]:60175 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964899AbXASUUY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Jan 2007 15:20:24 -0500
Received: by wr-out-0506.google.com with SMTP id i22so499625wra
        for <git@vger.kernel.org>; Fri, 19 Jan 2007 12:20:23 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gCjS3VJk+CzNwtzDQBJDcq+2V/cCHhX/Y/2VL6MSrN4TCgcSlLCP3YFH8rcmP5BDcuajjPcrn4J0DnsNcRVpvhyP+swg49CV1WrdhdAJ9RX7XKxdRElArvCATQreNTegbbmTfVcJOOC/Dh84XlImudmcJVtcw6YxtSij0H6xS40=
Received: by 10.82.120.14 with SMTP id s14mr1031516buc.1169238022321;
        Fri, 19 Jan 2007 12:20:22 -0800 (PST)
Received: by 10.78.68.8 with HTTP; Fri, 19 Jan 2007 12:20:22 -0800 (PST)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vtzymg5dg.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37200>

On 1/19/07, Junio C Hamano <junkio@cox.net> wrote:
> "Santi B=E9jar" <sbejar@gmail.com> writes:
>
> > On 1/19/07, Junio C Hamano <junkio@cox.net> wrote:
> >> > -git.7 git.html: git.txt core-intro.txt
> >> > +git.7 git.html: git.txt core-intro.txt $(cmds_txt)
> >>
> >> I do not think this is needed; doesn't doc.dep catch cmds_txt as
> >> well?
> >
> > It's not needed. I didn't see the doc.dep.
>
> Thanks for sanity-checking.
>
> The reason for the first hunk I gave in my previous message was
> wrong, by the way; there is no circular dependency.  The first
> hunk is a good change nevertheless, because what will be in
> cmds-*.txt command list does not depend on what is in git.txt.

I can not reproduce it, but I got a circular depencency. This was my
motivation for the patch. Anyway, at least there is a usefull hunk in
my patch :)

Santi
