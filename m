X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
Subject: Re: Possible but in gitweb
Date: Sat, 18 Nov 2006 18:42:33 +0100
Message-ID: <4d8e3fd30611180942p548a92d1ufc9e0dcfabedb59@mail.gmail.com>
References: <4d8e3fd30611180858xf28e958g8511f2eb68d53848@mail.gmail.com>
	 <ejng62$k2m$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Sat, 18 Nov 2006 17:42:53 +0000 (UTC)
Cc: "Git Mailing List" <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bUPHOaMHsXKOUkdglPdBCE3xVSkoyI76EwZD31TFWV6xFayJvbN7cyc+qzHrUGV1WAt5j2ulhRd0EmJHKL7wHHAD2m4NR5q5BZs5uaqBvK/nF3BXYZDNhfOYp3ndIZw25TnbX7P8FG3SSj6BQEyZI9jb4FLmpGkkS1zS+0PHAlg=
In-Reply-To: <ejng62$k2m$1@sea.gmane.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31781>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GlUDK-0004Gg-Az for gcvg-git@gmane.org; Sat, 18 Nov
 2006 18:42:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755263AbWKRRml convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Sat, 18 Nov 2006 12:42:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755270AbWKRRml
 (ORCPT <rfc822;git-outgoing>); Sat, 18 Nov 2006 12:42:41 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:45766 "EHLO
 nf-out-0910.google.com") by vger.kernel.org with ESMTP id S1755263AbWKRRmk
 convert rfc822-to-8bit (ORCPT <rfc822;git@vger.kernel.org>); Sat, 18 Nov 2006
 12:42:40 -0500
Received: by nf-out-0910.google.com with SMTP id o25so1747258nfa for
 <git@vger.kernel.org>; Sat, 18 Nov 2006 09:42:34 -0800 (PST)
Received: by 10.78.128.15 with SMTP id a15mr3393780hud.1163871753637; Sat, 18
 Nov 2006 09:42:33 -0800 (PST)
Received: by 10.78.165.3 with HTTP; Sat, 18 Nov 2006 09:42:33 -0800 (PST)
To: "Jakub Narebski" <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

On 11/18/06, Jakub Narebski <jnareb@gmail.com> wrote:
> Paolo Ciarrocchi wrote:
>
> > Hi all,
> > I'm playing with a repo hosted by repos.os.cz and I think I faced a
> > bug (Pasky confirmed that this should be reported here as a bug).
> >
> > My repo has two branches,
> > * master
> >   html
> >
> > Master contains a text file while html contains his conversion in h=
tml
> > done via asciidoc.
> >
> > I need to URLs that point to the top of the branches in order to ha=
ve
> > an easy way for linking the documentation to external portals.
> >
> > This link points to HEAD, so top of master:
> > http://repo.or.cz/w/LinuxKernelDevelopmentProcess.git?a=3Dblob_plai=
n;f=3DLinuxKernelDevelopmentProcess;hb=3DHEAD
> >
> > Browsing the repo I reach the following URL
> > http://repo.or.cz/w/LinuxKernelDevelopmentProcess.git?a=3Dblob;f=3D=
LinuxKernelDevelopmentProcess.html;hb=3DHEAD
> > that is not accessible.
> Because HEAD is master, not html, and there us no such file in master=
 branch?

=46air enoough but then there should be no link in the web interface.
That sounds like a bug in the interface.

> But all the following links
>  http://repo.or.cz/w/LinuxKernelDevelopmentProcess.git?a=3Dblob;f=3DL=
inuxKernelDevelopmentProcess.html;hb=3Dhtml
>

Yeah, but I would like to see the interpreted page.

http://repo.or.cz/w/LinuxKernelDevelopmentProcess.git?a=3Dblob;f=3DLinu=
xKernelDevelopmentProcess;hb=3Dmaster

That is master not html
  http://repo.or.cz/w/LinuxKernelDevelopmentProcess.git?a=3Dblob;f=3DLi=
nuxKernelDevelopmentProcess;hb=3DHEAD
> works

Same as above.

> You can use
>  http://repo.or.cz/w/LinuxKernelDevelopmentProcess.git/html:/LinuxKer=
nelDevelopmentProcess.html

Yes, thanks! Is it reachable via the web interface?
Is it always pointing to the top of the repo?

> or
>  http://repo.or.cz/w/LinuxKernelDevelopmentProcess.git/html:LinuxKern=
elDevelopmentProcess.html
> (and there is remote possibility that links would work, too)
>
> > Looks like is not possible to obtain a link to the top of a branch
> > different from master.
>
> It is possible, but you must specify the branch.

Well, I don't see how it is possible just browsing with gitweb.
Am I wrong?

> P.S. Please reply also to git mailing list...

Ciao,
--=20
Paolo
http://docs.google.com/View?docid=3Ddhbdhs7d_4hsxqc8
http://www.linkedin.com/pub/0/132/9a3
Non credo nelle otto del mattino. Per=F2 esistono. Le otto del mattino
sono l'incontrovertibile prova della presenza del male nel mondo.
