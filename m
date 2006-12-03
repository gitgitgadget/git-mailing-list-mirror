X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [EGIT PATCH] Convert author and comment on demand.
Date: Sun, 3 Dec 2006 13:18:32 +0100
Message-ID: <200612031318.33332.robin.rosenberg@dewire.com>
References: <200612030145.09576.robin.rosenberg@dewire.com> <20061203021655.GA26668@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Sun, 3 Dec 2006 12:16:36 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: KMail/1.9.4
In-Reply-To: <20061203021655.GA26668@spearce.org>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33107>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GqqGl-0001oN-I1 for gcvg-git@gmane.org; Sun, 03 Dec
 2006 13:16:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757053AbWLCMQT convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Sun, 3 Dec 2006 07:16:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759621AbWLCMQT
 (ORCPT <rfc822;git-outgoing>); Sun, 3 Dec 2006 07:16:19 -0500
Received: from [83.140.172.130] ([83.140.172.130]:41989 "EHLO
 torino.dewire.com") by vger.kernel.org with ESMTP id S1757053AbWLCMQS convert
 rfc822-to-8bit (ORCPT <rfc822;git@vger.kernel.org>); Sun, 3 Dec 2006 07:16:18
 -0500
Received: from localhost (localhost [127.0.0.1]) by torino.dewire.com
 (Postfix) with ESMTP id F3CF3802A94; Sun,  3 Dec 2006 13:12:30 +0100 (CET)
Received: from torino.dewire.com ([127.0.0.1]) by localhost (torino
 [127.0.0.1]) (amavisd-new, port 10024) with ESMTP id 13133-10; Sun,  3 Dec
 2006 13:12:30 +0100 (CET)
Received: from [10.9.0.2] (unknown [10.9.0.2]) by torino.dewire.com (Postfix)
 with ESMTP id 9447180281C; Sun,  3 Dec 2006 13:12:28 +0100 (CET)
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

s=F6ndag 03 december 2006 03:16 skrev Shawn Pearce:
> Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
> > This sppeds up reading commits a lot by only store the byte
> > array data when reading commits.
>
> Thanks.  I was working on something similar but did not have
> a chance to finish it.  I've applied your patch instead.
>
> > +	    try {
> > +        	BufferedReader br=3Dnew BufferedReader(new InputStreamRea=
der(new
> > ByteArrayInputStream(raw)));
> > +        	String n=3Dbr.readLine();
>
> Something's wrong with your mail client... the patch was mangled.

Not really, only the user. KMail by default wraps lines and I didn't tu=
rn that=20
off before sending. Usually I send patches just using stg mail, but thi=
s time=20
I used git-format-patch and kmail. Generatig attachements may be better=
 (next=20
time).

