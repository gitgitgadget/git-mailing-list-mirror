X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: Non-ASCII paths and git-cvsserver
Date: Mon, 13 Nov 2006 19:30:18 +0100
Organization: Dewire
Message-ID: <200611131930.18300.robin.rosenberg.lists@dewire.com>
References: <45530CEE.6030008@b-i-t.de> <45587A09.3020605@b-i-t.de> <ej9utk$44p$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Mon, 13 Nov 2006 18:30:44 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: KMail/1.9.4
In-Reply-To: <ej9utk$44p$1@sea.gmane.org>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31309>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GjgYL-0007r2-3X for gcvg-git@gmane.org; Mon, 13 Nov
 2006 19:29:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755318AbWKMS2m convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Mon, 13 Nov 2006 13:28:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755319AbWKMS2m
 (ORCPT <rfc822;git-outgoing>); Mon, 13 Nov 2006 13:28:42 -0500
Received: from [83.140.172.130] ([83.140.172.130]:3665 "EHLO
 torino.dewire.com") by vger.kernel.org with ESMTP id S1755318AbWKMS2l convert
 rfc822-to-8bit (ORCPT <rfc822;git@vger.kernel.org>); Mon, 13 Nov 2006
 13:28:41 -0500
Received: from localhost (localhost [127.0.0.1]) by torino.dewire.com
 (Postfix) with ESMTP id 17574800784; Mon, 13 Nov 2006 19:25:11 +0100 (CET)
Received: from torino.dewire.com ([127.0.0.1]) by localhost (torino
 [127.0.0.1]) (amavisd-new, port 10024) with ESMTP id 21613-06; Mon, 13 Nov
 2006 19:25:10 +0100 (CET)
Received: from [10.9.0.2] (unknown [10.9.0.2]) by torino.dewire.com (Postfix)
 with ESMTP id A7A858003E1; Mon, 13 Nov 2006 19:25:08 +0100 (CET)
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

m=E5ndag 13 november 2006 15:20 skrev Jakub Narebski:
> sf wrote:
> > Thanks, Junio. Paths with umlauts are returned correctly now both i=
n
> > UTF-8 and ISO-8859-1. I guess git-cvsserver is now as encoding agno=
stic
> > as git core.
>
> By the way, now that git has per user config file, ~/.gitconfig, perh=
aps
> it is time to add i18n.filesystemEncoding configuration variable, to
> automatically convert between filesystem encoding (somthing you usual=
ly
> don't have any control over) and UTF-8 encoding of paths in tree obje=
cts.

I'd prefer git to store filenames and comments in UTF-8 and convert on=20
input/output when and if it is necessary rather than forcing everybody =
to=20
take the hit. Most systems, but far from all, already use UTF-8 so it's=
 a=20
noop for them. The only reason I want conversion is for the years to co=
me=20
where we still live in two worlds of non-utf-8 and utf-8 and then forge=
t=20
about everything non-utf-8, rather than carry around the baggage foreve=
r.

