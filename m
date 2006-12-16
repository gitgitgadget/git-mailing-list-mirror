X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: git-fetching from a big repository is slow
Date: Sat, 16 Dec 2006 14:32:59 +0100
Organization: Dewire
Message-ID: <200612161433.00030.robin.rosenberg.lists@dewire.com>
References: <20061214194636.GO1747@spearce.org> <20061214223813.GC26202@spearce.org> <loom.20061215T223909-156@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Sat, 16 Dec 2006 13:30:22 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: KMail/1.9.4
In-Reply-To: <loom.20061215T223909-156@post.gmane.org>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34614>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvZcG-0003w5-ER for gcvg-git@gmane.org; Sat, 16 Dec
 2006 14:30:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751735AbWLPNaM convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Sat, 16 Dec 2006 08:30:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751967AbWLPNaM
 (ORCPT <rfc822;git-outgoing>); Sat, 16 Dec 2006 08:30:12 -0500
Received: from [83.140.172.130] ([83.140.172.130]:12483 "EHLO
 torino.dewire.com" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with
 ESMTP id S1751735AbWLPNaL convert rfc822-to-8bit (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 16 Dec 2006 08:30:11 -0500
Received: from localhost (localhost [127.0.0.1]) by torino.dewire.com
 (Postfix) with ESMTP id 36FDE802658; Sat, 16 Dec 2006 14:26:11 +0100 (CET)
Received: from torino.dewire.com ([127.0.0.1]) by localhost (torino
 [127.0.0.1]) (amavisd-new, port 10024) with ESMTP id 17827-09; Sat, 16 Dec
 2006 14:26:10 +0100 (CET)
Received: from [10.9.0.3] (unknown [10.9.0.3]) by torino.dewire.com (Postfix)
 with ESMTP id DDC9B80019B; Sat, 16 Dec 2006 14:26:08 +0100 (CET)
To: Pazu <pazu@pazu.com.br>
Sender: git-owner@vger.kernel.org

fredag 15 december 2006 22:49 skrev Pazu:
> Shawn Pearce <spearce <at> spearce.org> writes:
> > identical class file given the same input.  I've seen times where
> > it doesn't thanks to the automatic serialVersionUID field being
> > somewhat randomly generated.
>
> Probably offline, but=E2=80=A6 serialVersionUID isn't randomly genera=
ted. It's
> calculated using the types of fields in the class, recursively. The a=
ctual
> algorithm is quite arbitrary, but not random. The automatically gener=
ated
> serialVersionUID should change only if you add/remove class fields (e=
ither
> on the class itself, or to the class of nested objects).

Different java compilers (e.g. SUN's javac and Eclipse) generate slipgh=
tly=20
different code for some cases, including somee synthetic member fields.=
 that=20
get involved in the UID calculation. Neither compiler is wrong. The jav=
a=20
specifications don't cover all cases.

