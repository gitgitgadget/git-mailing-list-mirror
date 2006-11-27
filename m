X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: Mozilla, git and Windows
Date: Mon, 27 Nov 2006 17:37:25 +0100
Organization: Dewire
Message-ID: <200611271737.25733.robin.rosenberg.lists@dewire.com>
References: <9e4733910611270728p36e58e08w6cc7a2989b7843ce@mail.gmail.com> <456B057E.4000904@shadowen.org> <9e4733910611270813g4ff982b0tbe6b57d1d49ca9f7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Mon, 27 Nov 2006 19:09:32 +0000 (UTC)
Cc: "Andy Whitcroft" <apw@shadowen.org>,
	"Git Mailing List" <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: KMail/1.9.4
In-Reply-To: <9e4733910611270813g4ff982b0tbe6b57d1d49ca9f7@mail.gmail.com>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32437>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GolqW-00024G-SX for gcvg-git@gmane.org; Mon, 27 Nov
 2006 20:08:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933172AbWK0TIn convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Mon, 27 Nov 2006 14:08:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933186AbWK0TIn
 (ORCPT <rfc822;git-outgoing>); Mon, 27 Nov 2006 14:08:43 -0500
Received: from [83.140.172.130] ([83.140.172.130]:15136 "EHLO
 torino.dewire.com") by vger.kernel.org with ESMTP id S933065AbWK0TIm convert
 rfc822-to-8bit (ORCPT <rfc822;git@vger.kernel.org>); Mon, 27 Nov 2006
 14:08:42 -0500
Received: from localhost (localhost [127.0.0.1]) by torino.dewire.com
 (Postfix) with ESMTP id 4DB0B8030CA; Mon, 27 Nov 2006 20:05:00 +0100 (CET)
Received: from torino.dewire.com ([127.0.0.1]) by localhost (torino
 [127.0.0.1]) (amavisd-new, port 10024) with ESMTP id 04028-05; Mon, 27 Nov
 2006 20:05:00 +0100 (CET)
Received: from [10.9.0.5] (unknown [10.9.0.5]) by torino.dewire.com (Postfix)
 with ESMTP id DE4E98027E2; Mon, 27 Nov 2006 20:04:57 +0100 (CET)
To: "Jon Smirl" <jonsmirl@gmail.com>
Sender: git-owner@vger.kernel.org

m=E5ndag 27 november 2006 17:13 skrev Jon Smirl:
> On 11/27/06, Andy Whitcroft <apw@shadowen.org> wrote:
> > I think you are more likely to win letting them convert over to SVN=
=2E
> > From there people naturally start using git mirrors from the SVN tr=
unk.
> >  Cirtainly I have two projects which do not use git, one in CVS and=
 one
> > in SVN.  I just svnimport that and work in git.  I am confident wit=
h
> > time the project will migrate, but I am happy other git users are h=
appy
> > all without it being the tool of choice.
>
> The SVN version of the Mozilla repository is about 3GB. It takes
> around a week of CPU time for svnimport to process it.

You can track parts of an SVN repo using git-svn. You rarely need the
whole history to start working on a project.

In addition some nice soul with too much hardware will probably make an=
 import=20
and publish it and track it so everybody won't have to. We see a lot of=
=20
git-tracked repos SVN/CVS already.

