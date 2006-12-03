X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: jgit performance update
Date: Mon, 4 Dec 2006 00:39:00 +0100
Organization: Dewire
Message-ID: <200612040039.00315.robin.rosenberg.lists@dewire.com>
References: <20061203045953.GE26668@spearce.org> <ekv34g$mck$1@sea.gmane.org> <874psceh4z.fsf@freitag.home.jstuber.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Sun, 3 Dec 2006 23:37:11 +0000 (UTC)
Cc: git@vger.kernel.org, jnareb@gmail.com
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: KMail/1.9.4
In-Reply-To: <874psceh4z.fsf@freitag.home.jstuber.net>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33153>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gr0tH-0002xf-0l for gcvg-git@gmane.org; Mon, 04 Dec
 2006 00:36:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1759966AbWLCXgq convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Sun, 3 Dec 2006 18:36:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759739AbWLCXgq
 (ORCPT <rfc822;git-outgoing>); Sun, 3 Dec 2006 18:36:46 -0500
Received: from [83.140.172.130] ([83.140.172.130]:33044 "EHLO
 torino.dewire.com") by vger.kernel.org with ESMTP id S1759963AbWLCXgp convert
 rfc822-to-8bit (ORCPT <rfc822;git@vger.kernel.org>); Sun, 3 Dec 2006 18:36:45
 -0500
Received: from localhost (localhost [127.0.0.1]) by torino.dewire.com
 (Postfix) with ESMTP id 1DEFC80281C; Mon,  4 Dec 2006 00:32:57 +0100 (CET)
Received: from torino.dewire.com ([127.0.0.1]) by localhost (torino
 [127.0.0.1]) (amavisd-new, port 10024) with ESMTP id 19457-02; Mon,  4 Dec
 2006 00:32:56 +0100 (CET)
Received: from [10.9.0.2] (unknown [10.9.0.2]) by torino.dewire.com (Postfix)
 with ESMTP id 9AA33800199; Mon,  4 Dec 2006 00:32:54 +0100 (CET)
To: Juergen Stuber <juergen@jstuber.net>
Sender: git-owner@vger.kernel.org

s=C3=B6ndag 03 december 2006 23:42 skrev Juergen Stuber:
> Hi Jakub,
>
> Jakub Narebski <jnareb@gmail.com> writes:
> > GitWiki tells us about egit/jgit repository at
> >   http://www.spearce.org/projects/scm/egit.git
>
> I tried to access that with git 1.4.4.1 from Debian but
>
> % git clone http://www.spearce.org/projects/scm/egit.git
>
> hangs, the first time after "walk
> e339766abc2b919e7bb396cae22ddef065821381", the second time after "wal=
k
> 9eec90ec5da239e063eaff6305d77294dc03396e" which is the "walk" line ju=
st
> before it.
Works fine here. (git 1.4.4.gf05d).
>
> There's also the following error shortly after the start:
>
> error: File bc01ab9e5fcd26918d7a334207183fa57ff1ce50
> (http://www.spearce.org/projects/scm/egit.git/objects/75/1c8f2e504c40=
d1c41e
>bbd87d8f8968529e9c30) corrupt

Unfortunately, messages about corrupt objects are "normal" with clone o=
ver=20
http. I'm not sure it has to be that way though. Run git-fsck-objects t=
o make=20
sure there are no errors. The hangs aren't normal.

-- robin

